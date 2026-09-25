<#
.SYNOPSIS
    DevWeave Modernization & Setup CLI Command Contract Validator
.DESCRIPTION
    Validates recognition of all mandatory hyphenated modernization and setup commands,
    rejection of malformed / space-separated / colon syntax, parameter enforcement,
    and non-interference with V1.0 commands.
#>

$ErrorActionPreference = "Stop"

# Canonical Modernization & Setup Commands Definition
$ModernizationCommands = @{
    "devweave-setup"                   = @{ RequiresId = $false; Phase = "SETUP" }
    "devweave-modernization-init"      = @{ RequiresId = $false; Phase = "INIT" }
    "devweave-modernization-context"   = @{ RequiresId = $true;  Phase = "CONTEXT" }
    "devweave-modernization-analyze"   = @{ RequiresId = $true;  Phase = "ANALYZE" }
    "devweave-modernization-plan"      = @{ RequiresId = $true;  Phase = "PLAN" }
    "devweave-modernization-branch"    = @{ RequiresId = $true;  Phase = "BRANCH" }
    "devweave-modernization-implement" = @{ RequiresId = $true;  Phase = "IMPLEMENT" }
    "devweave-modernization-verify"    = @{ RequiresId = $true;  Phase = "VERIFY" }
    "devweave-modernization-pr"        = @{ RequiresId = $true;  Phase = "PR" }
    "devweave-modernization-status"    = @{ RequiresId = $true;  Phase = "STATUS" }
    "devweave-modernization-report"    = @{ RequiresId = $true;  Phase = "REPORT" }
}

