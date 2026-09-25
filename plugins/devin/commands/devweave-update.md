---
name: devweave-update
description: "Autonomously update DevWeave plugins, skills, rules, and adapters in-place from the central repository."
---

# Cognition Devin DevWeave Update Command (`devin run /devweave-update`)

> **"Less Tokens. More Work. Lower Bill."**

## Purpose
Autonomously fetch and synchronize the latest DevWeave skills, templates, schemas, and adapter rules directly from the central repository in-place without requiring manual uninstall or reinstall steps.

---

## Execution Workflow

### Step 1: Connectivity & Update Verification
Check remote repository connectivity and compare the local installation against remote `HEAD`:
- **Windows (PowerShell)**:
  ```powershell
  & "$HOME/.gemini/config/plugins/devweave/scripts/devweave-update.ps1" -Force
  ```
  *(Fallback if standalone script not found)*:
  ```powershell
  $temp = Join-Path $env:TEMP ("devweave-upd-" + [System.Guid]::NewGuid().ToString("N"))
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $temp
  Copy-Item -Path (Join-Path $temp "plugins\antigravity\*") -Destination "$HOME\.gemini\config\plugins\devweave" -Recurse -Force
  Remove-Item -Recurse -Force $temp
  ```

- **Linux / macOS (Bash)**:
  ```bash
  TEMP_DIR=$(mktemp -d /tmp/devweave-upd-XXXXXX)
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git "$TEMP_DIR"
  cp -r "$TEMP_DIR/plugins/antigravity/"* "$HOME/.gemini/config/plugins/devweave/" 2>/dev/null || true
  rm -rf "$TEMP_DIR"
  ```

---

### Step 2: In-Place Cache & 24-Hour TTL Repository Refresh
1. Update `~/.devweave/update-cache.json` with current UTC timestamp, version (`1.2.0`), and commit hash.
2. **Intelligent Repository Detection & 24h TTL Evaluation**:
   - If current working directory contains `.devweave/`:
     - Read `lastScanTime` / `initializedAt` from `.devweave/state/current.json`.
     - Calculate cache age: `(CurrentUTC - lastScanTime)`.
     - **If Cache Age >= 24 Hours OR plugin version updated**:
       - Trigger autonomous non-destructive `devweave-init`.
       - Re-scan 5 layers (manifests, packages, dependencies) and refresh `.devweave/repository/` and `.devweave/graph/knowledge-graph.json`.
       - Update `lastScanTime = CurrentUTC`, `lastUpdated = CurrentUTC`, and `ttlHours = 24` in `.devweave/state/current.json`.
       - **Strict Invariance**: Never overwrite or delete active in-progress story files (`.devweave/modernization/stories/` or `.devweave/work-items/`).
     - **If Cache Age < 24 Hours and plugin version unchanged**:
       - Retain existing repository intelligence (`"Repository intelligence is fresh (< 24h TTL). Skipping re-init."`).
   - If current directory is not an initialized DevWeave repository:
     - Log: `"Global DevWeave plugin updated. (Run 'devin run /devweave-init' inside a project repository to establish repository intelligence)."`
3. Report the updated version, active capabilities, and repository TTL sync status to the developer.

---

### Step 3: Report Update Summary
```text
✨ DevWeave Devin Plugin updated successfully.

Source: https://github.com/paarthivnaik/DevWeave.git (branch: master)
Plugin Version: 1.2.0 (22 active skills)
Repository Status: Intelligence refreshed & 24h TTL synced (Non-destructive)

Run: devin run /devweave-context <WorkItemId>  (to begin work item)
```
