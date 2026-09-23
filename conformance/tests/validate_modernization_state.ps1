<#
.SYNOPSIS
    DevWeave V1.1 Modernization State Machine Conformance Validator
.DESCRIPTION
    Validates the 8-phase modernization state machine, hard gate checkpoints,
    human decisions, error recovery, and rejection of illegal phase progression.
#>

$ErrorActionPreference = "Stop"

# State progression rules for Modernization Lifecycle
$ModernizationPhases = @("INIT", "CONTEXT", "ANALYZE", "PLAN", "BRANCH", "IMPLEMENT", "VERIFY", "PR")

function New-ModernizationState {
    param(
        [string]$Id = "MOD-001"
    )

    return [PSCustomObject]@{
        id = $Id
        type = "MODERNIZATION"
        currentPhase = "INIT"
        status = "IN_PROGRESS"
        phases = [PSCustomObject]@{
            INIT = "COMPLETED"
            CONTEXT = "PENDING"
            ANALYZE = "PENDING"
            PLAN = "PENDING"
            BRANCH = "PENDING"
            IMPLEMENT = "PENDING"
            VERIFY = "PENDING"
            PR = "PENDING"
        }
        nextSuggestedPhase = "CONTEXT"
        humanDecisions = @()
        branch = [PSCustomObject]@{
            name = $null
            created = $false
            checkedOut = $false
        }
        updated_at = (Get-Date -Format "o")
    }
}

function Test-CanExecuteModernizationPhase {
    param(
        [PSCustomObject]$State,
        [string]$TargetPhase
    )

    switch ($TargetPhase) {
        "INIT" {
            return @{ Allowed = $true; Reason = "INIT can always start or re-initialize." }
        }
        "CONTEXT" {
            if ($State.phases.INIT -ne "COMPLETED") {
                return @{ Allowed = $false; Reason = "CONTEXT cannot start. Required: INIT = COMPLETED. Current: INIT = $($State.phases.INIT)" }
            }
            return @{ Allowed = $true; Reason = "Preconditions met for CONTEXT." }
        }
        "ANALYZE" {
            if ($State.phases.CONTEXT -ne "COMPLETED") {
                return @{ Allowed = $false; Reason = "ANALYZE cannot start. Required: CONTEXT = COMPLETED. Current: CONTEXT = $($State.phases.CONTEXT)" }
            }
            return @{ Allowed = $true; Reason = "Preconditions met for ANALYZE." }
        }
        "PLAN" {
            # Hard Gate #1 check: ANALYZE must be APPROVED
            if ($State.phases.ANALYZE -ne "APPROVED") {
                return @{ Allowed = $false; Reason = "PLAN cannot start. Required: ANALYZE = APPROVED (Hard Gate #1). Current: ANALYZE = $($State.phases.ANALYZE)" }
            }
            return @{ Allowed = $true; Reason = "Preconditions met for PLAN." }
        }
        "BRANCH" {
            # Hard Gate #2 check: PLAN must be APPROVED
            if ($State.phases.PLAN -ne "APPROVED") {
                return @{ Allowed = $false; Reason = "BRANCH cannot start. Required: PLAN = APPROVED (Hard Gate #2). Current: PLAN = $($State.phases.PLAN)" }
            }
            return @{ Allowed = $true; Reason = "Preconditions met for BRANCH." }
        }
        "IMPLEMENT" {
            if ($State.phases.BRANCH -ne "COMPLETED") {
                return @{ Allowed = $false; Reason = "IMPLEMENT cannot start. Required: BRANCH = COMPLETED. Current: BRANCH = $($State.phases.BRANCH)" }
            }
            return @{ Allowed = $true; Reason = "Preconditions met for IMPLEMENT." }
        }
        "VERIFY" {
            if ($State.phases.IMPLEMENT -ne "COMPLETED") {
                return @{ Allowed = $false; Reason = "VERIFY cannot start. Required: IMPLEMENT = COMPLETED. Current: IMPLEMENT = $($State.phases.IMPLEMENT)" }
            }
            return @{ Allowed = $true; Reason = "Preconditions met for VERIFY." }
        }
        "PR" {
            # Hard Gate #3 check: VERIFY must be APPROVED
            if ($State.phases.VERIFY -ne "APPROVED") {
                return @{ Allowed = $false; Reason = "PR cannot start. Required: VERIFY = APPROVED (Hard Gate #3). Current: VERIFY = $($State.phases.VERIFY)" }
            }
            return @{ Allowed = $true; Reason = "Preconditions met for PR." }
        }
        default {
            return @{ Allowed = $false; Reason = "Unknown phase: '$TargetPhase'" }
        }
    }
}

