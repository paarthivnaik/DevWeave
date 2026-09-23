---
name: devweave-modernization-analyze
description: "[Modernization Phase 2: Analyze] Deeply analyze legacy behaviors, business rules, API schemas, and data structures against target architecture; produce analysis.md, migration mappings.json, and enforce Hard Gate #1."
---

# OpenAI Codex Modernization Analysis Command (`codex run devweave-modernization-analyze`)

## Purpose
Perform deep technical analysis of legacy functional behaviors, validation rules, transactional boundaries, API contracts, and database queries. Map every legacy component to its target architectural equivalent, synthesize `mappings.json`, and halt at **Mandatory Human-in-the-Loop Hard Gate #1**.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- `phases.CONTEXT` is `COMPLETED`.

---

## Allowed Actions
1. Analyze legacy business logic, state machines, validation rules, and corner-case handling.
2. Formulate target architectural design adhering to declared patterns (e.g., CQRS Command/Query split, Mediator, Repository pattern).
3. Generate formal migration relationships (`MIGRATED_TO`, `REPLACED_BY`, `TRANSFORMED_TO`, `SPLIT_INTO`, `MERGED_INTO`, `PRESERVED_AS`, `RETIRED`, `DEFERRED`).
4. Identify schema migration needs, foreign key changes, and REST API contract equivalents.
5. Create `analysis.md` and `mappings.json`.

---

## Artifacts Generated
```text
.devweave/modernization/<ID>/
├── analysis.md
└── mappings.json
```

---

## State Updates
- Sets `currentPhase` = `ANALYZE`
- Sets `phases.ANALYZE` = `WAITING_APPROVAL`
- Sets `status` = `WAITING_FOR_HUMAN`
- Sets `nextSuggestedPhase` = `PLAN` (only applicable after approval)

---

## Human Checkpoint: HARD GATE #1
- **Mandatory checkpoint**: Modernization analysis and mapping cannot proceed to planning without explicit human authorization.
- Supported decisions:
  - `APPROVE` &rarr; unlocks `PLAN`.
  - `REQUEST_CHANGES` &rarr; updates `phases.ANALYZE` = `CHANGES_REQUESTED`, preserves `analysis.v1.md`, and requests revision.
  - `PROVIDE_INFORMATION` &rarr; incorporates additional architectural context.
  - `REJECT` / `STOP` &rarr; terminates modernization pipeline.

---

## Next Suggested Command
```text
devweave-modernization-plan <ID>  (Requires APPROVE)
```

---

## STOP Rule
- Upon completing analysis and presenting findings, **STOP IMMEDIATELY**.
