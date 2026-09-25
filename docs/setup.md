# DevWeave Environment & Provider Setup Orchestrator (`devweave-setup`)

## Overview
`devweave-setup` is DevWeave's central environment diagnostic and setup orchestrator. It inspects installed developer tools, verifies project management CLI clients and OCR engines, requests explicit human authorization before running installation commands, and confirms secure authentication via native OS credential vaults.

---

## Usage
```bash
# Run generic environment diagnostic scan
devweave-setup

# Configure and verify a specific provider
devweave-setup --provider azure-devops
devweave-setup --provider jira
devweave-setup --provider github

# Non-interactive check only
devweave-setup --check-only

# Force re-prompt of provider settings
devweave-setup --reconfigure
```

---

## Capabilities

1. **Host Diagnostic**: Inspects OS (Windows, macOS, Linux), package managers (`winget`, `choco`, `brew`, `apt`, `npm`), and system utilities.
2. **Provider Client Detection**: Verifies presence of `az` (Azure DevOps), `jira`/`acli` (Jira), `gh` (GitHub), and `tesseract` (OCR).
3. **Human-Authorized Installation**: Prompts for explicit human confirmation before executing any package manager installation.
4. **Secure Authentication**: Validates active session without writing secrets to repository files.
5. **Declarative Persistence**: Saves non-secret configuration to `.devweave/modernization/workspace.json` conforming to `provider-config.schema.json`.
