---
name: devweave-pr
description: "[Phase 6: PR] Executes deterministic verification, dual-model consensus code review (Principal Architect + Senior DBA perspectives), fix/retest loop, and assembles final PR package under a hard human approval gate."
---

# DevWeave PR Skill (`devweave-pr`)

## Execution Invariants
1. **Hard Governance Gate**: External pull request creation strictly requires explicit human sign-off.
2. **Deterministic Verification**: Zero tolerance for failing tests or unverified acceptance criteria.
3. **Dual-Model Collective Review**: Code changes must be reviewed concurrently by two distinct model perspectives:
   - **Model A (Principal Software Architect Mindset)**: System design, Clean/DDD boundaries, scalability, public API contracts, and downstream impact.
   - **Model B (Senior Database Administrator Mindset & Security Specialist)**: Table locks (`ONLINE=ON`/`CONCURRENTLY`), query execution plans, indexes, rollback safety, N+1 queries, OWASP vulnerabilities, and cascading resilience.

## Step-by-Step Instructions
1. **Run Verification**: Confirm clean build, passing tests, and 100% acceptance criteria fulfillment (`verification.md`).
2. **Execute Dual-Model Review**:
   - **Model A (Principal Software Architect Mindset)**:
     - Evaluates system boundaries, decoupling, modularity, and SOLID/DDD compliance.
     - Performs **Downstream Impact Analysis** (API breaking changes, caller hierarchies, shared library coupling).
     - Audits observability (structured logging, correlation IDs, OpenTelemetry).
   - **Model B (Senior Database Administrator & Security Specialist)**:
     - Audits **SQL scripts, DDL migrations, and ORM access** through a Senior DBA lens (table lock risks, missing indexes, execution plan cost, reversible down migrations, and batch chunking).
     - Performs **Side Effects & State Mutation Audit** (global state, cache invalidation races, async message order).
     - Models **Cascading Failures & Resilience** (timeout propagation, retry storms, unhandled exceptions, circuit breaking).
     - Audits OWASP Top 10 security and zero raw credential storage.
3. **Synthesize Collective Review Output**:
   - Compile comprehensive `.devweave/work-items/<ID>/review.md` containing:
     - Executive summary and collective verdict (`CONSENSUS_APPROVED` vs `CHANGES_REQUESTED`).
     - Principal Architect System & Design Critique.
     - Senior DBA SQL & Migration Audit.
     - Downstream Impact, Side Effects & Cascading Resilience Matrix.
     - Consensus findings (flagged by both models) and specialist findings.
4. **Fix / Retest Loop**: If blocking review findings (P0/P1) exist from either model, execute isolated remediation before PR assembly.
5. **Durable Knowledge Promotion**: Prompt to promote any reusable domain conventions discovered during implementation to `.devweave/domains/`.
6. **Assemble PR Description**: Write comprehensive PR summary to `.devweave/work-items/<ID>/pr-description.md`.
7. **Human Approval Gate**:
   ```text
   PR READY
   Work Item: <ID>
   Verification: PASS | Tests: PASS | Dual-Model Review: CONSENSUS_APPROVED
   Architect Review: APPROVED | DBA Review: APPROVED | Security: PASS
   Artifact: .devweave/work-items/<ID>/pr-description.md
   
   Authorize PR creation? [Create PR] [Request Changes] [Stop]
   ```
8. **Update State**: Record `PR_COMPLETED` in `.devweave/work-items/<ID>/state.md`.
9. **Terminate Execution**: Stop and wait for user instruction.
