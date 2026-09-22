# DevWeave Context Engineering Specification

The Context Engine constructs minimal, high-signal, deterministic prompts for agents, ensuring tasks execute within optimal token budgets without missing essential project context.

---

## 1. Context Assembly Formula

For any given task in an AI-DLC phase, the agent context payload is composed dynamically:

$$\text{Context} = \text{Work Item} + \text{Affected Domain KB} + \text{Target Interfaces/Schemas} + \text{Relevant Code Chunks} + \text{Active Constraints}$$

```text
┌─────────────────────────────────────────────────────────┐
│                    Work Item Spec                       │
│           (Goal, Acceptance Criteria, Scope)            │
├─────────────────────────────────────────────────────────┤
│                 Relevant Knowledge                      │
│        (Extracted Domain Rules & Conventions)           │
├─────────────────────────────────────────────────────────┤
│               Target Component Contracts                │
│             (Type definitions, API schemas)             │
├─────────────────────────────────────────────────────────┤
│                 Focused Code Snippets                   │
│             (Specific files needing edits)              │
├─────────────────────────────────────────────────────────┤
│                  Active Constraints                     │
│       (Lint rules, security policies, test commands)    │
└─────────────────────────────────────────────────────────┘
```

---

## 2. Anti-Patterns Forbidden by DevWeave

- **Repo Dumping**: Ingesting entire source directories into context when only a subset of files is touched.
- **Unbounded Tree Scans**: Recursively listing all directory contents without filtering ignored directories (`node_modules`, `bin`, `obj`, `dist`, `.git`).
- **Raw Dependency Dumps**: Injecting full 10,000-line lockfiles into prompt context instead of reading only the relevant top-level packages.
