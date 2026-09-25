---
name: devweave-setup
description: "[Setup Orchestration] Detect host tools, verify PM client CLIs and OCR engines, authorize installation, refresh session PATH, and configure secure authentication without secret storage."
---

# Antigravity Setup Skill (`devweave-setup`)

## Purpose
Inspect developer environment, detect PM tool clients (Azure DevOps `az`, Jira `jira`/`acli`, GitHub `gh`, Linear, Git `git`, OCR `tesseract`), seek explicit human confirmation before executing installation commands, refresh the session environment `PATH` dynamically so newly installed tools are immediately recognized, and configure secure authentication via OS credential vaults without writing secrets to `.devweave/`.

---

## Inputs & Parameters
- `--provider <name>`: Optional target provider (`azure-devops`, `jira`, `github`, `git`, `custom`).
- `--check-only`: Diagnostic mode; checks presence without prompting to install.
- `--reconfigure`: Force prompt to update workspace provider settings.

---

## Allowed Actions
1. **Environment & Tool Diagnostic (with Dynamic PATH Refresh)**:
   - Refresh the current process environment `PATH` directly from Windows Registry / environment variables.
   - Inspect PATH for `git`, `az`, `gh`, `jira`, `acli`, `tesseract`.
   - Check Git author identity: `git config user.name`, `git config user.email`.
2. **Interactive Authorization**:
   - If a tool is missing and user wishes to install, ask for explicit human confirmation before executing any package manager command (`winget`, `choco`, `brew`, `npm`).
   - If Git user identity is unconfigured, prompt to configure name and email.
3. **Secure Authentication Verification**:
   - Verify credentials via provider CLI check.
   - Enforce **Zero Secret Storage**: Never store tokens or passwords in `.devweave/`, JSON files, Markdown artifacts, or AI prompts.
4. **Persist Non-Secret Settings (Two-Tier Hierarchy)**:
   - Save non-secret provider metadata to `.devweave/workspace.json` (or `.devweave/modernization/workspace.json`).
   - Save global default provider to `~/.devweave/config.json` for persistence across projects and stories.

---

## Next Suggested Command
```bash
devweave-context <ID>   # or devweave-modernization-context <ID>
```

---

## STOP Rule
- Output setup diagnostic summary and **STOP IMMEDIATELY**.
