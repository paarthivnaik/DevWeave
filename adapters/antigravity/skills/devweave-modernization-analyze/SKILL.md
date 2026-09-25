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
3. Analyze legacy business logic, state machines, validation rules, and corner-case handling.
4. Formulate target architectural design adhering to declared patterns (e.g., CQRS Command/Query split, Mediator, Repository pattern).
5. Generate formal migration relationships (`MIGRATED_TO`, `REPLACED_BY`, `TRANSFORMED_TO`, `SPLIT_INTO`, `MERGED_INTO`, `PRESERVED_AS`, `RETIRED`, `DEFERRED`).
6. Identify schema migration needs, foreign key changes, and REST API contract equivalents.
7. Create `analysis.md` and `mappings.json`.
8. Append activity entry and Hard Gate #1 presentation/verdict to `.devweave/modernization/stories/<ID>/audit.md`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── analysis.md                 <-- Behavioral & architectural analysis
├── mappings.json               <-- Legacy to modern entity mappings
└── audit.md                    <-- Updated with analysis run & gate decision
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
  - `APPROVE` &rarr; unlocks `PLAN` (logged in `audit.md`).
  - `REQUEST_CHANGES` &rarr; updates `phases.ANALYZE` = `CHANGES_REQUESTED`, preserves `analysis.v1.md`, logs feedback in `audit.md`, and requests revision.
  - `PROVIDE_INFORMATION` &rarr; incorporates additional architectural context.
  - `REJECT` / `STOP` &rarr; terminates modernization pipeline.

---

## Next Suggested Command
```text
devweave-modernization-plan <ID>  (Requires APPROVE)
```

---

## STOP Rule
- Upon completing analysis, updating `audit.md`, and presenting findings, **STOP IMMEDIATELY**.
