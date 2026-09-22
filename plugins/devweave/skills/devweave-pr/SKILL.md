---
name: devweave-pr
description: [Phase 6: PR] Executes deterministic verification, multi-perspective code review, fix/retest loop, and assembles final PR package under a hard human approval gate.
---

# DevWeave PR Skill (`devweave-pr`)

## Execution Invariants
1. **Hard Governance Gate**: External pull request creation strictly requires explicit human sign-off.
2. **Deterministic Verification**: Zero tolerance for failing tests or unverified acceptance criteria.

## Step-by-Step Instructions
1. **Run Verification**: Confirm clean build, passing tests, and 100% acceptance criteria fulfillment (`verification.md`).
2. **Multi-Perspective Review**: Conduct independent critique across Correctness, Security, Performance, and Maintainability (`review.md`).
3. **Fix / Retest Loop**: If review findings exist, stage and apply remediation before PR assembly.
4. **Assemble PR Description**: Write comprehensive PR summary to `.devweave/work-items/<ID>/pr-description.md`.
5. **Human Approval Gate**:
   ```text
   PR READY
   Work Item: <ID>
   Verification: PASS | Tests: PASS | Security: PASS
   Artifact: .devweave/work-items/<ID>/pr-description.md
   
   Authorize PR creation? [Create PR] [Request Changes] [Stop]
   ```
6. **Update State**: Record `PR_COMPLETED` in `.devweave/work-items/<ID>/state.md`.
7. **Terminate Execution**: Stop and wait for user instruction.
