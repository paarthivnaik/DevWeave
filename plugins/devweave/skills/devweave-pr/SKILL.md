---
name: devweave-pr
description: "[Phase 6: PR] Executes deterministic verification, dual-model consensus code review, fix/retest loop, and assembles final PR package under a hard human approval gate."
---

# DevWeave PR Skill (`devweave-pr`)

## Execution Invariants
1. **Hard Governance Gate**: External pull request creation strictly requires explicit human sign-off.
2. **Deterministic Verification**: Zero tolerance for failing tests or unverified acceptance criteria.
3. **Dual-Model Collective Review**: Code changes must be reviewed concurrently by two distinct model perspectives (Model A: Logic/Impact, Model B: Security/Resilience) with mandatory analysis of **downstream impact, side effects, and cascading failures**, synthesized into `.devweave/work-items/<ID>/review.md`.

## Step-by-Step Instructions
1. **Run Verification**: Confirm clean build, passing tests, and 100% acceptance criteria fulfillment (`verification.md`).
2. **Execute Dual-Model Review**:
   - **Model A (Primary Reasoning & Architecture Specialist)**:
     - Evaluates semantic correctness and business contract fulfillment.
     - Performs **Downstream Impact Analysis** (API breaking changes, caller hierarchies, database schema consumers, shared libraries).
     - Identifies edge-case hazards and domain rule compliance.
   - **Model B (Adversarial Security & Reliability Specialist)**:
     - Audits OWASP Top 10 vulnerabilities, auth/authz boundaries, and zero secret storage.
     - Performs **Side Effects & State Mutation Audit** (global/static state mutations, cache invalidation race conditions, async message order).
     - Models **Cascading Failures & Resilience** (timeout propagation, retry storms, unhandled exceptions, circuit breaking, connection pool leaks).
3. **Synthesize Collective Review Output**:
   - Compile comprehensive `.devweave/work-items/<ID>/review.md` containing:
     - Executive summary and collective verdict (`CONSENSUS_APPROVED` vs `CHANGES_REQUESTED`).
     - Downstream Impact & Sibling Coupling Matrix.
     - Side Effects & State Mutation Audit.
     - Cascading Failure & Resilience Assessment.
     - Consensus findings (flagged by both models) and specialist findings.
4. **Fix / Retest Loop**: If blocking review findings (P0/P1) exist from either model, execute isolated remediation before PR assembly.
5. **Durable Knowledge Promotion**: Prompt to promote any reusable domain conventions discovered during implementation to `.devweave/domains/`.
6. **Assemble PR Description**: Write comprehensive PR summary to `.devweave/work-items/<ID>/pr-description.md`.
7. **Human Approval Gate**:
   ```text
   PR READY
   Work Item: <ID>
   Verification: PASS | Tests: PASS | Dual-Model Review: CONSENSUS_APPROVED
   Downstream Impact: LOW | Side Effects: NONE | Cascading Risks: MITIGATED
   Artifact: .devweave/work-items/<ID>/pr-description.md
   
   Authorize PR creation? [Create PR] [Request Changes] [Stop]
   ```
8. **Update State**: Record `PR_COMPLETED` in `.devweave/work-items/<ID>/state.md`.
9. **Terminate Execution**: Stop and wait for user instruction.
