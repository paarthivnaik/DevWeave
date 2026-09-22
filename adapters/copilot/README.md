# DevWeave Adapter for GitHub Copilot

This adapter package implements the **DevWeave AI-DLC Host Contract** for **GitHub Copilot Workspace, Copilot Chat, and GitHub CLI**.

---

## Directory Structure

```text
adapters/copilot/
├── manifest/
│   └── adapter.yaml          # Capability mapping to GPT-4o, GPT-4o-mini, o3-mini, o1
├── agents/                   # Copilot agent personas (Architect, DBA, Reviewer, etc.)
├── rules/
│   └── devweave-core.md      # AI-DLC core rules and phase boundary constraints
├── workflows/                # 8 Workflow profile execution graphs (feature, bug, etc.)
└── templates/                # Artifact generation templates (context, plan, review, PR)
```

---

## Capability Resolution

- `fast-analysis`: **GPT-4o-mini**
- `reasoning`: **GPT-4o**
- `deep-reasoning`: **o3-mini**
- `coding`: **GPT-4o**
- `coding-and-analysis`: **Claude 3.5 Sonnet (Copilot Chat)**
- `independent-reasoning`: **o1**
- `independent-review`: **Claude 3.5 Sonnet / o1**
