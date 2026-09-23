---
name: devweave-update
description: "Autonomously update DevWeave GitHub Copilot prompts, instructions, and workspace templates in-place."
---

# GitHub Copilot Update Prompt (`@devweave /update`)

> **"Less Tokens. More Work. Lower Bill."**

## Purpose
Autonomously fetch and synchronize the latest DevWeave Copilot instructions, prompts, and workspace definitions in-place directly from the central repository.

---

## Execution Workflow

### Step 1: In-Place Sync
- **Windows (PowerShell)**:
  ```powershell
  $temp = Join-Path $env:TEMP ("devweave-upd-" + [System.Guid]::NewGuid().ToString("N"))
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $temp
  Copy-Item -Path (Join-Path $temp "plugins\copilot\prompts\*") -Destination ".github\copilot\prompts" -Recurse -Force
  Remove-Item -Recurse -Force $temp
  ```
- **Linux / macOS (Bash)**:
  ```bash
  TEMP_DIR=$(mktemp -d /tmp/devweave-upd-XXXXXX)
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git "$TEMP_DIR"
  cp -r "$TEMP_DIR/plugins/copilot/prompts/"* ".github/copilot/prompts/" 2>/dev/null || true
  rm -rf "$TEMP_DIR"
  ```

---

### Step 2: Report Update Summary
```text
✨ DevWeave Copilot prompts updated successfully.

Source: https://github.com/paarthivnaik/DevWeave.git (branch: develop)
Status: Up to date & ready

Run: @devweave /init  (to initialize or re-verify repository stack)
Run: @devweave /context <WorkItemId>  (to begin work item)
```
