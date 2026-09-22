# DevWeave for OpenAI Codex & ChatGPT CLI

DevWeave integrates natively with **OpenAI Codex and ChatGPT CLI** via the [`plugins/codex/`](file:///D:/DevWeave/plugins/codex/) plugin package.

---

## 1. Plugin Package Structure

```text
plugins/codex/
├── plugin.json               # OpenAI Codex plugin manifest
├── CODEX.md                  # Core AI-DLC lifecycle rules, phase boundaries & secret policies
└── commands/                 # 20 Codex commands
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

```bash
# Register plugin in OpenAI / ChatGPT CLI
codex plugin install path/to/DevWeave/plugins/codex

# Run 7-phase workflow
codex run devweave-init
codex run devweave-context "JIRA-101"
codex run devweave-analyze "JIRA-101"
codex run devweave-plan "JIRA-101"
codex run devweave-branch "JIRA-101"
codex run devweave-implement "JIRA-101"
codex run devweave-pr-review "JIRA-101"  # Dual-Model Review (Architect + DBA)
codex run devweave-pr "JIRA-101"         # PR Packaging & Gate
```

---

## 3. Capability Resolution

- `fast-analysis`: **GPT-4o-mini**
- `reasoning` & `coding`: **GPT-4o**
- `deep-reasoning` & `independent-review`: **o3-mini / o1**
