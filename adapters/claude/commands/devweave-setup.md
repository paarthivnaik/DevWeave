---
name: devweave-setup
description: "[Setup Orchestration] Detect host tools, verify PM client CLIs and OCR engines, authorize installation, and configure secure authentication without secret storage."
---

# Claude Code Setup Command (`claude /devweave-setup`)

## Purpose
Inspect developer environment, detect PM tool clients (Azure DevOps `az`, Jira `jira`/`acli`, GitHub `gh`, OCR `tesseract`), seek explicit human authorization before running installation commands, and configure secure authentication via OS credential vaults without writing secrets to `.devweave/`.

---

## Inputs & Parameters
- `--provider <name>`: Optional target provider (`azure-devops`, `jira`, `github`, `custom`).
- `--check-only`: Diagnostic mode; checks presence without prompting to install.
- `--reconfigure`: Force prompt to update workspace provider settings.

---

## Allowed Actions
1. **Environment & Tool Diagnostic**:
   - Inspect PATH for `az`, `gh`, `jira`, `acli`, `tesseract`.
2. **Interactive Authorization**:
   - If a tool is missing and user wishes to install, ask for explicit human confirmation before executing any package manager command (`winget`, `choco`, `brew`, `npm`).
3. **Secure Authentication Verification**:
   - Verify credentials via provider CLI check.
   - Enforce **Zero Secret Storage**: Never store tokens or passwords in `.devweave/`, JSON files, Markdown artifacts, or AI prompts.
4. **Persist Non-Secret Settings**:
   - Save non-secret provider metadata to `.devweave/modernization/workspace.json`.

---

## Next Suggested Command
```bash
devweave-modernization-context <ID>
```

---

## STOP Rule
- Output setup diagnostic summary and **STOP IMMEDIATELY**.
