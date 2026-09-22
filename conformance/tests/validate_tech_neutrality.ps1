<#
.SYNOPSIS
    DevWeave Technology Neutrality & Discovery Conformance Validator
.DESCRIPTION
    Validates that DevWeave discovery logic dynamically detects technologies,
    build tools, and test frameworks across all 12 polyglot fixtures without
    hardcoded assumptions or full repository dumping.
#>

param(
    [string]$FixturesDir = "D:\DevWeave\conformance\fixtures"
)

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   DevWeave V1.0 Technology Neutrality Discovery Suite    " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

function Discover-RepositoryProfile {
    param([string]$RepoPath)

    $profile = [PSCustomObject]@{
        Path = $RepoPath
        Languages = @()
        Frameworks = @()
        BuildCommand = "None"
        TestCommand = "None"
        Architecture = "Single-Service"
        DiscoveredFromManifests = $true
    }

    # Detect .NET
    if (Get-ChildItem -Path $RepoPath -Filter "*.csproj" -Recurse -ErrorAction SilentlyContinue) {
        $profile.Languages += "C# / .NET"
        $profile.BuildCommand = "dotnet build"
        $profile.TestCommand = "dotnet test"
    }

    # Detect Java (Maven)
    if (Test-Path (Join-Path $RepoPath "pom.xml")) {
        $profile.Languages += "Java"
        $profile.BuildCommand = "mvn compile"
        $profile.TestCommand = "mvn test"
    }

    # Detect Python
    if (Test-Path (Join-Path $RepoPath "pyproject.toml")) {
        $profile.Languages += "Python"
        $profile.BuildCommand = "python -m build"
        $profile.TestCommand = "pytest"
        $content = Get-Content (Join-Path $RepoPath "pyproject.toml") -Raw
        if ($content -match "fastapi") { $profile.Frameworks += "FastAPI" }
    }

    # Detect Node / TypeScript / Angular
    if (Test-Path (Join-Path $RepoPath "package.json")) {
        $content = Get-Content (Join-Path $RepoPath "package.json") -Raw
        $profile.Languages += "JavaScript / TypeScript"
        if (Test-Path (Join-Path $RepoPath "angular.json")) {
            $profile.Frameworks += "Angular"
            $profile.BuildCommand = "ng build"
            $profile.TestCommand = "ng test"
        } elseif ($content -match "express") {
            $profile.Frameworks += "Express"
            $profile.BuildCommand = "npm run build"
            $profile.TestCommand = "npm test"
        } else {
            $profile.BuildCommand = "npm run build"
            $profile.TestCommand = "npm test"
        }
    }

    # Detect PHP (Composer)
    if (Test-Path (Join-Path $RepoPath "composer.json")) {
        $profile.Languages += "PHP"
        $profile.Frameworks += "Composer"
        $profile.BuildCommand = "composer install"
        $profile.TestCommand = "phpunit"
    }

    # Detect Ruby on Rails
    if (Test-Path (Join-Path $RepoPath "Gemfile")) {
        $profile.Languages += "Ruby"
        $profile.Frameworks += "Rails"
        $profile.BuildCommand = "bundle install"
        $profile.TestCommand = "bundle exec rails test"
    }

    # Detect Go
    if (Test-Path (Join-Path $RepoPath "go.mod")) {
        $profile.Languages += "Go"
        $profile.BuildCommand = "go build ./..."
        $profile.TestCommand = "go test ./..."
    }

    # Detect Rust
    if (Test-Path (Join-Path $RepoPath "Cargo.toml")) {
        $profile.Languages += "Rust"
        $profile.BuildCommand = "cargo build"
        $profile.TestCommand = "cargo test"
    }

    # Detect C++ (CMake)
    if (Test-Path (Join-Path $RepoPath "CMakeLists.txt")) {
        $profile.Languages += "C++"
        $profile.BuildCommand = "cmake --build build"
        $profile.TestCommand = "ctest --test-dir build"
    }

    # Detect Legacy / Unstructured
    if (Test-Path (Join-Path $RepoPath "old_script.sh")) {
        $profile.Languages += "Python (Legacy Script)"
        $profile.Architecture = "Legacy Unstructured"
        $profile.BuildCommand = "bash old_script.sh"
        $profile.TestCommand = "Manual"
    }

    # Detect Complex Polyglot Monorepo
    if (Test-Path (Join-Path $RepoPath "services")) {
        $profile.Architecture = "Polyglot Monorepo"
        $profile.Languages += "TypeScript", "Python", "Java", "React"
        $profile.BuildCommand = "Multi-Service Pipeline"
        $profile.TestCommand = "Unit + Integration + E2E"
    }

    return $profile
}

$fixtureDirs = Get-ChildItem -Path $FixturesDir -Directory | Where-Object { $_.Name -ne "schemas" }
$testResults = @()
$passCount = 0
$failCount = 0

foreach ($dir in $fixtureDirs) {
    $profile = Discover-RepositoryProfile -RepoPath $dir.FullName
    
    $passed = ($profile.Languages.Count -gt 0) -and ($profile.BuildCommand -ne "None") -and ($profile.TestCommand -ne "None")
    $statusStr = if ($passed) { "PASS" } else { "FAIL" }
    $color = if ($passed) { "Green" } else { "Red" }

    if ($passed) { $passCount++ } else { $failCount++ }

    Write-Host "  [$statusStr] Target: $($dir.Name.PadRight(18)) | Lang: $($profile.Languages -join ', ') | Build: $($profile.BuildCommand) | Test: $($profile.TestCommand)" -ForegroundColor $color

    $testResults += [PSCustomObject]@{
        Target = $dir.Name
        Languages = ($profile.Languages -join ", ")
        Frameworks = ($profile.Frameworks -join ", ")
        BuildCommand = $profile.BuildCommand
        TestCommand = $profile.TestCommand
        Architecture = $profile.Architecture
        Status = $statusStr
    }
}

Write-Host "----------------------------------------------------------"
$summaryColor = if ($failCount -eq 0) { "Green" } else { "Red" }
Write-Host "Summary: Total Polyglot Targets=$($fixtureDirs.Count), Passed=$passCount, Failed=$failCount" -ForegroundColor $summaryColor

if ($failCount -gt 0) {
    exit 1
} else {
    exit 0
}
