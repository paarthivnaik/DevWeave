---
name: devweave-update
description: "Autonomously update DevWeave Cognition Devin playbooks and adapters in-place from the central repository."
---

# Cognition Devin Update Playbook (`devweave:update`)

> **"Less Tokens. More Work. Lower Bill."**

## Purpose
Autonomously fetch and synchronize the latest DevWeave Devin playbooks, instructions, and schemas in-place without manual file replacement.

---

## Execution Workflow

### Step 1: In-Place Sync
- **Linux / macOS**:
  ```bash
  TEMP_DIR=$(mktemp -d /tmp/devweave-upd-XXXXXX)
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git "$TEMP_DIR"
  cp -r "$TEMP_DIR/plugins/devin/commands/"* "$HOME/.devin/commands/" 2>/dev/null || true
  rm -rf "$TEMP_DIR"
  ```
- **Windows (PowerShell)**:
  ```powershell
  $temp = Join-Path $env:TEMP ("devweave-upd-" + [System.Guid]::NewGuid().ToString("N"))
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $temp
  Copy-Item -Path (Join-Path $temp "plugins\devin\commands\*") -Destination "$HOME\.devin\commands" -Recurse -Force
  Remove-Item -Recurse -Force $temp
  ```

---

### Step 2: Report Update Summary
```text
✨ DevWeave Devin playbooks updated successfully.

Source: https://github.com/paarthivnaik/DevWeave.git (branch: develop)
Status: Up to date & ready

Run: devweave:init  (to initialize or re-verify repository stack)
Run: devweave:context <WorkItemId>  (to begin work item)
```
