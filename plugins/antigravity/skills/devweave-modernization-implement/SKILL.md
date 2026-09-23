---
name: devweave-modernization-implement
description: "[Modernization Phase 5: Implement] Execute surgical, plan-bound modernization code changes, execute automated tests, adhere to technology practices, and guard against scope drift."
---

# Antigravity Modernization Implementation Skill (`devweave-modernization-implement`)

## Purpose
Execute surgical, plan-bound code creation and modifications strictly as specified in `plan.md`. Adhere to technology practice intelligence, execute local build and automated test suites, and prevent unauthorized scope drift.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- `phases.BRANCH` is `COMPLETED` and target branch is active.

---

## Allowed Actions
1. Load approved `plan.md` and surgical context.
2. Retrieve targeted engineering practices matching the implementation task (e.g., Angular component guidelines, CQRS command handler templates, MySQL query parameterization).
3. Create target directory layouts and files strictly within plan boundaries.
4. Execute build command (e.g. `dotnet build`, `ng build`, `npm run build`).
5. Execute unit and integration tests (e.g. `dotnet test`, `ng test`, `pytest`).
6. If build/tests fail, enter localized remediation loop without modifying files outside the approved plan.
7. Record implementation evidence.

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
- Upon completing implementation and tests, **STOP IMMEDIATELY**. Do not auto-run verify or PR.