function Apply-HumanDecision {
    param(
        [PSCustomObject]$State,
        [string]$Phase,
        [string]$Decision,
        [string]$Feedback = ""
    )

    $validDecisions = @("APPROVE", "REQUEST_CHANGES", "PROVIDE_INFORMATION", "REJECT", "STOP", "RETRY")
    if ($validDecisions -notcontains $Decision) {
        throw "Invalid decision '$Decision'. Must be one of: $($validDecisions -join ', ')"
    }

    $decisionRecord = [PSCustomObject]@{
        phase = $Phase
        decision = $Decision
        timestamp = (Get-Date -Format "o")
        actor = "Human-Lead"
        feedback = $Feedback
    }
    $State.humanDecisions += $decisionRecord

    switch ($Decision) {
        "APPROVE" {
            $State.phases.$Phase = "APPROVED"
            $State.status = "APPROVED"
            # Set next suggested phase
            switch ($Phase) {
                "ANALYZE" { $State.nextSuggestedPhase = "PLAN" }
                "PLAN"    { $State.nextSuggestedPhase = "BRANCH" }
                "VERIFY"  { $State.nextSuggestedPhase = "PR" }
            }
        }
        "REQUEST_CHANGES" {
            $State.phases.$Phase = "CHANGES_REQUESTED"
            $State.status = "CHANGES_REQUESTED"
            $State.nextSuggestedPhase = $Phase # Suggest re-running the same phase
        }
        "PROVIDE_INFORMATION" {
            $State.status = "IN_PROGRESS"
        }
        "REJECT" {
            $State.phases.$Phase = "FAILED"
            $State.status = "BLOCKED"
            $State.nextSuggestedPhase = "NONE"
        }
        "STOP" {
            $State.status = "BLOCKED"
            $State.nextSuggestedPhase = "NONE"
        }
        "RETRY" {
            $State.phases.$Phase = "PENDING"
            $State.status = "IN_PROGRESS"
            $State.nextSuggestedPhase = $Phase
        }
    }

    $State.updated_at = (Get-Date -Format "o")
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   DevWeave V1.1 Modernization State Machine Validator    " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$totalTests = 0
$passedCount = 0
$failedCount = 0

# --- Test Suite 1: Illegal Transition Blocks ---
Write-Host "`n[Suite 1] Illegal Phase Progression Blocks (Preconditions & Gates)..." -ForegroundColor Yellow

$state = New-ModernizationState -Id "MOD-001"

# Cannot run IMPLEMENT when state is INIT
$totalTests++
$chk = Test-CanExecuteModernizationPhase -State $state -TargetPhase "IMPLEMENT"
if (-not $chk.Allowed -and $chk.Reason -match "Required: BRANCH = COMPLETED") {
    Write-Host "  [PASS] Correctly blocked IMPLEMENT when at INIT -> $($chk.Reason)" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Failed to block IMPLEMENT from INIT" -ForegroundColor Red
    $failedCount++
}

# Cannot run PLAN before ANALYZE is approved (Hard Gate 1)
$totalTests++
$state.phases.INIT = "COMPLETED"
$state.phases.CONTEXT = "COMPLETED"
$state.phases.ANALYZE = "COMPLETED" # Completed but NOT approved yet
$chk = Test-CanExecuteModernizationPhase -State $state -TargetPhase "PLAN"
if (-not $chk.Allowed -and $chk.Reason -match "Hard Gate #1") {
    Write-Host "  [PASS] Correctly blocked PLAN before Hard Gate #1 Approval -> $($chk.Reason)" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Failed to block PLAN before ANALYZE approval" -ForegroundColor Red
    $failedCount++
}

# Cannot run BRANCH before PLAN is approved (Hard Gate 2)
$totalTests++
$state.phases.ANALYZE = "APPROVED"
$state.phases.PLAN = "COMPLETED" # Completed but NOT approved yet
$chk = Test-CanExecuteModernizationPhase -State $state -TargetPhase "BRANCH"
if (-not $chk.Allowed -and $chk.Reason -match "Hard Gate #2") {
    Write-Host "  [PASS] Correctly blocked BRANCH before Hard Gate #2 Approval -> $($chk.Reason)" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Failed to block BRANCH before PLAN approval" -ForegroundColor Red
    $failedCount++
}

# Cannot run PR before VERIFY is approved (Hard Gate 3)
$totalTests++
$state.phases.PLAN = "APPROVED"
$state.phases.BRANCH = "COMPLETED"
$state.phases.IMPLEMENT = "COMPLETED"
$state.phases.VERIFY = "COMPLETED" # Completed but NOT approved yet
$chk = Test-CanExecuteModernizationPhase -State $state -TargetPhase "PR"
if (-not $chk.Allowed -and $chk.Reason -match "Hard Gate #3") {
    Write-Host "  [PASS] Correctly blocked PR before Hard Gate #3 Approval -> $($chk.Reason)" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Failed to block PR before VERIFY approval" -ForegroundColor Red
    $failedCount++
}

# --- Test Suite 2: Golden Path Progression with Human Approvals ---
Write-Host "`n[Suite 2] Golden Path Progression with 3 Hard Gates..." -ForegroundColor Yellow

$s = New-ModernizationState -Id "MOD-002"

# 1. CONTEXT
$totalTests++
$chk = Test-CanExecuteModernizationPhase -State $s -TargetPhase "CONTEXT"
if ($chk.Allowed) {
    $s.phases.CONTEXT = "COMPLETED"
    $s.nextSuggestedPhase = "ANALYZE"
    Write-Host "  [PASS] CONTEXT completed -> Next: $($s.nextSuggestedPhase)" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] CONTEXT was blocked: $($chk.Reason)" -ForegroundColor Red
    $failedCount++
}

