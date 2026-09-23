# DevWeave for Cognition Devin

DevWeave integrates natively with **Cognition Devin** via the [`plugins/devin/`](file:///D:/DevWeave/plugins/devin/) playbook package.

---

## 1. Playbook Package Structure

```text
plugins/devin/
├── plugin.json               # Devin playbook manifest
├── DEVIN.md                  # Autonomous AI-DLC playbook instructions & safety gates
└── commands/                 # 31 Devin playbook commands
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

## 2. Installation & Autonomous Execution

### Setup from GitHub

```bash
# In your Devin workspace:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .devin && cp -r /tmp/devweave/plugins/devin/* .devin/ && rm -rf /tmp/devweave
```

### Execute Canonical Feature Workflow
```bash
devin run /devweave-init
devin run /devweave-context "JIRA-101"
devin run /devweave-analyze "JIRA-101"
devin run /devweave-plan "JIRA-101"
devin run /devweave-branch "JIRA-101"
devin run /devweave-implement "JIRA-101"
devin run /devweave-pr-review "JIRA-101"  # Dual-Model Review (Architect + DBA)
devin run /devweave-pr "JIRA-101"         # PR Packaging & Gate
```

### Execute V1.1 Modernization Workflow
```bash
devin run /devweave-modernization-init "Angular frontend with CQRS backend and PostgreSQL"
devin run /devweave-modernization-context "MOD-101"
devin run /devweave-modernization-analyze "MOD-101"   # [HARD GATE #1]
devin run /devweave-modernization-plan "MOD-101"      # [HARD GATE #2]
devin run /devweave-modernization-branch "MOD-101"
devin run /devweave-modernization-implement "MOD-101"
devin run /devweave-modernization-verify "MOD-101"    # [HARD GATE #3]
devin run /devweave-modernization-pr "MOD-101"
```

---

## 3. Capability Resolution

- `fast-analysis`: **Devin Fast Engine**
- `reasoning` & `coding`: **Devin Standard Engine**
- `deep-reasoning` & `independent-review`: **Devin Deep Research & Expert Review**
