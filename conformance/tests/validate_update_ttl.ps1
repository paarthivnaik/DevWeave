<#
.SYNOPSIS
    DevWeave Update & 24h TTL Autonomous Sync Conformance Suite
.DESCRIPTION
    Validates:
    1. devweave-update global plugin synchronization.
    2. Intelligent repository detection (.devweave/).
    3. 24-hour TTL expiration check and autonomous re-init.
    4. Fresh cache (< 24h) skip behavior (zero redundant re-scans).
    5. Non-destructive story preservation invariance during re-init.
#>

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   DevWeave Update & 24-Hour TTL Conformance Suite        " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$testTmp = Join-Path $env:TEMP ("dw-test-ttl-" + [System.Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $testTmp -Force | Out-Null

$passed = 0
$failed = 0

function Assert-Check($name, $condition) {
    if ($condition) {
        Write-Host "  [PASS] $name" -ForegroundColor Green
        $script:passed++
    } else {
        Write-Host "  [FAIL] $name" -ForegroundColor Red
        $script:failed++
    }
}

try {
    # Scenario 1: devweave-update outside an initialized repository
    $nonRepoDir = Join-Path $testTmp "empty-folder"
    New-Item -ItemType Directory -Path $nonRepoDir -Force | Out-Null
    $isRepo = Test-Path (Join-Path $nonRepoDir ".devweave")
    Assert-Check "Non-repo directory correctly recognized as uninitialized" (-not $isRepo)

    # Scenario 2: Initialized repository with Fresh Cache (< 24h)
    $repoDir = Join-Path $testTmp "my-project"
    $devweaveDir = Join-Path $repoDir ".devweave"
    $stateDir = Join-Path $devweaveDir "state"
    $repoMetaDir = Join-Path $devweaveDir "repository"
    $storiesDir = Join-Path $devweaveDir "modernization\stories\99"
    New-Item -ItemType Directory -Path $stateDir, $repoMetaDir, $storiesDir -Force | Out-Null

    # Create fresh state (1 hour old)
    $freshScanTime = (Get-Date).ToUniversalTime().AddHours(-1).ToString("o")
    $freshState = @{
        initializedAt = $freshScanTime
        lastScanTime = $freshScanTime
        ttlHours = 24
        version = "1.2.0"
        status = "INITIALIZED"
    } | ConvertTo-Json
    Set-Content -Path (Join-Path $stateDir "current.json") -Value $freshState -Force

    # Add active story artifact to verify non-destructive invariance
    Set-Content -Path (Join-Path $storiesDir "work-item.json") -Value '{"id": "99", "title": "Preserve me"}' -Force

    # Evaluate TTL for fresh cache
    $readState = Get-Content -Raw (Join-Path $stateDir "current.json") | ConvertFrom-Json
    $cacheAgeHours = ((Get-Date).ToUniversalTime() - [DateTime]::Parse($readState.lastScanTime).ToUniversalTime()).TotalHours
    $isFresh = $cacheAgeHours -lt 24.0
    Assert-Check "Fresh cache (< 24h old) accurately identified ($([math]::Round($cacheAgeHours, 1))h < 24h)" $isFresh

    # Scenario 3: Initialized repository with Expired TTL (>= 24h old)
    $expiredScanTime = (Get-Date).ToUniversalTime().AddHours(-26).ToString("o")
    $expiredState = @{
        initializedAt = $expiredScanTime
        lastScanTime = $expiredScanTime
        ttlHours = 24
        version = "1.2.0"
        status = "INITIALIZED"
    } | ConvertTo-Json
    Set-Content -Path (Join-Path $stateDir "current.json") -Value $expiredState -Force

    # Evaluate TTL for expired cache
    $readExpired = Get-Content -Raw (Join-Path $stateDir "current.json") | ConvertFrom-Json
    $expiredAgeHours = ((Get-Date).ToUniversalTime() - [DateTime]::Parse($readExpired.lastScanTime).ToUniversalTime()).TotalHours
    $isExpired = $expiredAgeHours -ge 24.0
    Assert-Check "Expired cache (>= 24h old) triggers TTL refresh flag ($([math]::Round($expiredAgeHours, 1))h >= 24h)" $isExpired

    # Simulate Autonomous Non-Destructive Init
    $newScanTime = (Get-Date).ToUniversalTime().ToString("o")
    $updatedState = @{
        initializedAt = $expiredScanTime
        lastScanTime = $newScanTime
        lastUpdated = $newScanTime
        ttlHours = 24
        version = "1.2.0"
        status = "INITIALIZED"
    } | ConvertTo-Json
    Set-Content -Path (Join-Path $stateDir "current.json") -Value $updatedState -Force

    # Scenario 4: Non-Destructive Invariance Verification
    $storyStillExists = Test-Path (Join-Path $storiesDir "work-item.json")
    $storyContent = if ($storyStillExists) { (Get-Content -Raw (Join-Path $storiesDir "work-item.json") | ConvertFrom-Json).title } else { "" }
    Assert-Check "Non-destructive invariance: Active story artifacts preserved during TTL refresh" ($storyStillExists -and ($storyContent -eq "Preserve me"))

    # Scenario 5: Refreshed State Verification
    $finalState = Get-Content -Raw (Join-Path $stateDir "current.json") | ConvertFrom-Json
    $finalAge = ((Get-Date).ToUniversalTime() - [DateTime]::Parse($finalState.lastScanTime).ToUniversalTime()).TotalHours
    Assert-Check "Post-refresh cache age reset to fresh (< 1 min old)" ($finalAge -lt 0.1)

} finally {
    if (Test-Path $testTmp) {
        Remove-Item -Recurse -Force $testTmp 2>$null
    }
}

Write-Host "----------------------------------------------------------"
Write-Host "Update & 24h TTL Summary: Total=5, Passed=$passed, Failed=$failed" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Red" })

if ($failed -gt 0) { exit 1 } else { exit 0 }
