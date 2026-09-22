# DevWeave Best-Practice Adaptation Specification

DevWeave dynamically selects and binds engineering best practices based on the detected technology stack, framework versions, and the active task's blast radius.

---

## 1. Practice Classifications

Practices are categorized into four standard tiers:

| Tier | Meaning | Enforcement |
| :--- | :--- | :--- |
| **`MANDATORY`** | Strict security, compliance, or architecture invariants. | Blocking gate in verification and review. |
| **`RECOMMENDED`** | High-signal idiomatic engineering patterns (e.g. AsNoTracking on read-only queries). | High priority in solution and code review. |
| **`ADVISORY`** | Non-blocking optimization or maintainability suggestions. | Contextual note in review findings. |
| **`ANTI_PATTERN`** | Known anti-patterns (e.g. N+1 queries, swallowing exceptions, mutating props). | Flagged by reviewers for remediation. |

---

## 2. Precedence Hierarchy

When multiple guidance sources apply to a task, DevWeave resolves conflicts using strict precedence:

```text
Priority 1 (Highest): Repository-Established Conventions (.devweave/knowledge/)
Priority 2:           Official Framework / Language Guidance
Priority 3:           Enterprise / Organization Standards
Priority 4 (Lowest):  Generic AI Recommendations
```

> **Invariant**: DevWeave never overrides an established repository convention with a generic rule unless explicitly flagged as a security violation.

---

## 3. Contextual Practice Injection

Practices are never dumped en masse into model context. They are injected selectively based on:
- Detected technology and version
- Active work item type (`FEATURE`, `BUG`, `REFACTOR`, `DATABASE`, etc.)
- Specific target files and components touched in `plan.md`
