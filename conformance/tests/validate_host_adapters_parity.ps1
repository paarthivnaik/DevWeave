<#
.SYNOPSIS
    DevWeave Multi-Host Adapter & Plugin Parity Conformance Suite
.DESCRIPTION
    Validates 100% parity across all 6 supported host platforms:
    - Google Antigravity
    - Anthropic Claude Code
    - OpenAI Codex
    - GitHub Copilot
    - Cognition Devin
    - Google Gemini CLI
    
    Verifies that:
    1. All 6 hosts possess all 32 canonical lifecycle commands/skills in plugins/
    2. All 6 hosts possess matching skills/commands in adapters/
    3. devweave-modernization-init across ALL hosts strictly enforces autonomous inline initialization
       and DOES NOT contain blocking 'devweave-init' prerequisite guards
    4. Adapter manifests, rules, and subagents are intact and aligned
    5. Active user plugin directory is in sync with repository standards
#>

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   DevWeave Multi-Host Adapter & Plugin Parity Suite      " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$RepoRoot = "D:\DevWeave"
$UserPluginDir = "C:\Users\BALAJI NAIK MUDAVATU\.gemini\config\plugins\devweave"

$Hosts = @("antigravity", "claude", "codex", "copilot", "devin", "gemini")

$CanonicalCommands = @(
    "devweave-init",
    "devweave-update",
    "devweave-status",
    "devweave-setup",
    "devweave-context",
    "devweave-analyze",
    "devweave-plan",
    "devweave-branch",
    "devweave-implement",
    "devweave-pr-review",
    "devweave-pr",
    "devweave-modernization-init",
    "devweave-modernization-context",
    "devweave-modernization-analyze",
    "devweave-modernization-plan",
    "devweave-modernization-branch",
    "devweave-modernization-implement",
    "devweave-modernization-verify",
    "devweave-modernization-pr",
    "devweave-modernization-status",
    "devweave-modernization-report",
    "devweave-express",
    "devweave-improve",
    "devweave-archive",
    "devweave-report",
    "devweave-modernize",
    "devweave-handoff",
    "devweave-document-domain",
    "devweave-document-product",
    "devweave-fix-triage",
    "devweave-fix-diagnose",
    "devweave-fix-land"
)

$TotalChecks = 0
$PassedChecks = 0
$FailedChecks = 0

function Assert-Check {
    param(
        [string]$Description,
        [bool]$Condition,
        [string]$FailureMessage = ""
    )
    $script:TotalChecks++
    if ($Condition) {
        $script:PassedChecks++
        Write-Host "  [PASS] $Description" -ForegroundColor Green
    } else {
        $script:FailedChecks++
        Write-Host "  [FAIL] $Description -> $FailureMessage" -ForegroundColor Red
    }
}

# --- Suite 1: Plugin Commands / Skills Parity ---
Write-Host "`n[Suite 1] Plugin Commands / Skills Parity Across All 6 Hosts..." -ForegroundColor Yellow

foreach ($h in $Hosts) {
    $pluginDir = Join-Path $RepoRoot "plugins\$h"
    Assert-Check "Host plugin directory exists: plugins/$h" (Test-Path $pluginDir) "Directory missing: $pluginDir"
    
    $missingCommands = @()
    foreach ($cmd in $CanonicalCommands) {
        $found = $false
        if ($h -eq "antigravity") {
            $path = Join-Path $pluginDir "skills\$cmd\SKILL.md"
            $found = Test-Path $path
        } elseif ($h -eq "copilot") {
            $path = Join-Path $pluginDir "prompts\$cmd.prompt.md"
            $found = Test-Path $path
        } else {
            $path = Join-Path $pluginDir "commands\$cmd.md"
            $found = Test-Path $path
        }
        if (-not $found) {
            $missingCommands += $cmd
        }
    }
    
    Assert-Check "Host '$h' has all $($CanonicalCommands.Count) commands in plugins/$h" ($missingCommands.Count -eq 0) "Missing: $($missingCommands -join ', ')"
}

# --- Suite 2: Host Adapter Parity ---
Write-Host "`n[Suite 2] Adapter Parity Across All 6 Hosts..." -ForegroundColor Yellow

foreach ($h in $Hosts) {
    $adapterDir = Join-Path $RepoRoot "adapters\$h"
    Assert-Check "Adapter directory exists: adapters/$h" (Test-Path $adapterDir) "Directory missing: $adapterDir"
    
    $manifestPath = Join-Path $adapterDir "manifest\adapter.yaml"
    Assert-Check "Adapter manifest exists: adapters/$h/manifest/adapter.yaml" (Test-Path $manifestPath) "Manifest missing"
    
    $rulesPath = Join-Path $adapterDir "rules\devweave-core.md"
    Assert-Check "Adapter rules exist: adapters/$h/rules/devweave-core.md" (Test-Path $rulesPath) "Rules file missing"
    
    # Check skills/commands exist in adapter
    $adapterSkillsDir = Join-Path $adapterDir "skills"
    Assert-Check "Adapter skills directory exists: adapters/$h/skills" (Test-Path $adapterSkillsDir) "Directory missing: $adapterSkillsDir"
    
    $missingAdapterSkills = @()
    foreach ($cmd in $CanonicalCommands) {
        $skillFile = Join-Path $adapterSkillsDir "$cmd\SKILL.md"
        if (-not (Test-Path $skillFile)) {
            $missingAdapterSkills += $cmd
        }
    }
    Assert-Check "Adapter '$h' has all $($CanonicalCommands.Count) skills in adapters/$h/skills" ($missingAdapterSkills.Count -eq 0) "Missing in adapters/$h/skills: $($missingAdapterSkills -join ', ')"
}

