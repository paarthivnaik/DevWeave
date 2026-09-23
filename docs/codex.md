# DevWeave for OpenAI Codex & ChatGPT CLI

DevWeave integrates natively with **OpenAI Codex and ChatGPT CLI** via the [`plugins/codex/`](file:///D:/DevWeave/plugins/codex/) plugin package.

---

## 1. Plugin Package Structure

```text
plugins/codex/
├── plugin.json               # OpenAI Codex plugin manifest
├── CODEX.md                  # Core AI-DLC lifecycle rules, phase boundaries & secret policies
└── commands/                 # 31 Codex commands
    ├── devweave-init.md
    ├── devweave-context.md
    ├── devweave-analyze.md
    ├── devweave-plan.md
    ├── devweave-branch.md
    ├── devweave-implement.md
    ├── devweave-pr-review.md
    ├── devweave-pr.md
    ├── devweave-modernization-init.md
    ├── devweave-modernization-context.md
    ├── devweave-modernization-analyze.md
    ├── devweave-modernization-plan.md
    ├── devweave-modernization-branch.md
    ├── devweave-modernization-implement.md
    ├── devweave-modernization-verify.md
    ├── devweave-modernization-pr.md
    ├── devweave-modernization-status.md
    ├── devweave-modernization-report.md
    └── ... (Fix Lane, Modernize, Express, Utilities)
```

---

## 2. Installation & CLI Execution

### One-Liner Install from GitHub

```bash
# macOS / Linux / Git Bash:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .codex/commands && cp /tmp/devweave/plugins/codex/CODEX.md .codex/CODEX.md && cp /tmp/devweave/plugins/codex/commands/* .codex/commands/ && rm -rf /tmp/devweave
```

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .codex\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\codex\CODEX.md .codex/CODEX.md; Copy-Item $env:TEMP\devweave\plugins\codex\commands\* .codex\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
```

### Run Canonical Feature Workflow
```bash
codex run devweave-init
codex run devweave-context "JIRA-101"
codex run devweave-analyze "JIRA-101"
codex run devweave-plan "JIRA-101"
codex run devweave-branch "JIRA-101"
codex run devweave-implement "JIRA-101"
codex run devweave-pr-review "JIRA-101"  # Dual-Model Review (Architect + DBA)
codex run devweave-pr "JIRA-101"         # PR Packaging & Gate
```

### Run V1.1 Modernization Workflow
```bash
codex run devweave-modernization-init "Angular frontend with CQRS backend and PostgreSQL"
codex run devweave-modernization-context "MOD-101"
codex run devweave-modernization-analyze "MOD-101"   # [HARD GATE #1]
codex run devweave-modernization-plan "MOD-101"      # [HARD GATE #2]
codex run devweave-modernization-branch "MOD-101"
codex run devweave-modernization-implement "MOD-101"
codex run devweave-modernization-verify "MOD-101"    # [HARD GATE #3]
codex run devweave-modernization-pr "MOD-101"
```

---

## 3. Capability Resolution

- `fast-analysis`: **GPT-4o-mini**
- `reasoning` & `coding`: **GPT-4o**
- `deep-reasoning` & `independent-review`: **o3-mini / o1**
