---
name: devweave-modernization-verify
description: "[Modernization Phase 6: Verify] Execute dual-layer functional and architectural verification, confirm behavioral preservation, validate migration mapping completeness, update audit.md, and enforce Hard Gate #3."
---

# Antigravity Modernization Verification Skill (`devweave-modernization-verify`)

## Purpose
Execute comprehensive, multi-perspective verification comparing modernized implementation against legacy behavioral baselines, validating architecture constraints, confirming migration mapping completeness, executing integration and security checks, producing `verification.md`, logging verification scorecard into `audit.md`, and halting at **Mandatory Human-in-the-Loop Hard Gate #3**.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`).

---

## Preconditions
- `phases.IMPLEMENT` is `COMPLETED`.

---

## Allowed Actions
1. **Mandatory Description Prompting**: Ask developer for any specific verification instructions or test targets.
2. **Clean Build & Automated Test Execution**: Run production build and test suites (unit, integration, API, UI, database regression).
3. **Behavioral Preservation Verification**:
   - Input validation rules (boundary values, constraints)
   - Business calculation logic & domain workflows
   - Authorization/security boundaries
   - Persistence data integrity & schema transformations
   - Error handling and problem-details responses
4. **Architectural Conformance**: Confirm adherence to target architecture intent (e.g., CQRS separation, interface contracts, no circular dependencies).
5. **Database Migration & Reversibility**: Verify migration scripts, indexes, and rollback capabilities.
6. **Migration Mapping Completeness Check**:
   - Verify every legacy source component in `mappings.json` is assigned an intentional status (`MIGRATED`, `REPLACED`, `TRANSFORMED`, `PRESERVED`, `RETIRED`, `DEFERRED`, `UNKNOWN`).
   - Validate that no critical legacy component has silently disappeared from the migration map.
7. **Assemble Deliverable**: Create `verification.md` containing complete verification scorecard, test matrix, and mapping completeness status.
8. **User-Only Story Audit Trail (`audit.md`)**: Append exclusively human developer prompts and custom instructions to `.devweave/modernization/stories/<ID>/audit.md`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── verification.md             <-- Complete dual-layer verification scorecard & mapping completeness
└── audit.md                    <-- Updated with user activity log
```

---

## State Updates
- Sets `currentPhase` = `VERIFY`
- Sets `phases.VERIFY` = `WAITING_APPROVAL`
- Sets `status` = `WAITING_FOR_HUMAN`
- Sets `nextSuggestedPhase` = `PR` (only applicable after explicit approval)

---

## Human Checkpoint: HARD GATE #3 (Blocking)
- **Mandatory checkpoint**: PR preparation cannot occur without explicit human verification approval.
- Present verification scorecard to developer:
  ```text
  Verification Summary for <ID>:
  - Functional Parity: PASS
  - Architecture Conformance: PASS
  - Automated Tests: PASS (100%)
  - Migration Mapping Completeness: VERIFIED (All components accounted for)
  - Security & Secrets: PASS
  - Database Migration: PASS
  - Behavior Preservation: CONFIRMED
  ```
- **Gate Decision Handling**:
  - `APPROVE`:
    1. Update state: `phases.VERIFY` = `APPROVED`.
    2. Log user approval and comments to `audit.md`.
    3. **STOP IMMEDIATELY**. Do NOT generate PR artifacts or mark story completed. Prompt user to execute `devweave-modernization-pr <ID>`.
  - `SKIP`:
    1. Require mandatory human explanation comment (e.g., "Verification bypassed for emergency patch").
    2. Update state: `phases.VERIFY` = `SKIPPED`, `skipReason` = `<comment>`.
    3. Log user skip decision with comment to `audit.md`.
    4. **STOP IMMEDIATELY**. Prompt user to execute `devweave-modernization-pr <ID>`.
  - `REQUEST_CHANGES`:
    1. Update state: `phases.VERIFY` = `CHANGES_REQUESTED`.
    2. Log user change request comments to `audit.md`.
    3. **STOP IMMEDIATELY**. Prompt user to re-execute implementation.
  - `STOP`: Terminate pipeline.

---

## Next Suggested Command
```text
devweave-modernization-pr <ID>  (Requires explicit APPROVE at Hard Gate #3)
```

---

## STOP Rule
- Upon writing `verification.md`, updating `audit.md`, and presenting the scorecard, **STOP IMMEDIATELY**.
- Upon receiving `APPROVE` at Hard Gate #3, record approval in state/audit and **STOP IMMEDIATELY**. Never auto-progress to PR.
