# DevWeave Token Efficiency Specification

DevWeave guarantees maximum software engineering impact per token consumed.

---

## 1. Prioritization Hierarchy

When selecting knowledge and code to populate a context payload, the context engine enforces strict prioritization:

```text
Priority 1: Direct File Diff / Target Code Snippet
Priority 2: Approved, High-Confidence Knowledge Items
Priority 3: Immediate Interface & Type Contracts
Priority 4: Failing Test Outputs / Compiler Errors (in Fix Loops)
Priority 5: Historical Architectural Decisions (ADRs)
─────────────────────────────────────────────────────
Excluded:   Unrelated Source Files, Raw Lockfiles, Redundant Boilerplate
```

---

## 2. Token Budgeting by Task Type

| Task Scope | Recommended Input Budget | Output Budget | Target Model Tier |
| :--- | :--- | :--- | :--- |
| Quick Fix / Formatting | < 4,000 tokens | < 1,000 tokens | `flash_lite` / `flash` |
| Standard Bug / Unit Test | < 16,000 tokens | < 3,000 tokens | `flash` / `pro` |
| Full Feature / API Endpoint | < 40,000 tokens | < 6,000 tokens | `pro` |
| Complex Architecture / Migration | < 80,000 tokens | < 12,000 tokens | `pro` / `reasoning` |

---

## 3. Impact Analysis Pipeline

```text
Work Item Received
       │
       ▼
Blast-Radius / Impact Analysis
  (Identifies specific affected modules & tests)
       │
       ▼
Targeted Knowledge Query
  (Pulls only matching KB items from .devweave/knowledge/)
       │
       ▼
Context Assembly
  (Synthesizes bounded prompt within token budget)
       │
       ▼
Agent Execution & Verification
```
