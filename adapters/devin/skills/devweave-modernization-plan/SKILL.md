---
name: devweave-modernization-plan
description: "[Modernization Phase 3: Plan] Decompose approved architectural analysis into file-anchored implementation tasks, unit/integration test specifications, database migration scripts, update audit.md, and enforce Hard Gate #2."
---

# Cognition Devin Modernization Planning Command (`devin run /devweave-modernization-plan`)

## Purpose
Construct a deterministic, file-level implementation plan that maps target files to create/modify/retire, specifies test scenarios, defines database migration steps, establishes validation commands, logs plan details and approvals into `audit.md`, and halts at **Mandatory Human-in-the-Loop Hard Gate #2**.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`).

---

## Preconditions
- `phases.ANALYZE` is `APPROVED` (Hard Gate #1 must be passed).

---

## Allowed Actions
1. **Mandatory Description Prompting**: Ask developer for any specific plan constraints or technical preferences.
2. Map target files to create, update, or retire with exact symbol signatures and path layouts.
3. Formulate database migration scripts (idempotent SQL/EF Core migrations).
4. Formulate unit and integration test definitions covering parity against legacy behavior.
5. Define concrete build, test, and verification shell commands.
6. Create `plan.md`.
7. Append ONLY human developer prompts and custom instructions to `.devweave/modernization/stories/<ID>/audit.md`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── plan.md                     <-- File-anchored implementation plan
└── audit.md                    <-- Updated with user activity log
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
  - `APPROVE` &rarr; unlocks `BRANCH` and `IMPLEMENT` (logged in `audit.md`).
  - `REQUEST_CHANGES` &rarr; updates `phases.PLAN` = `CHANGES_REQUESTED`, preserves plan versions (`plan.v1.md`, `plan.v2.md`), logs feedback in `audit.md`, and requests revision.
  - `STOP` &rarr; halts execution.

---

## Next Suggested Command
```text
devweave-modernization-branch <ID>  (Requires APPROVE)
```

---

## STOP Rule
- Upon writing `plan.md`, updating `audit.md`, and presenting the plan, **STOP IMMEDIATELY**.
- Upon receiving `APPROVE` at Hard Gate #2, record approval in state/audit and **STOP IMMEDIATELY**. Never auto-progress to BRANCH or IMPLEMENT.
