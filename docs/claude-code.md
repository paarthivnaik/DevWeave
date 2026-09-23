# DevWeave for Claude Code

DevWeave integrates natively with **Anthropic Claude Code** via the [`plugins/claude/`](file:///D:/DevWeave/plugins/claude/) plugin package.

---

## 1. Plugin Package Structure

```text
plugins/claude/
├── plugin.json               # Claude Code plugin manifest
├── CLAUDE.md                 # Core AI-DLC lifecycle rules, phase boundaries & secret policies
└── commands/                 # 31 Claude Code custom slash commands
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
    ├── devweave-fix-triage.md
    ├── devweave-fix-diagnose.md
    ├── devweave-fix-land.md
    ├── devweave-modernize.md
    ├── devweave-express.md
    ├── devweave-update.md
    ├── devweave-status.md
    ├── devweave-handoff.md
    ├── devweave-archive.md
    ├── devweave-report.md
    ├── devweave-improve.md
    ├── devweave-document-product.md
    └── devweave-document-domain.md
```

---

## 2. Installation in Claude Code

### One-Liner Install from GitHub

```bash
# macOS / Linux / Git Bash:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .claude/commands && cp /tmp/devweave/plugins/claude/CLAUDE.md ./CLAUDE.md && cp /tmp/devweave/plugins/claude/commands/* .claude/commands/ && rm -rf /tmp/devweave
```

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .claude\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\claude\CLAUDE.md .\CLAUDE.md; Copy-Item $env:TEMP\devweave\plugins\claude\commands\* .claude\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
```

---

## 3. Workflow Execution in Claude Code

### Canonical 7-Phase Flow:
```bash
claude /devweave-init
claude /devweave-context "JIRA-101"
claude /devweave-analyze "JIRA-101"
claude /devweave-plan "JIRA-101"
claude /devweave-branch "JIRA-101"      # [HARD GATE]
claude /devweave-implement "JIRA-101"
claude /devweave-pr-review "JIRA-101"   # Dual-Model Review (Architect + DBA) [HARD GATE]
claude /devweave-pr "JIRA-101"          # Final PR Packaging [HARD GATE]
```

### V1.1 Modernization Workflow:
```bash
claude /devweave-modernization-init "Angular signals frontend with CQRS backend and PostgreSQL"
claude /devweave-modernization-context "MOD-101"
claude /devweave-modernization-analyze "MOD-101"   # [HARD GATE #1]
claude /devweave-modernization-plan "MOD-101"      # [HARD GATE #2]
claude /devweave-modernization-branch "MOD-101"
claude /devweave-modernization-implement "MOD-101"
claude /devweave-modernization-verify "MOD-101"    # [HARD GATE #3]
claude /devweave-modernization-pr "MOD-101"
```

### Fix Lane:
```bash
claude /devweave-fix-triage "BUG-202"
claude /devweave-fix-diagnose "BUG-202"
claude /devweave-fix-land "BUG-202"
```

---

## 4. Capability & Model Resolution

Claude Code automatically maps abstract AI-DLC capabilities to Anthropic models:
- `fast-analysis`: **Claude 3.5 Haiku**
- `reasoning` & `coding`: **Claude 3.5 Sonnet / Claude 3.7 Sonnet**
- `deep-reasoning` & `independent-review`: **Claude 3.7 Sonnet (Thinking) / Claude 3 Opus**
