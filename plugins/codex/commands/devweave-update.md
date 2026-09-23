---
name: devweave-update
description: "Autonomously update DevWeave OpenAI Codex commands and rules in-place from the central repository."
---

# OpenAI Codex Update Command (`$devweave update`)

> **"Less Tokens. More Work. Lower Bill."**

## Purpose
Autonomously fetch and synchronize the latest DevWeave Codex commands, workflows, and prompts in-place without manual file replacement.

---

## Execution Workflow

### Step 1: In-Place Sync
- **Linux / macOS**:
  ```bash
  TEMP_DIR=$(mktemp -d /tmp/devweave-upd-XXXXXX)
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git "$TEMP_DIR"
  cp -r "$TEMP_DIR/plugins/codex/commands/"* "$HOME/.codex/commands/" 2>/dev/null || true
  rm -rf "$TEMP_DIR"
  ```
- **Windows (PowerShell)**:
  ```powershell
  $temp = Join-Path $env:TEMP ("devweave-upd-" + [System.Guid]::NewGuid().ToString("N"))
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $temp
  Copy-Item -Path (Join-Path $temp "plugins\codex\commands\*") -Destination "$HOME\.codex\commands" -Recurse -Force
  Remove-Item -Recurse -Force $temp
  ```

---

### Step 2: Report Update Summary
```text
✨ DevWeave Codex commands updated successfully.

Source: https://github.com/paarthivnaik/DevWeave.git (branch: develop)
Status: Up to date & ready

Run: $devweave init  (to initialize or re-verify repository stack)
Run: $devweave context <WorkItemId>  (to begin work item)
```