# 2. ANALYZE
$totalTests++
$chk = Test-CanExecuteModernizationPhase -State $s -TargetPhase "ANALYZE"
if ($chk.Allowed) {
    $s.phases.ANALYZE = "WAITING_APPROVAL"
    Write-Host "  [PASS] ANALYZE completed -> WAITING_APPROVAL" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] ANALYZE was blocked: $($chk.Reason)" -ForegroundColor Red
    $failedCount++
}

# 3. Hard Gate #1 Approval
$totalTests++
Apply-HumanDecision -State $s -Phase "ANALYZE" -Decision "APPROVE" -Feedback "Target architecture approved."
if ($s.phases.ANALYZE -eq "APPROVED" -and $s.nextSuggestedPhase -eq "PLAN") {
    Write-Host "  [PASS] Hard Gate #1 Approved -> Next: PLAN" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Hard Gate #1 approval failed" -ForegroundColor Red
    $failedCount++
}

# 4. PLAN
$totalTests++
$chk = Test-CanExecuteModernizationPhase -State $s -TargetPhase "PLAN"
if ($chk.Allowed) {
    $s.phases.PLAN = "WAITING_APPROVAL"
    Write-Host "  [PASS] PLAN completed -> WAITING_APPROVAL" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] PLAN was blocked: $($chk.Reason)" -ForegroundColor Red
    $failedCount++
}

# 5. Hard Gate #2 Approval
$totalTests++
Apply-HumanDecision -State $s -Phase "PLAN" -Decision "APPROVE" -Feedback "Implementation sequence verified."
if ($s.phases.PLAN -eq "APPROVED" -and $s.nextSuggestedPhase -eq "BRANCH") {
    Write-Host "  [PASS] Hard Gate #2 Approved -> Next: BRANCH" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Hard Gate #2 approval failed" -ForegroundColor Red
    $failedCount++
}

