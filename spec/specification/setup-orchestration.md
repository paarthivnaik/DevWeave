# DevWeave Specification: Environment & Provider Setup Orchestration (`devweave-setup`)

## 1. Purpose

`devweave-setup` is the generic environment, tool detection, provider client installation authorization, and secure authentication orchestrator for DevWeave.

When a prerequisite CLI, package manager, SDK, or project-management client (e.g., Azure CLI `az`, Jira CLI `jira`/`acli`, GitHub CLI `gh`, OCR engine `tesseract`) is missing or unauthenticated, DevWeave routes the developer to `devweave-setup` rather than attempting intrusive, automated environment mutations.

---

## 2. Command Invocation

```bash
devweave-setup [--provider <jira|azure-devops|github|custom>] [--check-only] [--reconfigure]
```

### Options:
- `--provider <name>`: Explicitly configure and verify a specific project-management or environment provider.
- `--check-only`: Non-interactive diagnostic scan of installed CLIs, authentication status, and OCR engines.
- `--reconfigure`: Force prompt to update provider selections or endpoints.

---

## 3. Setup Lifecycle & Responsibilities

```text
devweave-setup
    ↓
1. Detect Host Operating System & Environment (Windows, macOS, Linux)
    ↓
2. Detect Required Provider Clients & Tools
   - Azure DevOps: az CLI + azure-devops extension
   - Jira: jira-cli / acli / Jira REST client
   - GitHub: gh CLI
   - OCR Tools: Tesseract / System OCR / Vision fallback
    ↓
3. Check Installation Status
   - If installed: Report version and proceed
   - If missing:
     * Display clear installation instructions for the platform
     * Ask developer for explicit confirmation before executing installation scripts (winget / brew / apt / npm / pip)
    ↓
4. Configure & Verify Secure Authentication
   - Azure DevOps: az login / az devops configure
   - Jira: jira init / API Token stored securely in OS credential vault
   - GitHub: gh auth login / gh auth status
   - Custom: Environment variable verification
    ↓
5. Test End-to-End Connectivity
   - Execute lightweight diagnostic query (e.g. `whoami`, `get-user`, `list-projects`)
    ↓
6. Persist Non-Secret Workspace Configuration
   - Save provider name, CLI tool name, detection flag, auth type to `.devweave/modernization/workspace.json`
   - NEVER persist passwords, PATs, or session secrets in workspace files
    ↓
7. Report Summary & Next Recommended Command
```

---

## 4. Security & Isolation Guarantees

1. **Explicit User Authorization**: Never execute package managers or install binaries silently without explicit human approval.
2. **OS Credential Vault Integration**: Direct authentication tokens to native OS credential stores (Windows Credential Manager, macOS Keychain, Linux Secret Service, or ephemeral session tokens).
3. **No Repository Secret Pollution**: The `.devweave/` directory stores only declarative configuration matching `provider-config.schema.json`.
4. **Platform Neutrality**: Provide equivalent guidance across Windows (PowerShell/winget/choco), macOS (Homebrew), and Linux (apt/dnf/apk).
