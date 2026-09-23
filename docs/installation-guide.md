# DevWeave V1.0 — Universal Installation & Setup Guide

Welcome to the **DevWeave Multi-Host Installation Guide**.

DevWeave is designed from first principles to be **100% host-neutral**. Whether you use **Google Antigravity**, **Anthropic Claude Code**, **GitHub Copilot**, **Google Gemini CLI**, **OpenAI Codex**, or **Cognition Devin**, this guide provides clear, step-by-step instructions from junior developer onboarding to enterprise DevOps deployment.

---

## Quick Platform Selector

```mermaid
flowchart TD
    DEV["<b>Target Project Repository</b>"] --> HOST{"Select Your AI Coding Host"}

    HOST -->|1| AGY["<b>Google Antigravity</b><br><code>agy plugin install</code>"]
    HOST -->|2| CLAUDE["<b>Anthropic Claude Code</b><br><code>claude plugin add</code>"]
    HOST -->|3| COPILOT["<b>GitHub Copilot</b><br><code>gh extension install / .github</code>"]
    HOST -->|4| GEMINI["<b>Google Gemini CLI</b><br><code>gemini plugin add</code>"]
    HOST -->|5| CODEX["<b>OpenAI Codex / ChatGPT CLI</b><br><code>codex plugin install</code>"]
    HOST -->|6| DEVIN["<b>Cognition Devin</b><br><code>devin playbook load</code>"]
```

---

## 1. Google Antigravity Installation

Install DevWeave directly from GitHub into your Antigravity environment:

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; agy plugin install $env:TEMP\devweave\plugins\antigravity; Remove-Item -Recurse -Force $env:TEMP\devweave
```

```bash
# macOS / Linux (Bash):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && agy plugin install /tmp/devweave/plugins/antigravity && rm -rf /tmp/devweave
```

### Verification:
```powershell
agy plugin list
# Expected output: devweave (plugins/antigravity) - Status: active, Skills: 20 available
```

---

## 2. Anthropic Claude Code Installation

Install DevWeave rules and 20 custom slash commands from GitHub into your target project:

```bash
# macOS / Linux / Git Bash:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .claude/commands && cp /tmp/devweave/plugins/claude/CLAUDE.md ./CLAUDE.md && cp /tmp/devweave/plugins/claude/commands/* .claude/commands/ && rm -rf /tmp/devweave
```

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .claude\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\claude\CLAUDE.md .\CLAUDE.md; Copy-Item $env:TEMP\devweave\plugins\claude\commands\* .claude\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
```

### Verification:
Open Claude Code in your project and run:
```bash
claude /devweave-init
```

---

## 3. GitHub Copilot Installation (Workspace, Chat, CLI)

Install DevWeave prompt definitions and custom instructions into your repository's `.github/` folder:

```bash
# macOS / Linux / Git Bash:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .github/prompts && cp /tmp/devweave/plugins/copilot/copilot-instructions.md .github/copilot-instructions.md && cp /tmp/devweave/plugins/copilot/prompts/* .github/prompts/ && rm -rf /tmp/devweave
```

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .github\prompts | Out-Null; Copy-Item $env:TEMP\devweave\plugins\copilot\copilot-instructions.md .github\copilot-instructions.md; Copy-Item $env:TEMP\devweave\plugins\copilot\prompts\* .github\prompts\; Remove-Item -Recurse -Force $env:TEMP\devweave
```

### Verification in Copilot Chat:
Type `@devweave /init` in the GitHub Copilot Chat window in VS Code, Visual Studio, or CLI.

---

## 4. Google Gemini CLI Installation

Install DevWeave configuration and commands from GitHub into your Gemini CLI project:

```bash
# macOS / Linux / Git Bash:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .gemini/commands && cp /tmp/devweave/plugins/gemini/GEMINI.md .gemini/GEMINI.md && cp /tmp/devweave/plugins/gemini/commands/* .gemini/commands/ && rm -rf /tmp/devweave
```

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .gemini\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\gemini\GEMINI.md .gemini\GEMINI.md; Copy-Item $env:TEMP\devweave\plugins\gemini\commands\* .gemini\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
```

### Verification:
```bash
gemini devweave-init
```

---

## 5. OpenAI Codex & ChatGPT CLI Installation

Install DevWeave instructions and commands from GitHub into your project:

```bash
# macOS / Linux / Git Bash:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .codex/commands && cp /tmp/devweave/plugins/codex/CODEX.md .codex/CODEX.md && cp /tmp/devweave/plugins/codex/commands/* .codex/commands/ && rm -rf /tmp/devweave
```

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .codex\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\codex\CODEX.md .codex\CODEX.md; Copy-Item $env:TEMP\devweave\plugins\codex\commands\* .codex\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
```

### Verification:
```bash
codex run devweave-init
```

---

## 6. Cognition Devin Playbook Installation

Install the DevWeave playbook from GitHub into your Devin workspace:

```bash
# In your Devin workspace:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .devin && cp -r /tmp/devweave/plugins/devin/* .devin/ && rm -rf /tmp/devweave
```

### Verification:
Run `/devweave-init` in the Devin interactive console to trigger autonomous 5-layer repository detection.

---

## 7. Canonical Workflow Execution Across All Platforms

Regardless of which AI coding host you use, the command sequence and state progression remain identical:

| Phase | Antigravity (`agy run`) | Claude Code (`claude /`) | GitHub Copilot (`@devweave`) | Gemini / Codex / Devin |
|---|---|---|---|---|
| **Phase 0: Init** | `agy run devweave-init` | `/devweave-init` | `@devweave /init` | `devweave-init` |
| **Phase 1: Context** | `agy run devweave-context <ID>` | `/devweave-context <ID>` | `@devweave /context <ID>` | `devweave-context <ID>` |
| **Phase 2: Analyze** | `agy run devweave-analyze <ID>` | `/devweave-analyze <ID>` | `@devweave /analyze <ID>` | `devweave-analyze <ID>` |
| **Phase 3: Plan** | `agy run devweave-plan <ID>` | `/devweave-plan <ID>` | `@devweave /plan <ID>` | `devweave-plan <ID>` |
| **Phase 4: Branch** | `agy run devweave-branch <ID>` | `/devweave-branch <ID>` | `@devweave /branch <ID>` | `devweave-branch <ID>` |
| **Phase 5: Implement**| `agy run devweave-implement <ID>`| `/devweave-implement <ID>`| `@devweave /implement <ID>` | `devweave-implement <ID>` |
| **Phase 6: PR Review**| `agy run devweave-pr-review <ID>`| `/devweave-pr-review <ID>`| `@devweave /pr-review <ID>` | `devweave-pr-review <ID>` |
| **Phase 7: PR** | `agy run devweave-pr <ID>` | `/devweave-pr <ID>` | `@devweave /pr <ID>` | `devweave-pr <ID>` |

---

## 8. Troubleshooting & FAQ

### Q1: Does DevWeave require a background server or Node runtime?
**No.** DevWeave is 100% declarative. It executes statelessly within agent turns and stores its state directly in your Git repository under `.devweave/`.

### Q2: How do I update DevWeave to the latest version?
Simply pull the latest changes from Git and re-run the install command:
```powershell
cd path/to/DevWeave
git pull origin develop
agy plugin install .\plugins\antigravity
```

### Q3: How do I remove the plugin?
```powershell
agy plugin uninstall devweave
# Or for Claude:
claude plugin remove devweave
# Or for Copilot:
gh extension remove devweave
```
