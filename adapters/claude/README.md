# DevWeave Adapter for Anthropic Claude Code

This adapter package implements the **DevWeave AI-DLC Host Contract** for **Anthropic Claude Code**.

---

## Directory Structure

```text
adapters/claude/
├── manifest/
│   └── adapter.yaml          # Capability mapping to Claude 3.5/3.7 Sonnet, Haiku, and Opus
├── agents/                   # Subagent role definitions (Architect, DBA, Reviewer, etc.)
├── rules/
│   └── devweave-core.md      # AI-DLC core rules and phase boundary constraints
├── workflows/                # 8 Workflow profile execution graphs (feature, bug, etc.)
└── templates/                # Artifact generation templates (context, plan, review, PR)
```

---

## Capability Resolution

- `fast-analysis`: **Claude 3.5 Haiku**
- `reasoning`: **Claude 3.5 Sonnet**
- `deep-reasoning`: **Claude 3.7 Sonnet (Thinking)**
- `coding`: **Claude 3.5 Sonnet**
- `coding-and-analysis`: **Claude 3.7 Sonnet**
- `independent-reasoning`: **Claude 3.7 Sonnet**
- `independent-review`: **Claude 3 Opus**
