---
name: devweave-modernization-verify
description: "[Modernization Phase 6: Verify] Execute dual-layer functional and architectural verification, confirm behavioral preservation against legacy specs, validate security and database migrations, update audit.md, and enforce Hard Gate #3."
---

# Cognition Devin Modernization Verification Command (`devin run /devweave-modernization-verify`)

## Purpose
Execute comprehensive, multi-perspective verification comparing modernized implementation against legacy behavioral baselines, validating architecture constraints, executing integration and security checks, producing `verification.md`, logging verification scorecard and gate decisions into `audit.md`, and halting at **Mandatory Human-in-the-Loop Hard Gate #3**.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`).

---

## Preconditions
- `phases.IMPLEMENT` is `COMPLETED`.

---

## Allowed Actions
1. **Mandatory Description Prompting**: Ask developer for any specific verification instructions or test targets.
2. Run clean production build and full automated test suite.
3. Verify behavioral preservation across:
   - Input validation rules
   - Business calculation logic
   - Authorization/security boundaries
   - Persistence data integrity
   - Error handling and problem-details responses
4. Verify architectural conformance (CQRS separation, no circular dependencies).
5. Verify database schema migrations and indexing.
6. Create `verification.md`.
7. Append verification metrics, scorecard, and Hard Gate #3 presentation/decision to `.devweave/modernization/stories/<ID>/audit.md`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── verification.md             <-- Dual-layer verification scorecard
└── audit.md                    <-- Updated with verification log & gate decision
```

---

## State Updates
- Sets `currentPhase` = `VERIFY`
- Sets `phases.VERIFY` = `WAITING_APPROVAL`
- Sets `status` = `WAITING_FOR_HUMAN`
- Sets `nextSuggestedPhase` = `PR` (only applicable after approval)

---

## Human Checkpoint: HARD GATE #3
- **Mandatory checkpoint**: PR preparation cannot occur without human verification approval.
- Present verification scorecard:
  ```text
  Verification Summary for <ID>:
  - Functional Parity: PASS
  - Architecture Conformance: PASS
  - Automated Tests: PASS (100%)
  - Security & Secrets: PASS
  - Database Migration: PASS
  - Behavior Preservation: CONFIRMED
  ```
- Supported decisions:
  - `APPROVE` &rarr; unlocks `PR` (logged in `audit.md`).
  - `REQUEST_CHANGES` &rarr; logs feedback in `audit.md` and requests code fixes.
  - `STOP` &rarr; terminates pipeline.

---

## Next Suggested Command
```text
devweave-modernization-pr <ID>  (Requires APPROVE)
```

---

## STOP Rule
- Upon writing `verification.md`, updating `audit.md`, and presenting the scorecard, **STOP IMMEDIATELY**.
