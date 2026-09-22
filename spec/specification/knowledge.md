# DevWeave Knowledge Architecture Specification

The Knowledge Architecture structures domain rules, technical patterns, component behaviors, and architectural decisions into an easily indexed, Git-friendly knowledge graph.

---

## 1. Knowledge Hierarchy

Knowledge is organized hierarchically from broad repository patterns down to granular task lessons:

```text
Repository Level
       │
       ▼
Architecture Level
       │
       ▼
Domain Level
       │
       ▼
Technical Level
       │
       ▼
Component Level
       │
       ▼
Work Item Level
```

---

## 2. Knowledge Status Lifecycle

Every knowledge item progresses through a structured confidence and lifecycle status:

| Status | Description |
| :--- | :--- |
| `OBSERVED` | Extracted directly from existing code, commits, or configuration during initial scan. |
| `INFERRED` | Deduced by an AI agent during requirements or solution design, awaiting validation. |
| `RECOMMENDED` | Proposed by an agent or human as an optimal convention or best practice. |
| `APPROVED` | Formally validated and confirmed by human maintainers or automated test evidence. |
| `DEPRECATED` | Outdated knowledge superseded by new architecture or refactored components. |

---

## 3. Storage Format

Knowledge items are stored as individual YAML/Markdown files in `.devweave/knowledge/` partitioned by domain or layer, ensuring conflict-free Git branching and mergeability:

```text
.devweave/knowledge/
├── architecture/
│   └── event-bus-contract.md
├── domain/
│   └── billing-invoicing-rules.md
└── technical/
    └── database-transactions.md
```
