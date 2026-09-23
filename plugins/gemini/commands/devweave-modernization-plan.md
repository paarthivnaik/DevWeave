---
name: devweave-modernization-plan
description: "[Modernization Phase 3: Plan] Decompose approved architectural analysis into file-anchored implementation tasks, unit/integration test specifications, database migration scripts, and enforce Hard Gate #2."
---

# Gemini CLI Modernization Planning Command (`gemini devweave-modernization-plan`)

## Purpose
Construct a deterministic, file-level implementation plan that maps target files to create/modify/retire, specifies test scenarios, defines database migration steps, establishes validation commands, and halts at **Mandatory Human-in-the-Loop Hard Gate #2**.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- `phases.ANALYZE` is `APPROVED` (Hard Gate #1 must be passed).

---

## Allowed Actions
1. Map target files to create, update, or retire with exact symbol signatures and path layouts.
2. Formulate database migration scripts (idempotent SQL/EF Core migrations).
3. Formulate unit and integration test definitions covering parity against legacy behavior.
4. Define concrete build, test, and verification shell commands.
5. Create `plan.md`.

---

## Artifacts Generated
```text
.devweave/modernization/<ID>/
└── plan.md
```

---

## State Updates
- Sets `currentPhase` = `PLAN`
- Sets `phases.PLAN` = `WAITING_APPROVAL`
- Sets `status` = `WAITING_FOR_HUMAN`
- Sets `nextSuggestedPhase` = `BRANCH` (only applicable after approval)

---

## Human Checkpoint: HARD GATE #2
- **Mandatory checkpoint**: Code modifications cannot begin without explicit human plan approval.
- Supported decisions:
  - `APPROVE` &rarr; unlocks `BRANCH` and `IMPLEMENT`.
  - `REQUEST_CHANGES` &rarr; updates `phases.PLAN` = `CHANGES_REQUESTED` and preserves plan versions (`plan.v1.md`, `plan.v2.md`).
  - `STOP` &rarr; halts execution.

---

## Next Suggested Command
```text
devweave-modernization-branch <ID>  (Requires APPROVE)
```

---

## STOP Rule
- Upon writing `plan.md` and presenting the plan, **STOP IMMEDIATELY**.
