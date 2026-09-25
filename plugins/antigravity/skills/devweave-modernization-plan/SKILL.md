---
name: devweave-modernization-plan
description: "[Modernization Phase 3: Plan] Decompose approved architectural analysis into file-anchored implementation tasks, unit/integration test specifications, database migration scripts, update audit.md, and enforce Hard Gate #2."
---

# Antigravity Modernization Planning Skill (`devweave-modernization-plan`)

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
1. **Mandatory Disk-First Artifact Ingestion**: Before constructing the plan, the agent **MUST EXPLICITLY READ DISK ARTIFACTS (`view_file`)** from `.devweave/modernization/stories/<ID>/` (`analysis.md`, `mappings.json`, `context.md`, `work-item.json`, `state.json`) and `.devweave/modernization/` (`architecture-intent.json`, `technology-profile.json`). Never rely on ephemeral conversation memory.
2. **Mandatory Description Prompting**: Ask developer for any specific plan constraints or technical preferences.
3. Map target files to create, update, or retire with exact symbol signatures and path layouts.
4. Formulate database migration scripts (idempotent SQL/EF Core migrations).
5. Formulate unit and integration test definitions covering parity against legacy behavior.
6. Define concrete build, test, and verification shell commands.
7. Create `plan.md`.
8. Append ONLY human developer prompts and custom instructions to `.devweave/modernization/stories/<ID>/audit.md`.

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
- Sets `nextSuggestedPhase` = `BRANCH` (only applicable after explicit approval)

---

## Human Checkpoint: HARD GATE #2 (Blocking)
- **Mandatory checkpoint**: Code modifications cannot begin without explicit human plan approval.
- **Gate Decision Handling**:
  - `APPROVE`:
    1. Update state: `phases.PLAN` = `APPROVED`.
    2. Log user approval and comments to `audit.md`.
    3. **STOP IMMEDIATELY**. Do NOT create branches or execute code modifications automatically. Prompt user to execute `devweave-modernization-branch <ID>`.
  - `SKIP`:
    1. Require mandatory human explanation comment (e.g., "Plan review bypassed by Lead Architect").
    2. Update state: `phases.PLAN` = `SKIPPED`, `skipReason` = `<comment>`.
    3. Log user skip decision with comment to `audit.md`.
    4. **STOP IMMEDIATELY**. Prompt user to execute `devweave-modernization-branch <ID>`.
  - `REQUEST_CHANGES`:
    1. Update state: `phases.PLAN` = `CHANGES_REQUESTED`.
    2. Preserve plan versions (`plan.v1.md`, `plan.v2.md`), log feedback in `audit.md`.
    3. **STOP IMMEDIATELY**.
  - `STOP`: Halts execution.

---

## Next Suggested Command
```text
devweave-modernization-branch <ID>  (Requires explicit APPROVE at Hard Gate #2)
```

---

## STOP Rule
- Upon writing `plan.md`, updating `audit.md`, and presenting the plan, **STOP IMMEDIATELY**.
- Upon receiving `APPROVE` at Hard Gate #2, record approval in state/audit and **STOP IMMEDIATELY**. Never auto-progress to BRANCH or IMPLEMENT.
