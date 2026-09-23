# DevWeave for Google Gemini CLI

DevWeave integrates natively with **Google Gemini CLI** via the [`plugins/gemini/`](file:///D:/DevWeave/plugins/gemini/) plugin package.

---

## 1. Plugin Package Structure

```text
plugins/gemini/
├── plugin.json               # Gemini CLI plugin manifest
├── GEMINI.md                 # Core AI-DLC lifecycle rules, phase boundaries & secret policies
└── commands/                 # 20 Gemini CLI commands
    ├── devweave-init.md
    ├── devweave-context.md
    ├── devweave-analyze.md
    ├── devweave-plan.md
    ├── devweave-branch.md
    ├── devweave-implement.md
    ├── devweave-pr-review.md
    ├── devweave-pr.md
    └── ... (Fix Lane, Modernize, Express, Utilities)
```

---

## 2. Installation & CLI Execution

### One-Liner Install from GitHub

```bash
# macOS / Linux / Git Bash:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .gemini/commands && cp /tmp/devweave/plugins/gemini/GEMINI.md .gemini/GEMINI.md && cp /tmp/devweave/plugins/gemini/commands/* .gemini/commands/ && rm -rf /tmp/devweave
```

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .gemini\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\gemini\GEMINI.md .gemini\GEMINI.md; Copy-Item $env:TEMP\devweave\plugins\gemini\commands\* .gemini\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
```

### Run 7-Phase Workflow
```bash
gemini devweave-init
gemini devweave-context "JIRA-101"
gemini devweave-analyze "JIRA-101"
gemini devweave-plan "JIRA-101"
gemini devweave-branch "JIRA-101"
gemini devweave-implement "JIRA-101"
gemini devweave-pr-review "JIRA-101"   # Dual-Model Review (Architect + DBA)
gemini devweave-pr "JIRA-101"          # PR Packaging & Gate
```

---

## 3. Capability Resolution

- `fast-analysis`: **Gemini 2.0 Flash Lite**
- `reasoning` & `coding`: **Gemini 2.0 Flash**
- `deep-reasoning` & `independent-review`: **Gemini 2.0 Pro / Flash Thinking**
