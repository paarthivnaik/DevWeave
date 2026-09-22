# DevWeave for GitHub Copilot

DevWeave integrates natively with **GitHub Copilot Workspace, Copilot Chat, and GitHub CLI** via the [`plugins/copilot/`](file:///D:/DevWeave/plugins/copilot/) plugin package.

---

## 1. Plugin Package Structure

```text
plugins/copilot/
├── plugin.json               # Copilot extension manifest
├── copilot-instructions.md   # AI-DLC repository custom instructions
└── prompts/                  # 20 Copilot prompt files (.prompt.md)
    ├── devweave-init.prompt.md
    ├── devweave-context.prompt.md
    ├── devweave-analyze.prompt.md
    ├── devweave-plan.prompt.md
    ├── devweave-branch.prompt.md
    ├── devweave-implement.prompt.md
    ├── devweave-pr-review.prompt.md
    ├── devweave-pr.prompt.md
    ├── devweave-fix-triage.prompt.md
    ├── devweave-fix-diagnose.prompt.md
    ├── devweave-fix-land.prompt.md
    ├── devweave-modernize.prompt.md
    ├── devweave-express.prompt.md
    ├── devweave-status.prompt.md
    ├── devweave-handoff.prompt.md
    ├── devweave-archive.prompt.md
    ├── devweave-report.prompt.md
    ├── devweave-improve.prompt.md
    ├── devweave-document-product.prompt.md
    └── devweave-document-domain.prompt.md
```

---

## 2. Installation in GitHub Repositories

### Repository Setup (`.github/` instructions)
Copy `copilot-instructions.md` and `prompts/` to `.github/`:

```bash
# In your target repository:
mkdir -p .github/prompts
cp path/to/DevWeave/plugins/copilot/copilot-instructions.md .github/copilot-instructions.md
cp path/to/DevWeave/plugins/copilot/prompts/* .github/prompts/
```

### GitHub Copilot Extension Registration
```bash
gh extension install path/to/DevWeave/plugins/copilot
```

---

## 3. Workflow Execution in GitHub Copilot

### Copilot Chat Prompts:
```text
@devweave /init
@devweave /context JIRA-101
@devweave /analyze JIRA-101
@devweave /plan JIRA-101
@devweave /branch JIRA-101      # [HARD GATE]
@devweave /implement JIRA-101
@devweave /pr-review JIRA-101   # Dual-Model Review (Architect + DBA) [HARD GATE]
@devweave /pr JIRA-101          # Final PR Packaging [HARD GATE]
```

### Fix Lane:
```text
@devweave /fix-triage BUG-202
@devweave /fix-diagnose BUG-202
@devweave /fix-land BUG-202
```

---

## 4. Capability & Model Resolution

GitHub Copilot automatically maps abstract AI-DLC capabilities:
- `fast-analysis`: **GPT-4o-mini**
- `reasoning` & `coding`: **GPT-4o**
- `deep-reasoning` & `independent-review`: **o1 / o3-mini / Claude 3.5 Sonnet**
