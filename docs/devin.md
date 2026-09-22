# DevWeave for Cognition Devin

DevWeave integrates natively with **Cognition Devin** via the [`plugins/devin/`](file:///D:/DevWeave/plugins/devin/) playbook package.

---

## 1. Playbook Package Structure

```text
plugins/devin/
├── plugin.json               # Devin playbook manifest
├── DEVIN.md                  # Autonomous AI-DLC playbook instructions & safety gates
└── commands/                 # 20 Devin playbook commands
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

## 2. Installation & Autonomous Execution

```bash
# Load playbook into Devin project
devin playbook load path/to/DevWeave/plugins/devin

# Execute workflow autonomously with human checkpoints
devin run /devweave-init
devin run /devweave-context "JIRA-101"
devin run /devweave-analyze "JIRA-101"
devin run /devweave-plan "JIRA-101"
devin run /devweave-branch "JIRA-101"
devin run /devweave-implement "JIRA-101"
devin run /devweave-pr-review "JIRA-101"  # Dual-Model Review (Architect + DBA)
devin run /devweave-pr "JIRA-101"         # PR Packaging & Gate
```

---

## 3. Capability Resolution

- `fast-analysis`: **Devin Fast Engine**
- `reasoning` & `coding`: **Devin Standard Engine**
- `deep-reasoning` & `independent-review`: **Devin Deep Research & Expert Review**
