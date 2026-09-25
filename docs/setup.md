# DevWeave Environment & Provider Setup Orchestrator (`devweave-setup`)

## Overview
`devweave-setup` is DevWeave's central environment diagnostic and setup orchestrator. It inspects installed developer tools, verifies project management CLI clients and OCR engines, dynamically synchronizes the active environment PATH from the OS to immediately detect newly installed CLIs, requests explicit human authorization before running installation commands, and confirms secure authentication via native OS credential vaults.

---

## Usage
```bash
# Run generic environment diagnostic scan (with dynamic PATH refresh)
devweave-setup

# Configure and verify a specific provider
devweave-setup --provider azure-devops
devweave-setup --provider jira
devweave-setup --provider github
devweave-setup --provider git

# Non-interactive check only
devweave-setup --check-only

# Force re-prompt of provider settings
devweave-setup --reconfigure
```

---

## Capabilities

1. **Host Diagnostic & Dynamic PATH Refresh**: Inspects OS (Windows, macOS, Linux), package managers (`winget`, `choco`, `brew`, `apt`, `npm`), and system utilities. Dynamically refreshes session PATH from the OS Registry/Environment so newly installed CLIs are recognized without requiring terminal restarts.
2. **Provider Client Detection**: Verifies presence of `git`, `az` (Azure DevOps), `jira`/`acli` (Jira), `gh` (GitHub), and `tesseract` (OCR).
3. **Git Author Identity Verification**: Validates `git config user.name` and `git config user.email` and interactively prompts if missing.
4. **Human-Authorized Installation**: Prompts for explicit human confirmation before executing any package manager installation.
5. **Secure Authentication**: Validates active session without writing secrets to repository files.
6. **Two-Tier Declarative Persistence**: Saves non-secret configuration to `.devweave/workspace.json` (or `.devweave/modernization/workspace.json`) and sets global defaults in `~/.devweave/config.json` conforming to `provider-config.schema.json`.
