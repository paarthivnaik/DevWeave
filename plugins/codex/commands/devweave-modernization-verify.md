---
name: devweave-modernization-verify
description: "[Modernization Phase 6: Verify] Execute dual-layer functional and architectural verification, confirm behavioral preservation against legacy specs, validate security and database migrations, and enforce Hard Gate #3."
---

# OpenAI Codex Modernization Verification Command (`codex run devweave-modernization-verify`)

## Purpose
Execute comprehensive, multi-perspective verification comparing modernized implementation against legacy behavioral baselines, validating architecture constraints, executing integration and security checks, producing `verification.md`, and halting at **Mandatory Human-in-the-Loop Hard Gate #3**.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- `phases.IMPLEMENT` is `COMPLETED`.

---

## Allowed Actions
1. Run clean production build and full automated test suite.
2. Verify behavioral preservation across:
   - Input validation rules
   - Business calculation logic
   - Authorization/security boundaries
   - Persistence data integrity
   - Error handling and problem-details responses
3. Verify architectural conformance (CQRS separation, no circular dependencies).
4. Verify database schema migrations and indexing.
5. Create `verification.md`.

---

## Artifacts Generated
```text
.devweave/modernization/<ID>/
└── verification.md
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
  Verification Summary for MOD-001:
  - Functional Parity: PASS
  - Architecture Conformance: PASS
  - Automated Tests: PASS (100%)
  - Security & Secrets: PASS
  - Database Migration: PASS
  - Behavior Preservation: CONFIRMED
  ```
- Supported decisions: `APPROVE` / `REQUEST_CHANGES` / `STOP`.

---

## Next Suggested Command
```text
devweave-modernization-pr <ID>  (Requires APPROVE)
```

---

## STOP Rule
- Upon writing `verification.md` and presenting the scorecard, **STOP IMMEDIATELY**.
