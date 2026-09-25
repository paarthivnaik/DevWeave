---
name: devweave-modernization-analyze
description: "[Modernization Phase 2: Analyze] Deeply analyze legacy behaviors, business rules, API schemas, and data structures against target architecture; produce analysis.md, migration mappings.json, update audit.md, and enforce Hard Gate #1."
---

# Antigravity Modernization Analysis Skill (`devweave-modernization-analyze`)

## Purpose
Perform deep technical analysis of legacy functional behaviors, validation rules, transactional boundaries, API contracts, and database queries. Map every legacy component to its target architectural equivalent, synthesize `mappings.json`, record activity in `audit.md`, and halt at **Mandatory Human-in-the-Loop Hard Gate #1**.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`).

---

## Preconditions
- `phases.CONTEXT` is `COMPLETED`.

---

## Allowed Actions
1. **Mandatory Disk-First Artifact Ingestion**: Before analyzing, the agent **MUST EXPLICITLY READ DISK ARTIFACTS (`view_file`)** from `.devweave/modernization/stories/<ID>/` (`context.md`, `work-item.json`, `evidence.json`, `migration-slice.json`, `state.json`) and `.devweave/modernization/` (`architecture-intent.json`, `technology-profile.json`). Never rely on ephemeral conversation memory.
2. **Mandatory Description Prompting**: Ask developer for any specific focus areas or additional instructions.
3. Analyze legacy business logic, state machines, validation rules, and corner-case handling loaded from disk.
4. Formulate target architectural design adhering to declared patterns (e.g., CQRS Command/Query split, Mediator, Repository pattern).
5. Generate formal migration relationships (`MIGRATED_TO`, `REPLACED_BY`, `TRANSFORMED_TO`, `SPLIT_INTO`, `MERGED_INTO`, `PRESERVED_AS`, `RETIRED`, `DEFERRED`).
6. Identify schema migration needs, foreign key changes, and REST API contract equivalents.
7. Create `analysis.md` and `mappings.json`.
8. Append ONLY human developer prompts and custom instructions to `.devweave/modernization/stories/<ID>/audit.md`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── analysis.md                 <-- Behavioral & architectural analysis
├── mappings.json               <-- Legacy to modern entity mappings
└── audit.md                    <-- Updated with user activity log
```

---

## State Updates
- Sets `currentPhase` = `ANALYZE`
- Sets `phases.ANALYZE` = `WAITING_APPROVAL`
- Sets `status` = `WAITING_FOR_HUMAN`
- Sets `nextSuggestedPhase` = `PLAN` (only applicable after explicit approval)

---

## Human Checkpoint: HARD GATE #1 (Blocking)
- **Mandatory checkpoint**: Modernization analysis and mapping cannot proceed to planning without explicit human authorization.
- **Gate Decision Handling**:
  - `APPROVE`:
    1. Update state: `phases.ANALYZE` = `APPROVED`.
    2. Log user approval and comments to `audit.md`.
    3. **STOP IMMEDIATELY**. Do NOT execute planning automatically. Prompt user to execute `devweave-modernization-plan <ID>`.
  - `SKIP`:
    1. Require mandatory human explanation comment (e.g., "Analysis gate bypassed for direct porting").
    2. Update state: `phases.ANALYZE` = `SKIPPED`, `skipReason` = `<comment>`.
    3. Log user skip decision with comment to `audit.md`.
    4. **STOP IMMEDIATELY**. Prompt user to execute `devweave-modernization-plan <ID>`.
  - `REQUEST_CHANGES`:
    1. Update state: `phases.ANALYZE` = `CHANGES_REQUESTED`.
    2. Preserve `analysis.v1.md`, log feedback in `audit.md`.
    3. **STOP IMMEDIATELY**.
  - `PROVIDE_INFORMATION`: Incorporate additional architectural context.
  - `REJECT` / `STOP`: Terminate modernization pipeline.

---

## Next Suggested Command
```text
devweave-modernization-plan <ID>  (Requires explicit APPROVE at Hard Gate #1)
```

---

## STOP Rule
- Upon completing analysis, updating `audit.md`, and presenting findings, **STOP IMMEDIATELY**.
- Upon receiving `APPROVE` at Hard Gate #1, record approval in state/audit and **STOP IMMEDIATELY**. Never auto-progress to PLAN.
