<#
.SYNOPSIS
    DevWeave V1.0 Master Conformance & Release Readiness Test Suite
.DESCRIPTION
    Executes all conformance validation suites across schemas, state machine,
    18 end-to-end scenarios, 12 polyglot targets, and efficiency benchmarks.
#>

$ErrorActionPreference = "Stop"

Write-Host "=================================================================" -ForegroundColor Magenta
Write-Host "   DEVWEAVE V1.0 MASTER CONFORMANCE & RELEASE READINESS SUITE    " -ForegroundColor Magenta
Write-Host "=================================================================" -ForegroundColor Magenta

$tests = @(
    @{ Name = "JSON Schema Validation Suite"; Script = "conformance/tests/validate_schemas.ps1" },
    @{ Name = "AI-DLC State Machine Transition Suite"; Script = "conformance/tests/validate_state_transitions.ps1" },
    @{ Name = "18 Conformance Scenarios Suite"; Script = "conformance/tests/run_scenarios.ps1" },
    @{ Name = "12-Ecosystem Technology Neutrality Suite"; Script = "conformance/tests/validate_tech_neutrality.ps1" },
    @{ Name = "Multi-Repository .devweave Initialization Suite"; Script = "conformance/tests/init_all_fixtures.ps1" },
    @{ Name = "Token & Cost Efficiency Benchmark Suite"; Script = "conformance/tests/measure_efficiency.ps1" },
    @{ Name = "V1.1 Modernization CLI Contract Suite"; Script = "conformance/tests/validate_modernization_cli.ps1" },
    @{ Name = "V1.1 Modernization State Machine Suite"; Script = "conformance/tests/validate_modernization_state.ps1" },
    @{ Name = "V1.1 Modernization Modules & E2E Suite"; Script = "conformance/tests/validate_modernization_e2e.ps1" },
    @{ Name = "V1.0/V1.1 Test Intelligence Suite"; Script = "conformance/tests/validate_test_intelligence.ps1" },
    @{ Name = "V1.2 Work Item Context Acquisition Suite"; Script = "conformance/tests/validate_context_acquisition.ps1" },
    @{ Name = "V1.2 Update & 24h TTL Sync Suite"; Script = "conformance/tests/validate_update_ttl.ps1" }
)

$suiteResults = @()
$allPassed = $true

foreach ($t in $tests) {
    Write-Host "`n>>> Running: $($t.Name)..." -ForegroundColor Yellow
    $fullPath = Join-Path "D:\DevWeave" $t.Script
    
    $startTime = Get-Date
    try {
        & powershell -ExecutionPolicy Bypass -File $fullPath
        if ($LASTEXITCODE -eq 0) {
            $duration = ((Get-Date) - $startTime).TotalSeconds
            Write-Host ">>> [SUCCESS] $($t.Name) passed in $($duration.ToString('F2'))s" -ForegroundColor Green
            $suiteResults += [PSCustomObject]@{
                Suite = $t.Name
                Status = "PASSED"
                Duration = "$($duration.ToString('F2'))s"
            }
        } else {
            $allPassed = $false
            Write-Host ">>> [FAILURE] $($t.Name) exited with code $LASTEXITCODE" -ForegroundColor Red
            $suiteResults += [PSCustomObject]@{
                Suite = $t.Name
                Status = "FAILED"
                Duration = "N/A"
            }
        }
    } catch {
        $allPassed = $false
        Write-Host ">>> [EXCEPTION] $($t.Name): $($_.Message)" -ForegroundColor Red
        $suiteResults += [PSCustomObject]@{
            Suite = $t.Name
            Status = "EXCEPTION"
            Duration = "N/A"
        }
    }
}

Write-Host "`n=================================================================" -ForegroundColor Magenta
Write-Host "                     SUITE EXECUTION SUMMARY                    " -ForegroundColor Magenta
Write-Host "=================================================================" -ForegroundColor Magenta

foreach ($r in $suiteResults) {
    $color = if ($r.Status -eq "PASSED") { "Green" } else { "Red" }
    Write-Host "  [$($r.Status)] $($r.Suite.PadRight(45)) ($($r.Duration))" -ForegroundColor $color
}

Write-Host "-----------------------------------------------------------------"
if ($allPassed) {
    Write-Host "RELEASE CANDIDATE STATUS: 100% CONFORMANCE VERIFIED (ALL SUITES PASSED)" -ForegroundColor Green
    exit 0
} else {
    Write-Host "RELEASE CANDIDATE STATUS: FAILED CHECKS DETECTED" -ForegroundColor Red
    exit 1
}
