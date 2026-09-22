---
name: devweave-pr
description: "[Phase 6: PR] Executes deterministic verification, dual-model consensus code review, fix/retest loop, and assembles final PR package under a hard human approval gate."
---

# DevWeave PR Skill (`devweave-pr`)

## Execution Invariants
1. **Hard Governance Gate**: External pull request creation strictly requires explicit human sign-off.
2. **Deterministic Verification**: Zero tolerance for failing tests or unverified acceptance criteria.
3. **Dual-Model Collective Review**: Code changes must be reviewed concurrently by two distinct model perspectives (Model A: Logic/Architecture, Model B: Security/Performance) and synthesized collectively into `.devweave/work-items/<ID>/review.md`.

## Step-by-Step Instructions
1. **Run Verification**: Confirm clean build, passing tests, and 100% acceptance criteria fulfillment (`verification.md`).
2. **Execute Dual-Model Review**:
   - **Model A (Primary Reasoning / Logic Specialist)**: Evaluates semantic correctness, edge cases, business contract fulfillment, and domain pattern compliance.
   - **Model B (Adversarial Security & Reliability Specialist)**: Audits OWASP Top 10 vulnerabilities, secret scanning, auth/authz boundaries, concurrency, and performance bottlenecks.
3. **Synthesize Collective Review Output**:
   - Aggregate findings into `.devweave/work-items/<ID>/review.md` highlighting consensus findings (agreed by both models), logic findings, security audits, and collective verdict (`APPROVED` vs `CHANGES_REQUESTED`).
4. **Fix / Retest Loop**: If blocking review findings (P0/P1) exist from either model, execute isolated remediation before PR assembly.
5. **Durable Knowledge Promotion**: Prompt to promote any reusable domain conventions discovered during implementation to `.devweave/domains/`.
6. **Assemble PR Description**: Write comprehensive PR summary to `.devweave/work-items/<ID>/pr-description.md`.
7. **Human Approval Gate**:
   ```text
   PR READY
   Work Item: <ID>
   Verification: PASS | Tests: PASS | Dual-Model Review: CONSENSUS_APPROVED
   Artifact: .devweave/work-items/<ID>/pr-description.md
   
   Authorize PR creation? [Create PR] [Request Changes] [Stop]
   ```
8. **Update State**: Record `PR_COMPLETED` in `.devweave/work-items/<ID>/state.md`.
9. **Terminate Execution**: Stop and wait for user instruction.