# --- Suite 3: Modernization Init Autonomous Invariant (Strict Zero-Prerequisite) ---
Write-Host "`n[Suite 3] Strict Zero-Prerequisite Verification on devweave-modernization-init..." -ForegroundColor Yellow

$filesToCheck = @()

# Collect all devweave-modernization-init files across plugins and adapters
foreach ($h in $Hosts) {
    if ($h -eq "antigravity") {
        $filesToCheck += @{ Host = $h; Source = "plugin"; Path = (Join-Path $RepoRoot "plugins\$h\skills\devweave-modernization-init\SKILL.md") }
    } elseif ($h -eq "copilot") {
        $filesToCheck += @{ Host = $h; Source = "plugin"; Path = (Join-Path $RepoRoot "plugins\$h\prompts\devweave-modernization-init.prompt.md") }
    } else {
        $filesToCheck += @{ Host = $h; Source = "plugin"; Path = (Join-Path $RepoRoot "plugins\$h\commands\devweave-modernization-init.md") }
    }
    
    $filesToCheck += @{ Host = $h; Source = "adapter-skill"; Path = (Join-Path $RepoRoot "adapters\$h\skills\devweave-modernization-init\SKILL.md") }
    
    if ($h -eq "copilot") {
        $filesToCheck += @{ Host = $h; Source = "adapter-prompt"; Path = (Join-Path $RepoRoot "adapters\$h\prompts\devweave-modernization-init.prompt.md") }
    } elseif ($h -ne "antigravity") {
        $filesToCheck += @{ Host = $h; Source = "adapter-command"; Path = (Join-Path $RepoRoot "adapters\$h\commands\devweave-modernization-init.md") }
    }
}

# Add user's deployed skill
if (Test-Path (Join-Path $UserPluginDir "skills\devweave-modernization-init\SKILL.md")) {
    $filesToCheck += @{ Host = "antigravity-user"; Source = "user-config"; Path = (Join-Path $UserPluginDir "skills\devweave-modernization-init\SKILL.md") }
}

foreach ($item in $filesToCheck) {
    if (-not (Test-Path $item.Path)) {
        Assert-Check "File exists: $($item.Path)" $false "Target file is missing!"
        continue
    }
    
    $content = Get-Content -Raw $item.Path
    
    # 1. Must NOT contain blocking devweave-init prerequisite error message
    $hasBlockingError = $content -match "DevWeave base initialization is required"
    Assert-Check "No blocking prerequisite guard in $($item.Host) ($($item.Source))" (-not $hasBlockingError) "Found forbidden 'DevWeave base initialization is required' in $($item.Path)"
    
    # 2. Must NOT contain preconditions requiring devweave-init
    $hasPreconditionInit = $content -match "Base repository initialization completed"
    Assert-Check "No blocking precondition requirement in $($item.Host) ($($item.Source))" (-not $hasPreconditionInit) "Found forbidden precondition 'Base repository initialization completed' in $($item.Path)"
    
    # 3. Must specify autonomous inline target initialization
    $hasAutonomousInit = $content -match "Autonomous Target Workspace Initialization" -or $content -match "Autonomous Target Inspection & Inline Init"
    Assert-Check "Enforces autonomous inline init in $($item.Host) ($($item.Source))" $hasAutonomousInit "Missing autonomous inline target initialization specification in $($item.Path)"
    
    # 4. Must enforce mandatory legacy source checkpoint
    $hasLegacySourceCheck = $content -match "Mandatory Legacy Source (Gate|Checkpoint)"
    Assert-Check "Enforces mandatory legacy source checkpoint in $($item.Host) ($($item.Source))" $hasLegacySourceCheck "Missing mandatory legacy source checkpoint in $($item.Path)"
}

# --- Suite 4: Cross-Host Parity Summary ---
Write-Host "`n----------------------------------------------------------"
Write-Host "Multi-Host Parity Summary: Total=$TotalChecks, Passed=$PassedChecks, Failed=$FailedChecks"
if ($FailedChecks -eq 0) {
    Write-Host ">>> [SUCCESS] DevWeave Multi-Host Adapter & Plugin Parity Suite passed" -ForegroundColor Green
    exit 0
} else {
    Write-Host ">>> [FAILURE] $FailedChecks checks failed in Multi-Host Parity Suite" -ForegroundColor Red
    exit 1
}
