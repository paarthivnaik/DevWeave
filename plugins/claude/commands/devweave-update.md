---
name: devweave-update
description: "Autonomously update DevWeave plugins, skills, rules, and adapters in-place from the central repository."
---

# Claude Code DevWeave Update Command (`claude /devweave-update`)

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

### Step 2: In-Place Cache & State Refresh
1. Update `~/.devweave/update-cache.json` with current UTC timestamp and commit hash.
2. Preserve all existing workspace state files in `.devweave/state/` and `.devweave/knowledge/`.
3. Report the updated version and active capabilities to the developer.

---

### Step 3: Report Update Summary
```text
✨ DevWeave Antigravity Plugin updated successfully.

Source: https://github.com/paarthivnaik/DevWeave.git (branch: develop)
Skills Verified: 21 active skills
Status: Up to date & ready

Run: claude /devweave-init  (to initialize or re-verify repository stack)
Run: claude /devweave-context <WorkItemId>  (to begin work item)
```