# 6. BRANCH
$totalTests++
$chk = Test-CanExecuteModernizationPhase -State $s -TargetPhase "BRANCH"
if ($chk.Allowed) {
    $s.phases.BRANCH = "COMPLETED"
    $s.branch.name = "devweave/modernization/MOD-002"
    $s.branch.created = $true
    $s.branch.checkedOut = $true
    $s.nextSuggestedPhase = "IMPLEMENT"
    Write-Host "  [PASS] BRANCH created ($($s.branch.name)) -> Next: IMPLEMENT" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] BRANCH was blocked: $($chk.Reason)" -ForegroundColor Red
    $failedCount++
}

# 7. IMPLEMENT
$totalTests++
$chk = Test-CanExecuteModernizationPhase -State $s -TargetPhase "IMPLEMENT"
if ($chk.Allowed) {
    $s.phases.IMPLEMENT = "COMPLETED"
    $s.nextSuggestedPhase = "VERIFY"
    Write-Host "  [PASS] IMPLEMENT completed -> Next: VERIFY" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] IMPLEMENT was blocked: $($chk.Reason)" -ForegroundColor Red
    $failedCount++
}

# 8. VERIFY
$totalTests++
$chk = Test-CanExecuteModernizationPhase -State $s -TargetPhase "VERIFY"
if ($chk.Allowed) {
    $s.phases.VERIFY = "WAITING_APPROVAL"
    Write-Host "  [PASS] VERIFY completed -> WAITING_APPROVAL" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] VERIFY was blocked: $($chk.Reason)" -ForegroundColor Red
    $failedCount++
}

# 9. Hard Gate #3 Approval
$totalTests++
Apply-HumanDecision -State $s -Phase "VERIFY" -Decision "APPROVE" -Feedback "All tests pass, behavioral parity confirmed."
if ($s.phases.VERIFY -eq "APPROVED" -and $s.nextSuggestedPhase -eq "PR") {
    Write-Host "  [PASS] Hard Gate #3 Approved -> Next: PR" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] Hard Gate #3 approval failed" -ForegroundColor Red
    $failedCount++
}

# 10. PR
$totalTests++
$chk = Test-CanExecuteModernizationPhase -State $s -TargetPhase "PR"
if ($chk.Allowed) {
    $s.phases.PR = "COMPLETED"
    $s.status = "COMPLETED"
    $s.nextSuggestedPhase = "NONE"
    Write-Host "  [PASS] PR completed -> Modernization Lifecycle Finished" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] PR was blocked: $($chk.Reason)" -ForegroundColor Red
    $failedCount++
}

# --- Test Suite 3: Human Request Changes & Recovery Loop ---
Write-Host "`n[Suite 3] Human Change Requests & Remediation Loops..." -ForegroundColor Yellow

$s3 = New-ModernizationState -Id "MOD-003"
$s3.phases.CONTEXT = "COMPLETED"
$s3.phases.ANALYZE = "WAITING_APPROVAL"

$totalTests++
Apply-HumanDecision -State $s3 -Phase "ANALYZE" -Decision "REQUEST_CHANGES" -Feedback "Include Redis caching layer in architecture."
if ($s3.phases.ANALYZE -eq "CHANGES_REQUESTED" -and $s3.nextSuggestedPhase -eq "ANALYZE") {
    Write-Host "  [PASS] REQUEST_CHANGES handled -> State: CHANGES_REQUESTED, Suggests re-analyzing" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] REQUEST_CHANGES failed" -ForegroundColor Red
    $failedCount++
}

# Re-run and retry
$totalTests++
Apply-HumanDecision -State $s3 -Phase "ANALYZE" -Decision "RETRY" -Feedback "Re-running analysis with Redis."
if ($s3.phases.ANALYZE -eq "PENDING") {
    Write-Host "  [PASS] RETRY resets phase to PENDING for execution" -ForegroundColor Green
    $passedCount++
} else {
    Write-Host "  [FAIL] RETRY failed" -ForegroundColor Red
    $failedCount++
}

Write-Host "`n----------------------------------------------------------"
Write-Host "Modernization State Summary: Total=$totalTests, Passed=$passedCount, Failed=$failedCount" -ForegroundColor $(if ($failedCount -eq 0) { "Green" } else { "Red" })

if ($failedCount -eq 0) {
    exit 0
} else {
    exit 1
}
