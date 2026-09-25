---
name: devweave-plan
description: "[Phase 3: Plan] Decomposes approved analysis into concrete, file-anchored implementation tasks with explicit requirement tracing, test specifications, and audit.md logging."
---

# DevWeave Plan Skill (`devweave-plan`)

## Purpose
Decompose the approved `analysis.md` into a concrete, file-anchored implementation contract with full traceability to requirements and analysis findings, test execution commands, database migration instructions, and rollback safeguards.

---

## Inputs & Parameters
- `<ID>`: Work item ID (e.g. `TASK-001`, `98`, `FEAT-42`).

---

## Preconditions & Guards
1. **Base Init Prerequisite Guard**:
   Ensure `.devweave/` is initialized. If not:
   ```text
   DevWeave has not been initialized for this repository.

   Run:

   devweave-init

   before continuing.
   ```
   **STOP IMMEDIATELY**.
2. **Analysis Dependency & Staleness Guard**:
   Verify `ANALYZE` is `COMPLETED` and approved. If `analysis.md` or `context.md` was updated after plan generation, mark previous plan `STALE` and regenerate.

---

## Allowed Actions

### 1. Mandatory Disk-First Artifact Ingestion
Before planning, the agent **MUST EXPLICITLY READ DISK ARTIFACTS (`view_file`)** from `.devweave/work-items/<ID>/` (`analysis.md`, `context.md`, `work-item.json`, `state.json`) and `.devweave/repository/` (`profile.md`, `layers.md`). Never rely on in-memory conversation history.

### 2. Mandatory Description Prompting (Optional Input)
Ask the developer if they have any additional planning preferences or rollout constraints (per Rule #7).

### 3. Pre-Processing Transparency
State clearly which source files, database migration paths, and test suites will be planned for modification.

### 3. Task Decomposition & Traceability
Break down solution into discrete, ordered tasks with explicit bidirectional traceability:
- Task ID: `PLAN-001`
- Traced Analysis Finding: `ANALYSIS-007`
- Traced Requirement: `REQUIREMENT-003`
- Target Files & Line Anchors: Explicit file paths, symbols, functions to create/modify/delete.
- Code & API Contract Changes: Signatures, validation rules, error codes.
- Database & Data Migrations: Schema updates, indexes, reversible migration scripts.
- UI & Flow Modifications: Components, routes, reactive state bindings.
- Test Specifications: Unit, integration, and E2E test commands and assertions.
- Security & Permission Controls: Input sanitization, authorization gates.
- Rollback & Safeguard Strategy: Step-by-step procedure to revert changes cleanly.

### 4. Assemble Artifact
Write `.devweave/work-items/<ID>/plan.md` and update `state.json`.

### 5. User-Only Story Audit Trail (`audit.md`)
Log developer prompt, custom input, and decisions to `.devweave/work-items/<ID>/audit.md` with `Author: <User Name> <email@example.com>`.

---

## Artifacts Generated
```text
.devweave/work-items/<ID>/
├── plan.md                     <-- Traceable implementation blueprint
├── state.json                  <-- Phase tracker (currentPhase: PLAN, status: WAITING_FOR_HUMAN)
└── audit.md                    <-- Append-only human activity audit log
```

---

## Human Checkpoint & Stop Rule
- Present summary and request human approval:
  ```text
  PLAN COMPLETE
  Work Item: <ID>
  Artifact: .devweave/work-items/<ID>/plan.md

  Human decision: [Approve Plan] [Request Changes] [Stop]
  Suggested next phase: BRANCH (Run: devweave-branch <ID>)
  ```
- **STOP IMMEDIATELY**. Never automatically execute `devweave-branch`.
