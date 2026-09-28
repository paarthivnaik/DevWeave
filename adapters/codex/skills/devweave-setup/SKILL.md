---
name: devweave-setup
description: "[Setup Orchestration] Detect host tools, verify PM client CLIs, detect Deep Analyzer capabilities, authorize installation, refresh session PATH, and configure secure authentication without secret storage."
---

# Antigravity Setup Skill (`devweave-setup`)

## Purpose
Inspect developer environment, detect PM tool clients (Azure DevOps `az`, Jira `jira`/`acli`, GitHub `gh`, Linear, Git `git`, OCR `tesseract`), detect technology-aware **Deep Analyzer capabilities** (Roslyn for .NET, TypeScript Compiler API, Python AST, JavaParser, Go AST), seek explicit human confirmation before executing installation commands, refresh session `PATH` dynamically, and configure secure authentication via OS credential vaults without writing secrets to `.devweave/`.

---

## Inputs & Parameters
- `--provider <name>`: Optional target provider (`azure-devops`, `jira`, `github`, `git`, `custom`).
- `--analyzer <name>`: Optional deep analyzer to configure.
- `--check-only`: Diagnostic mode; checks presence without prompting to install.
- `--reconfigure`: Force prompt to update workspace provider settings.

---

## Allowed Actions
1. **Environment & Tool Diagnostic (with Dynamic PATH Refresh)**:
   - Refresh the current process environment `PATH` directly from Windows Registry / environment variables.
   - Inspect PATH for `git`, `az`, `gh`, `jira`, `acli`, `tesseract`.
   - Check Git author identity: `git config user.name`, `git config user.email`.
2. **Deep Analyzer Capability Detection**:
   - For detected repository technologies, identify applicable Deep Analyzers (e.g. Roslyn for .NET, TS Compiler API for TypeScript).
   - Record capability status (`AVAILABLE`, `MISSING`, `NOT_REQUIRED`, `DECLINED`) in `.devweave/repository/analyzer-capabilities.json`.
   - If a useful analyzer is missing, present UX explaining its purpose and ask for human approval before installing.
   - If declined, continue gracefully with standard analysis (`status: "DECLINED"`).
3. **Interactive Authorization & Checkpoint**:
   - If a tool is missing and user wishes to install, ask for explicit human confirmation before executing any package manager command (`winget`, `choco`, `brew`, `npm`).
   - Save checkpoint state, validate post-installation, and resume.
4. **Secure Authentication Verification**:
   - Verify credentials via provider CLI check.
   - Enforce **Zero Secret Storage**: Never store tokens or passwords in `.devweave/`, JSON files, Markdown artifacts, or AI prompts.
5. **Persist Non-Secret Settings (Two-Tier Hierarchy)**:
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
