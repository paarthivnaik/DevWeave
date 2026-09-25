---
name: devweave-setup
description: "[Setup Orchestration] Detect host tools, verify PM client CLIs and OCR engines, authorize installation, and configure secure authentication without secret storage."
---

# DevWeave Setup Skill (`devweave-setup`)

## Purpose
Orchestrate environment diagnostics, tool and CLI client detection (Azure DevOps `az`, Jira `jira`/`acli`, GitHub `gh`, OCR `tesseract`), human authorization for client installation, and secure authentication verification without storing credentials in repository files.

---

## Inputs & Parameters
- `--provider <name>`: Optional provider filter (`azure-devops`, `jira`, `github`, `custom`).
- `--check-only`: Diagnostic check without interactive configuration.
- `--reconfigure`: Force prompt to update endpoints or provider choice.

---

## Allowed Actions
1. **Environment Diagnostic**:
   - Detect OS (Windows, macOS, Linux).
   - Detect installed package managers (`winget`, `choco`, `brew`, `apt`, `npm`, `pip`).
2. **Provider Client Detection**:
   - Query client CLI presence and versions.
   - If missing, display installation guidance and request human authorization before running installer.
3. **OCR Engine Detection**:
   - Check `tesseract` / vision capability presence.
4. **Secure Authentication Verification**:
   - Verify native OS session credentials (`az account show`, `gh auth status`, `jira whoami`).
   - If unauthenticated, trigger secure provider authentication flow.
   - Enforce **Zero Secret Storage**: Never write tokens, passwords, or PATs to `.devweave/` or Git.
5. **Persist Non-Secret Configuration**:
   - Save declarative provider status to `.devweave/modernization/workspace.json` conforming to `provider-config.schema.json`.

---

## Artifacts Generated
- `.devweave/modernization/workspace.json` (or `.devweave/workspace.json`)

---

## Next Suggested Command
```bash
devweave-modernization-context <ID>
```

---

## STOP Rule
- Once environment is verified and configuration persisted, report status summary and **STOP IMMEDIATELY**.
