---
name: devweave-modernization-implement
description: "[Modernization Phase 5: Implement] Execute surgical, plan-bound modernization code changes, execute automated tests, adhere to technology practices, log to audit.md, and guard against scope drift."
---

# Antigravity Modernization Implementation Skill (`devweave-modernization-implement`)

## Purpose
Execute surgical, plan-bound code creation and modifications strictly as specified in `plan.md`. Adhere to technology practice intelligence, execute local build and automated test suites, record modified files and test outcomes into `audit.md`, and prevent unauthorized scope drift.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`).

---

## Preconditions
- `phases.BRANCH` is `COMPLETED` and target branch is active.

---

## Allowed Actions
1. **Mandatory Disk-First Artifact Ingestion**: Before implementing, the agent **MUST EXPLICITLY READ DISK ARTIFACTS (`view_file`)** from `.devweave/modernization/stories/<ID>/` (`plan.md`, `analysis.md`, `mappings.json`, `context.md`, `state.json`) and `.devweave/modernization/` (`technology-profile.json`). Never rely on in-memory context.
2. **Mandatory Description Prompting**: Ask developer for any specific implementation guidance or custom flags.
3. Retrieve targeted engineering practices matching the implementation task (e.g., Angular component guidelines, CQRS command handler templates, MySQL query parameterization).
4. Create target directory layouts and files strictly within plan boundaries.
5. Execute build command (e.g. `dotnet build`, `ng build`, `npm run build`).
6. Execute unit and integration tests (e.g. `dotnet test`, `ng test`, `pytest`).
7. If build/tests fail, enter localized remediation loop without modifying files outside the approved plan.
8. Append implementation activity, list of modified/created files, test execution metrics, and results to `.devweave/modernization/stories/<ID>/audit.md`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── evidence.md                 <-- Implementation & test execution evidence
└── audit.md                    <-- Updated with code modification & test log
```

---

## Implementation Sequence
```text
INSPECT
   ↓
IDENTIFY EXACT FILES
   ↓
READ REQUIRED CONTEXT & PRACTICES
   ↓
MODIFY ONLY REQUIRED FILES
   ↓
BUILD
   ↓
RUN TESTS
   ↓
UPDATE AUDIT.MD
   ↓
GENERATE CHANGE SUMMARY
   ↓
PERSIST STATE
   ↓
STOP
```

---

## State Updates
- Sets `currentPhase` = `IMPLEMENT`
- Sets `phases.IMPLEMENT` = `COMPLETED`
- Sets `phases.VERIFY` = `PENDING`
- Sets `nextSuggestedPhase` = `VERIFY`

---

## Human Checkpoint
- Present implementation results, modified files list, and test pass logs.

---

## Next Suggested Command
```text
devweave-modernization-verify <ID>
```

---

## STOP Rule
- Upon completing implementation, tests, and logging to `audit.md`, **STOP IMMEDIATELY**. Do not auto-run verify or PR.
