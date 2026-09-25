<#
.SYNOPSIS
    DevWeave AI-DLC State Transition Conformance Validator
.DESCRIPTION
    Deterministically tests canonical lifecycle progression, failure recovery loops,
    illegal transition rejection across normal development & modernization workflows,
    base init prerequisite gates, resume branch validation, and staleness handling.
#>

param(
    [string]$StateSchemaPath = "D:\DevWeave\conformance\schemas\state.schema.json"
)

$ErrorActionPreference = "Stop"

# Define the canonical transition rules dictionary
$ValidTransitions = @{
    "INIT"               = @("DISCOVERED", "CONTEXT")
    "DISCOVERED"         = @("REQUIREMENTS_READY", "CONTEXT")
    "CONTEXT"            = @("ANALYZE")
    "REQUIREMENTS_READY" = @("SOLUTION_READY")
    "SOLUTION_READY"     = @("APPROVED", "APPROVAL_REJECTED")
    "APPROVAL_REJECTED"  = @("SOLUTION_READY", "REQUIREMENTS_READY")
    "ANALYZE"            = @("PLAN", "WAITING_APPROVAL")
    "APPROVED"           = @("PLAN", "PLANNED")
    "PLANNED"            = @("BRANCH", "IMPLEMENTING")
    "PLAN"               = @("BRANCH", "WAITING_APPROVAL")
    "BRANCH"             = @("IMPLEMENT", "IMPLEMENTING")
    "IMPLEMENTING"       = @("IMPLEMENTED")
    "IMPLEMENT"          = @("PR_REVIEW", "VERIFY", "TESTED")
    "IMPLEMENTED"        = @("TESTED", "TEST_FAILED")
    "TEST_FAILED"        = @("FIX_REQUIRED")
    "TESTED"             = @("VERIFIED", "VERIFY_FAILED", "PR_REVIEW")
    "VERIFY_FAILED"      = @("FIX_REQUIRED")
    "VERIFIED"           = @("REVIEWING", "PR_REVIEW", "PR")
    "REVIEWING"          = @("REVIEWED", "REVIEW_FAILED")
    "PR_REVIEW"          = @("PR", "CHANGES_REQUESTED", "WAITING_APPROVAL")
    "REVIEW_FAILED"      = @("FIX_REQUIRED")
    "FIX_REQUIRED"       = @("IMPLEMENTING", "IMPLEMENT")
    "REVIEWED"           = @("PR_READY", "PR")
    "PR_READY"           = @("PR", "COMPLETED")
    "PR"                 = @("COMPLETED")
    "COMPLETED"          = @() # Terminal
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
Write-Host "   DevWeave Dual-Workflow State Machine Validator         " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$totalTests = 0
$passedCount = 0
$failedCount = 0

# --- Test Suite 1: Canonical Golden Path Lifecycle ---
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

# --- Test Suite 2: Normal Development 7-Phase Progression ---
Write-Host "`n[Suite 2] Normal Development 7-Phase Progression..." -ForegroundColor Yellow
$normalPhases = @("INIT", "CONTEXT", "ANALYZE", "PLAN", "BRANCH", "IMPLEMENT", "PR_REVIEW", "PR")
for ($i = 0; $i -lt $normalPhases.Count - 1; $i++) {
    $from = $normalPhases[$i]
    $to = $normalPhases[$i + 1]
    $totalTests++

    $res = Test-StateTransition -CurrentState $from -TargetState $to
    if ($res.IsValid) {
        Write-Host "  [PASS] Normal Phase: $from -> $to (Valid progression)" -ForegroundColor Green
        $passedCount++
    } else {
        Write-Host "  [FAIL] Normal Phase $from -> $to failed: $($res.Reason)" -ForegroundColor Red
        $failedCount++
    }
}

# --- Test Suite 3: Failure and Recovery Transitions ---
Write-Host "`n[Suite 3] Failure and Recovery Transitions..." -ForegroundColor Yellow
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

# --- Test Suite 4: Base Init Prerequisite Gate ---
Write-Host "`n[Suite 4] Base devweave-init Prerequisite Enforcement..." -ForegroundColor Yellow

function Assert-BaseInitPrerequisite {
    param(
        [bool]$IsBaseInitialized,
        [string]$TargetCommand
    )
    if (-not $IsBaseInitialized) {
        return @{
            Blocked = $true
            ErrorMessage = if ($TargetCommand -eq "devweave-modernization-init") {
                "DevWeave base initialization is required. Run: devweave-init"
            } else {
                "DevWeave has not been initialized for this repository. Run: devweave-init before continuing."
            }
        }
    }
    return @{ Blocked = $false }
}

$normalCommands = @("devweave-context", "devweave-analyze", "devweave-plan", "devweave-branch", "devweave-implement", "devweave-pr-review", "devweave-pr")
foreach ($cmd in $normalCommands) {
    $totalTests++
    $gate = Assert-BaseInitPrerequisite -IsBaseInitialized $false -TargetCommand $cmd
    if ($gate.Blocked -and $gate.ErrorMessage -match "DevWeave has not been initialized for this repository") {
        Write-Host "  [PASS] Correctly blocked '$cmd' prior to base devweave-init" -ForegroundColor Green
        $passedCount++
    } else {
        Write-Host "  [FAIL] Failed to block '$cmd' when uninitialized" -ForegroundColor Red
        $failedCount++
    }
}

# Base init prerequisite for devweave-modernization-init
$totalTests++
$modInitGate = Assert-BaseInitPrerequisite -IsBaseInitialized $false -TargetCommand "devweave-modernization-init"
if ($modInitGate.Blocked -and $modInitGate.ErrorMessage -eq "DevWeave base initialization is required. Run: devweave-init") {
    Write-Host "  [PASS] Correctly blocked 'devweave-modernization-init' prior to base devweave-init" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Failed to block 'devweave-modernization-init' when base uninitialized" -ForegroundColor Red
    $failedCount++
}

# --- Test Suite 5: Resume & Branch Alignment Validation ---
Write-Host "`n[Suite 5] Resume & Branch Validation..." -ForegroundColor Yellow

function Test-ResumeBranchValidation {
    param(
        [string]$ExpectedBranch,
        [string]$CurrentGitBranch
    )
    if ($ExpectedBranch -ne $CurrentGitBranch) {
        return @{
            Mismatch = $true
            Action = "PROMPT_USER"
            Message = "Story is associated with: $ExpectedBranch. Current branch: $CurrentGitBranch."
        }
    }
    return @{ Mismatch = $false; Action = "PROCEED" }
}

$branchCheck = Test-ResumeBranchValidation -ExpectedBranch "feature/98" -CurrentGitBranch "development"
$totalTests++
if ($branchCheck.Mismatch -and $branchCheck.Action -eq "PROMPT_USER") {
    Write-Host "  [PASS] Detected branch mismatch on resume -> Prompted developer before switching" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Branch mismatch test failed" -ForegroundColor Red
    $failedCount++
}

# --- Test Suite 6: Downstream Artifact Staleness Invalidation ---
Write-Host "`n[Suite 6] Artifact Staleness Invalidation..." -ForegroundColor Yellow

function Test-ArtifactStaleness {
    param(
        [datetime]$ContextTimestamp,
        [datetime]$AnalysisTimestamp,
        [datetime]$PlanTimestamp
    )
    $planStale = $false
    $analysisStale = $false

    if ($ContextTimestamp -gt $AnalysisTimestamp) {
        $analysisStale = $true
        $planStale = $true
    } elseif ($AnalysisTimestamp -gt $PlanTimestamp) {
        $planStale = $true
    }

    return @{
        AnalysisStale = $analysisStale
        PlanStale = $planStale
    }
}

$staleness = Test-ArtifactStaleness -ContextTimestamp (Get-Date "2026-09-25 10:00:00") -AnalysisTimestamp (Get-Date "2026-09-25 09:00:00") -PlanTimestamp (Get-Date "2026-09-25 09:30:00")
$totalTests++
if ($staleness.AnalysisStale -and $staleness.PlanStale) {
    Write-Host "  [PASS] Context update correctly marked downstream analysis and plan as STALE" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Staleness detection failed" -ForegroundColor Red
    $failedCount++
}

# --- Test Suite 7: Illegal Transition Rejection ---
Write-Host "`n[Suite 7] Illegal Transition Rejections (Negative Phase Blockers)..." -ForegroundColor Yellow
$illegalPairs = @(
    @{ From = "INIT"; To = "IMPLEMENTING"; Reason = "Skipping requirements & planning" },
    @{ From = "SOLUTION_READY"; To = "PLANNED"; Reason = "Bypassing mandatory approval gate" },
    @{ From = "IMPLEMENTED"; To = "REVIEWING"; Reason = "Bypassing testing & verification" },
    @{ From = "TEST_FAILED"; To = "PR_READY"; Reason = "Bypassing fix loop after failed tests" },
    @{ From = "VERIFIED"; To = "PR_READY"; Reason = "Bypassing code review" },
    @{ From = "INIT"; To = "TESTED"; Reason = "Unreachable transition" },
    @{ From = "CONTEXT"; To = "PLAN"; Reason = "Bypassing deep analysis" },
    @{ From = "ANALYZE"; To = "BRANCH"; Reason = "Bypassing plan creation" },
    @{ From = "PLAN"; To = "IMPLEMENT"; Reason = "Bypassing branch isolation" },
    @{ From = "IMPLEMENT"; To = "PR"; Reason = "Bypassing PR review" }
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
