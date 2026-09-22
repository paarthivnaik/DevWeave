<#
.SYNOPSIS
    DevWeave AI-DLC State Transition Conformance Validator
.DESCRIPTION
    Deterministically tests canonical lifecycle progression, failure recovery loops,
    and illegal transition rejection across the 12-state AI-DLC state machine.
#>

param(
    [string]$StateSchemaPath = "D:\DevWeave\conformance\schemas\state.schema.json"
)

$ErrorActionPreference = "Stop"

# Define the canonical transition rules dictionary
$ValidTransitions = @{
    "INIT"               = @("DISCOVERED")
    "DISCOVERED"         = @("REQUIREMENTS_READY")
    "REQUIREMENTS_READY" = @("SOLUTION_READY")
    "SOLUTION_READY"     = @("APPROVED", "APPROVAL_REJECTED")
    "APPROVAL_REJECTED"  = @("SOLUTION_READY", "REQUIREMENTS_READY")
    "APPROVED"           = @("PLANNED")
    "PLANNED"            = @("IMPLEMENTING")
    "IMPLEMENTING"       = @("IMPLEMENTED")
    "IMPLEMENTED"        = @("TESTED", "TEST_FAILED")
    "TEST_FAILED"        = @("FIX_REQUIRED")
    "TESTED"             = @("VERIFIED", "VERIFY_FAILED")
    "VERIFY_FAILED"      = @("FIX_REQUIRED")
    "VERIFIED"           = @("REVIEWING")
    "REVIEWING"          = @("REVIEWED", "REVIEW_FAILED")
    "REVIEW_FAILED"      = @("FIX_REQUIRED")
    "FIX_REQUIRED"       = @("IMPLEMENTING")
    "REVIEWED"           = @("PR_READY")
    "PR_READY"           = @() # Terminal
}

function Test-StateTransition {
    param(
        [string]$CurrentState,
        [string]$TargetState
    )

    if (-not $ValidTransitions.ContainsKey($CurrentState)) {
        return @{ IsValid = $false; Reason = "Unknown source state: '$CurrentState'" }
    }

    $allowed = $ValidTransitions[$CurrentState]
    if ($allowed -contains $TargetState) {
        return @{ IsValid = $true; Reason = "Valid transition from '$CurrentState' to '$TargetState'" }
    }
    else {
        return @{ IsValid = $false; Reason = "Illegal transition: Cannot transition from '$CurrentState' to '$TargetState'. Allowed next states: [$($allowed -join ', ')]" }
    }
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   DevWeave V1.0 State Machine Transition Validator       " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$totalTests = 0
$passedCount = 0
$failedCount = 0

# --- Test Suite 1: Canonical Golden Path ---
Write-Host "`n[Suite 1] Canonical Golden Path Lifecycle..." -ForegroundColor Yellow
$goldenPath = @(
    "INIT", "DISCOVERED", "REQUIREMENTS_READY", "SOLUTION_READY",
    "APPROVED", "PLANNED", "IMPLEMENTING", "IMPLEMENTED",
    "TESTED", "VERIFIED", "REVIEWING", "REVIEWED", "PR_READY"
)

for ($i = 0; $i -lt $goldenPath.Count - 1; $i++) {
    $from = $goldenPath[$i]
    $to = $goldenPath[$i + 1]
    $totalTests++

    $res = Test-StateTransition -CurrentState $from -TargetState $to
    if ($res.IsValid) {
        Write-Host "  [PASS] $from -> $to (Valid step)" -ForegroundColor Green
        $passedCount++
    } else {
        Write-Host "  [FAIL] $from -> $to failed: $($res.Reason)" -ForegroundColor Red
        $failedCount++
    }
}

# --- Test Suite 2: Failure Recovery Loops ---
Write-Host "`n[Suite 2] Failure and Recovery Transitions..." -ForegroundColor Yellow
$recoveryPairs = @(
    @{ From = "SOLUTION_READY"; To = "APPROVAL_REJECTED" },
    @{ From = "APPROVAL_REJECTED"; To = "SOLUTION_READY" },
    @{ From = "IMPLEMENTED"; To = "TEST_FAILED" },
    @{ From = "TEST_FAILED"; To = "FIX_REQUIRED" },
    @{ From = "FIX_REQUIRED"; To = "IMPLEMENTING" },
    @{ From = "TESTED"; To = "VERIFY_FAILED" },
    @{ From = "VERIFY_FAILED"; To = "FIX_REQUIRED" },
    @{ From = "REVIEWING"; To = "REVIEW_FAILED" },
    @{ From = "REVIEW_FAILED"; To = "FIX_REQUIRED" }
)

foreach ($pair in $recoveryPairs) {
    $totalTests++
    $res = Test-StateTransition -CurrentState $pair.From -TargetState $pair.To
    if ($res.IsValid) {
        Write-Host "  [PASS] $($pair.From) -> $($pair.To) (Valid recovery transition)" -ForegroundColor Green
        $passedCount++
    } else {
        Write-Host "  [FAIL] $($pair.From) -> $($pair.To) failed: $($res.Reason)" -ForegroundColor Red
        $failedCount++
    }
}

# --- Test Suite 3: Illegal Transition Rejection ---
Write-Host "`n[Suite 3] Illegal Transition Rejections (Negative Guards)..." -ForegroundColor Yellow
$illegalPairs = @(
    @{ From = "INIT"; To = "IMPLEMENTING"; Reason = "Skipping requirements & planning" },
    @{ From = "SOLUTION_READY"; To = "PLANNED"; Reason = "Bypassing mandatory approval gate" },
    @{ From = "IMPLEMENTED"; To = "REVIEWING"; Reason = "Bypassing testing & verification" },
    @{ From = "TEST_FAILED"; To = "PR_READY"; Reason = "Bypassing fix loop after failed tests" },
    @{ From = "VERIFIED"; To = "PR_READY"; Reason = "Bypassing code review" },
    @{ From = "INIT"; To = "TESTED"; Reason = "Unreachable transition" },
    @{ From = "PR_READY"; To = "INIT"; Reason = "Transitioning out of terminal state" }
)

foreach ($pair in $illegalPairs) {
    $totalTests++
    $res = Test-StateTransition -CurrentState $pair.From -TargetState $pair.To
    if (-not $res.IsValid) {
        Write-Host "  [PASS] Rejected $($pair.From) -> $($pair.To) correctly ($($pair.Reason))" -ForegroundColor Green
        $passedCount++
    } else {
        Write-Host "  [FAIL] Illegal transition $($pair.From) -> $($pair.To) was erroneously permitted!" -ForegroundColor Red
        $failedCount++
    }
}

Write-Host "----------------------------------------------------------"
$summaryColor = if ($failedCount -eq 0) { "Green" } else { "Red" }
Write-Host "Summary: Total=$totalTests, Passed=$passedCount, Failed=$failedCount" -ForegroundColor $summaryColor

if ($failedCount -gt 0) {
    exit 1
} else {
    exit 0
}
