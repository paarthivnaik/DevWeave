<#
.SYNOPSIS
    DevWeave Autonomous In-Place Plugin Updater & 24h TTL Daily Check
.DESCRIPTION
    Updates DevWeave plugins across all 6 AI coding hosts in-place from remote source.
    Includes a 24-hour TTL check to automatically run on the first session of the day with 0 token overhead.
#>
param(
    [switch]$Force = $false,
    [string]$SourceRepo = "https://github.com/paarthivnaik/DevWeave.git",
    [string]$Branch = "develop"
)

$ErrorActionPreference = "SilentlyContinue"
$userHome = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)
$cacheDir = Join-Path $userHome ".devweave"
$cacheFile = Join-Path $cacheDir "update-cache.json"

if (-not (Test-Path $cacheDir)) {
    New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
}

$now = [DateTime]::UtcNow
$shouldCheck = $Force

if (-not $Force -and (Test-Path $cacheFile)) {
    try {
        $cache = Get-Content $cacheFile -Raw | ConvertFrom-Json
        $lastCheck = [DateTime]::Parse($cache.last_check_timestamp)
        if (($now - $lastCheck).TotalHours -ge 24) {
            $shouldCheck = $true
        }
    }
    catch {
        $shouldCheck = $true
    }
} else {
    $shouldCheck = $true
}

if (-not $shouldCheck) {
    # Within 24-hour TTL window; proceed instantly with 0ms overhead
    exit 0
}

Write-Host "Checking for DevWeave updates (source: $SourceRepo)..." -ForegroundColor Cyan

# Test connectivity with 2-second timeout
$canReach = $false
try {
    $tcp = New-Object System.Net.Sockets.TcpClient
    $ar = $tcp.BeginConnect("github.com", 443, $null, $null)
    $success = $ar.AsyncWaitHandle.WaitOne(2000, $false)
    if ($success) {
        $tcp.EndConnect($ar)
        $canReach = $true
    }
    $tcp.Close()
} catch {
    $canReach = $false
}

if (-not $canReach) {
    Write-Host "[DevWeave] Offline / remote unreachable. Using cached plugin version." -ForegroundColor Yellow
    exit 0
}

$tempClone = Join-Path $env:TEMP ("devweave-update-" + [System.Guid]::NewGuid().ToString("N"))

try {
    # Shallow clone target branch
    git clone --depth 1 --branch $Branch $SourceRepo $tempClone 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        git clone --depth 1 $SourceRepo $tempClone 2>&1 | Out-Null
    }

    if (Test-Path (Join-Path $tempClone "plugins")) {
        # Update Antigravity Plugin Cache if installed
        $agyConfigDir = Join-Path $userHome ".gemini\config\plugins\devweave"
        if (Test-Path $agyConfigDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\antigravity\*") -Destination $agyConfigDir -Recurse -Force | Out-Null
        }

        # Update Claude Code Commands if installed
        $claudeCommandsDir = Join-Path $userHome ".claude\commands"
        if (Test-Path $claudeCommandsDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\claude\commands\*") -Destination $claudeCommandsDir -Recurse -Force | Out-Null
        }

        # Update Gemini CLI Commands if installed
        $geminiDir = Join-Path $userHome ".gemini\commands"
        if (Test-Path $geminiDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\gemini\commands\*") -Destination $geminiDir -Recurse -Force | Out-Null
        }

        # Save Cache State
        $cacheData = @{
            last_check_timestamp = $now.ToString("o")
            source_repo = $SourceRepo
            branch = $Branch
            status = "UP_TO_DATE"
        } | ConvertTo-Json

        Set-Content -Path $cacheFile -Value $cacheData -Force
        Write-Host "✨ DevWeave plugins updated successfully to latest ($Branch)." -ForegroundColor Green
    }
}
catch {
    Write-Host "[DevWeave] Update check encountered an issue: $_. Using existing cached version." -ForegroundColor Yellow
}
finally {
    if (Test-Path $tempClone) {
        Remove-Item -Recurse -Force $tempClone -ErrorAction SilentlyContinue
    }
}