function Parse-DevWeaveCliCommand {
    param(
        [string]$CommandLine
    )

    $trimmed = $CommandLine.Trim()
    $tokens = $trimmed -split '\s+'

    if ($tokens.Count -eq 0) {
        return @{ Success = $false; Error = "Empty command string" }
    }

    $cmd = $tokens[0]

    # Check for prohibited space-separated syntax (e.g., 'devweave modernization init')
    if ($tokens.Count -ge 2 -and $tokens[0] -eq "devweave" -and $tokens[1] -eq "modernization") {
        $sub = if ($tokens.Count -ge 3) { $tokens[2] } else { "init" }
        return @{
            Success = $false
            Error = "Invalid space-separated syntax 'devweave modernization $sub'. Use hyphenated 'devweave-modernization-$sub'."
        }
    }

    # Check for prohibited colon syntax (e.g., 'devweave:modernization:plan')
    if ($cmd -match "^devweave:modernization:(.+)$") {
        $sub = $Matches[1]
        return @{
            Success = $false
            Error = "Invalid colon-separated syntax '$cmd'. Use hyphenated 'devweave-modernization-$sub'."
        }
    }

    # Match modernization and setup commands
    if ($ModernizationCommands.ContainsKey($cmd)) {
        $spec = $ModernizationCommands[$cmd]
        $cmdArgs = @($tokens | Select-Object -Skip 1)

        if ($spec.RequiresId) {
            if ($cmdArgs.Count -eq 0 -or [string]::IsNullOrWhiteSpace($cmdArgs[0])) {
                return @{
                    Success = $false
                    Error = "Missing required argument <ID> for command '$cmd'. Usage: $cmd <ID>"
                }
            }
            $id = [string]$cmdArgs[0]
            if ($id -notmatch "^[A-Za-z0-9_-]+$") {
                return @{
                    Success = $false
                    Error = "Invalid ID format '$id'. ID must contain only alphanumeric characters, dashes, and underscores."
                }
            }
            $extra = @($cmdArgs | Select-Object -Skip 1)
            return @{
                Success = $true
                Command = $cmd
                Phase = $spec.Phase
                Id = $id
                ExtraArgs = $extra
            }
        } else {
            return @{
                Success = $true
                Command = $cmd
                Phase = $spec.Phase
                ExtraArgs = $cmdArgs
            }
        }
    }

    # Check if unknown modernization command
    if ($cmd -like "devweave-modernization-*") {
        return @{
            Success = $false
            Error = "Unknown modernization command '$cmd'."
        }
    }

    # Standard V1.0 fallback
    return @{
        Success = $true
        Command = $cmd
        IsV10 = $true
    }
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   DevWeave Modernization & Setup CLI Contract Validator  " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$totalTests = 0
$passedCount = 0
$failedCount = 0

# --- Test Suite 1: Valid Modernization & Setup Commands Recognition ---
Write-Host "`n[Suite 1] Valid Modernization & Setup Invocations..." -ForegroundColor Yellow
$validTestCases = @(
    @{ Cmd = "devweave-setup"; ExpectedPhase = "SETUP" },
    @{ Cmd = "devweave-setup --provider jira"; ExpectedPhase = "SETUP" },
    @{ Cmd = "devweave-setup --provider azure-devops --check-only"; ExpectedPhase = "SETUP" },
    @{ Cmd = "devweave-modernization-init"; ExpectedPhase = "INIT" },
    @{ Cmd = "devweave-modernization-init Angular microservices CQRS MySQL"; ExpectedPhase = "INIT" },
    @{ Cmd = "devweave-modernization-context MOD-001"; ExpectedPhase = "CONTEXT"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-analyze MOD-001"; ExpectedPhase = "ANALYZE"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-plan MOD-001"; ExpectedPhase = "PLAN"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-branch MOD-001"; ExpectedPhase = "BRANCH"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-branch MOD-001 --name feature/99-user-reg --base master"; ExpectedPhase = "BRANCH"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-branch 99 --name feature/99-registration --base develop"; ExpectedPhase = "BRANCH"; ExpectedId = "99" },
    @{ Cmd = "devweave-modernization-implement MOD-001"; ExpectedPhase = "IMPLEMENT"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-verify MOD-001"; ExpectedPhase = "VERIFY"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-pr MOD-001"; ExpectedPhase = "PR"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-status MOD-001"; ExpectedPhase = "STATUS"; ExpectedId = "MOD-001" },
    @{ Cmd = "devweave-modernization-report MOD-001"; ExpectedPhase = "REPORT"; ExpectedId = "MOD-001" }
)

foreach ($tc in $validTestCases) {
    $totalTests++
    $res = Parse-DevWeaveCliCommand -CommandLine $tc.Cmd
    if ($res.Success -and $res.Phase -eq $tc.ExpectedPhase) {
        if (-not $tc.ExpectedId -or $res.Id -eq $tc.ExpectedId) {
            Write-Host "  [PASS] '$($tc.Cmd)' recognized -> Phase: $($res.Phase)" -ForegroundColor Green
            $passedCount++
            continue
        }
    }
    Write-Host "  [FAIL] '$($tc.Cmd)' failed. Expected Phase: $($tc.ExpectedPhase), Got: $($res | ConvertTo-Json -Compress)" -ForegroundColor Red
    $failedCount++
}

# --- Test Suite 2: Missing Argument Rejection ---
Write-Host "`n[Suite 2] Missing <ID> Parameter Rejections..." -ForegroundColor Yellow
$missingArgCases = @(
    "devweave-modernization-context",
    "devweave-modernization-analyze",
    "devweave-modernization-plan",
    "devweave-modernization-branch",
    "devweave-modernization-implement",
    "devweave-modernization-verify",
    "devweave-modernization-pr",
    "devweave-modernization-status",
    "devweave-modernization-report"
)

foreach ($cmd in $missingArgCases) {
    $totalTests++
    $res = Parse-DevWeaveCliCommand -CommandLine $cmd
    if (-not $res.Success -and $res.Error -match "Missing required argument <ID>") {
        Write-Host "  [PASS] Correctly rejected missing ID for '$cmd'" -ForegroundColor Green
        $passedCount++
    } else {
        Write-Host "  [FAIL] Failed to reject missing ID for '$cmd'" -ForegroundColor Red
        $failedCount++
    }
}

# --- Test Suite 3: Malformed & Namespace Syntax Rejection ---
Write-Host "`n[Suite 3] Malformed & Namespace Syntax Rejections..." -ForegroundColor Yellow
$malformedCases = @(
    @{ Cmd = "devweave modernization init"; ExpectedError = "Invalid space-separated syntax" },
    @{ Cmd = "devweave modernization plan MOD-001"; ExpectedError = "Invalid space-separated syntax" },
    @{ Cmd = "devweave:modernization:plan MOD-001"; ExpectedError = "Invalid colon-separated syntax" },
    @{ Cmd = "devweave-modernization-foo MOD-001"; ExpectedError = "Unknown modernization command" }
)

foreach ($tc in $malformedCases) {
    $totalTests++
    $res = Parse-DevWeaveCliCommand -CommandLine $tc.Cmd
    if (-not $res.Success -and $res.Error -match $tc.ExpectedError) {
        Write-Host "  [PASS] Correctly rejected '$($tc.Cmd)' -> $($res.Error)" -ForegroundColor Green
        $passedCount++
    } else {
        Write-Host "  [FAIL] Malformed rejection failed for '$($tc.Cmd)'" -ForegroundColor Red
        $failedCount++
    }
}

# --- Test Suite 4: V1.0 Non-Interference ---
Write-Host "`n[Suite 4] V1.0 Command Non-Interference..." -ForegroundColor Yellow
$v1Cases = @(
    "devweave-init",
    "devweave-context TASK-001",
    "devweave-analyze TASK-001",
    "devweave-plan TASK-001",
    "devweave-implement TASK-001",
    "devweave-pr-review TASK-001",
    "devweave-pr TASK-001"
)

foreach ($cmd in $v1Cases) {
    $totalTests++
    $res = Parse-DevWeaveCliCommand -CommandLine $cmd
    if ($res.Success -and $res.IsV10) {
        Write-Host "  [PASS] V1.0 command '$cmd' parsed cleanly" -ForegroundColor Green
        $passedCount++
    } else {
        Write-Host "  [FAIL] V1.0 command '$cmd' failed to pass through" -ForegroundColor Red
        $failedCount++
    }
}

Write-Host "`n----------------------------------------------------------"
Write-Host "Modernization CLI Summary: Total=$totalTests, Passed=$passedCount, Failed=$failedCount" -ForegroundColor $(if ($failedCount -eq 0) { "Green" } else { "Red" })

if ($failedCount -eq 0) {
    exit 0
} else {
    exit 1
}
