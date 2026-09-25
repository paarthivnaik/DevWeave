---
name: devweave-implement
description: "[Phase 5: Implement] Executes surgical, plan-bound code modifications adhering to repository patterns and coding standards, handles pattern vs best practice choices, captures test evidence, and updates audit.md."
---

# DevWeave Implement Skill (`devweave-implement`)

## Purpose
Execute surgical, plan-bound source code and test modifications strictly adhering to the approved `plan.md`, resolve any conflicts between existing repository conventions and technology best practices via developer choice, prevent scope drift, record graph deltas, and capture deterministic test evidence.

---

## Inputs & Parameters
- `<ID>`: Work item ID (e.g. `TASK-001`, `98`, `FEAT-42`).

---

## Preconditions & Guards
1. **Base Init Prerequisite Guard**:
   Verify repository is initialized. If not:
   ```text
   DevWeave has not been initialized for this repository.

   Run:

   devweave-init

   before continuing.
   ```
   **STOP IMMEDIATELY**.
2. **Branch Prerequisite Guard**:
   Verify an isolated feature/work-item branch is active (`BRANCH` phase completed).
3. **Plan Prerequisite Guard**:
   Verify `plan.md` is approved and not `STALE`.

---

## Allowed Actions

### 1. Mandatory Description Prompting (Optional Input)
Ask the developer if they have any additional implementation instructions or specific constraints before beginning (per Rule #7).

### 2. Pre-Processing Transparency
Clearly announce which files, classes, and test suites will be modified.

### 3. Repository Pattern vs Best Practice Conflict Check
Inspect existing repository conventions. If an existing pattern materially conflicts with target technology best practice, prompt the developer:
```text
Existing repository pattern:
<pattern description>

Recommended technology practice:
<practice description>

Choose:
1. Existing repository pattern
2. Recommended practice
3. Other
```
Persist developer choice in `audit.md` and adhere strictly to the decision.

### 4. Plan-Bound Implementation
- Apply localized code edits strictly restricted to files declared in `plan.md`.
- **Plan Deviation Guard**: If an unexpected requirement outside the plan is discovered:
  ```text
  Plan deviation detected: <details>

  Choose:
  1. Update plan (Run devweave-plan <ID>)
  2. Provide instruction
  3. Stop
  ```
  Do NOT silently expand scope.

### 5. Atomic Test Updates & Test Intelligence
- Update or add unit, integration, and API tests atomically with production code.
- Prevent test weakening (never remove assertions or disable strict checks).
- Run automated test suites and record outcomes in `.devweave/work-items/<ID>/test-results.json`.

### 6. Incremental Knowledge Graph Delta
Extract new symbols and dependencies, writing `.devweave/work-items/<ID>/graph-delta.json`.

### 7. User-Only Story Audit Trail (`audit.md`)
Append exclusively developer prompts, custom instructions, and decisions to `.devweave/work-items/<ID>/audit.md` with `Author: <User Name> <email@example.com>`.

---

## Artifacts Generated
```text
.devweave/work-items/<ID>/
├── test-results.json           <-- Test run execution evidence
├── graph-delta.json            <-- Incremental knowledge graph patch
├── state.json                  <-- Phase tracker (currentPhase: IMPLEMENT, status: WAITING_FOR_HUMAN)
└── audit.md                    <-- Append-only human activity audit log
```

---

## Human Checkpoint & Stop Rule
- Present summary:
  ```text
  IMPLEMENTATION COMPLETE
  Work Item: <ID>
  Files Modified: <list>
  Graph Delta: .devweave/work-items/<ID>/graph-delta.json
  Tests: <X passed, 0 failed>

  Human decision: [Approve] [Request Changes] [Stop]
  Suggested next phase: PR Review (Run: devweave-pr-review <ID>)
  ```
- **STOP IMMEDIATELY**. Never automatically execute `devweave-pr-review`.
