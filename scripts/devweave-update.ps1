<#
.SYNOPSIS
    DevWeave Autonomous In-Place Plugin Updater & 24h TTL Daily Check
.DESCRIPTION
    Updates DevWeave plugins across all 6 AI coding hosts in-place from remote GitHub releases/repository.
    Includes a 24-hour TTL check to automatically run on the first session of the day with 0 token overhead.
    Updates both user-global host directories and current workspace repositories automatically.
#>
param(
    [switch]$Force = $false,
    [string]$SourceRepo = "https://github.com/paarthivnaik/DevWeave.git",
    [string]$TargetRef = "latest"
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

Write-Host "🔍 Checking for latest DevWeave release (source: $SourceRepo)..." -ForegroundColor Cyan

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
    Write-Host "[DevWeave] Offline or remote unreachable. Using cached plugin version." -ForegroundColor Yellow
    exit 0
}

$tempClone = Join-Path $env:TEMP ("devweave-update-" + [System.Guid]::NewGuid().ToString("N"))

try {
    # Clone latest release or branch
    if ($TargetRef -eq "latest" -or [string]::IsNullOrWhiteSpace($TargetRef)) {
        # Clone default / latest release branch
        git clone --depth 1 $SourceRepo $tempClone 2>&1 | Out-Null
    } else {
        git clone --depth 1 --branch $TargetRef $SourceRepo $tempClone 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            git clone --depth 1 $SourceRepo $tempClone 2>&1 | Out-Null
        }
    }

    if (Test-Path (Join-Path $tempClone "plugins")) {
        $updatedCount = 0

        # 1. Antigravity Global Plugin
        $agyConfigDir = Join-Path $userHome ".gemini\config\plugins\devweave"
        if (Test-Path $agyConfigDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\antigravity\*") -Destination $agyConfigDir -Recurse -Force | Out-Null
            $updatedCount++
        }

        # 2. Claude Code Global Commands & Plugin
        $claudeCommandsDir = Join-Path $userHome ".claude\commands"
        if (Test-Path $claudeCommandsDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\claude\commands\*") -Destination $claudeCommandsDir -Recurse -Force | Out-Null
            $updatedCount++
        }
        $claudePluginDir = Join-Path $userHome ".claude\plugins\devweave"
        if (Test-Path $claudePluginDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\claude\*") -Destination $claudePluginDir -Recurse -Force | Out-Null
            $updatedCount++
        }

        # 3. Gemini CLI Global Commands & Plugin
        $geminiCommandsDir = Join-Path $userHome ".gemini\commands"
        if (Test-Path $geminiCommandsDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\gemini\commands\*") -Destination $geminiCommandsDir -Recurse -Force | Out-Null
            $updatedCount++
        }
        $geminiPluginDir = Join-Path $userHome ".gemini\plugins\devweave"
        if (Test-Path $geminiPluginDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\gemini\*") -Destination $geminiPluginDir -Recurse -Force | Out-Null
            $updatedCount++
        }

        # 4. Local Project Workspace Updating (if executed inside a repo)
        $currentDir = Get-Location
        $workspaceAgentsDir = Join-Path $currentDir ".agents\plugins\devweave"
        if (Test-Path $workspaceAgentsDir) {
            Copy-Item -Path (Join-Path $tempClone "plugins\antigravity\*") -Destination $workspaceAgentsDir -Recurse -Force | Out-Null
            $updatedCount++
            Write-Host "📦 Updated local workspace DevWeave plugin at .agents/plugins/devweave" -ForegroundColor Cyan
        }

        $workspaceGithubPrompts = Join-Path $currentDir ".github\prompts"
        if (Test-Path $workspaceGithubPrompts) {
            Copy-Item -Path (Join-Path $tempClone "plugins\copilot\prompts\*") -Destination $workspaceGithubPrompts -Recurse -Force | Out-Null
            $updatedCount++
            Write-Host "📦 Updated local workspace Copilot prompts at .github/prompts" -ForegroundColor Cyan
        }

        # Save Cache State
        $cacheData = @{
            last_check_timestamp = $now.ToString("o")
            source_repo = $SourceRepo
            target_ref = $TargetRef
            status = "UP_TO_DATE"
        } | ConvertTo-Json

        Set-Content -Path $cacheFile -Value $cacheData -Force
        Write-Host "✨ DevWeave plugins updated successfully to latest release." -ForegroundColor Green
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

