---
name: pr-review
description: "[Phase 6: Review] Executes dual-model consensus code review (Principal Architect + Senior DBA + Security + Downstream Impact + Cascading Resilience) with mandatory audit.md logging and Human-in-the-Loop checkpoint before PR creation."
---

# DevWeave PR Review Skill (`devweave-pr-review`)

## Execution Invariants
1. **Dual-Model Collective Review**: Code changes and SQL migrations must be evaluated concurrently by two distinct model perspectives:
   - **Model A (Principal Software Architect Mindset)**: System design, DDD/Clean boundaries, scalability, public API contracts, and downstream impact.
   - **Model B (Senior Database Administrator & Security Specialist)**: Table locks (`ONLINE=ON`/`CONCURRENTLY`), query execution plans, indexes, rollback safety, N+1 queries, OWASP vulnerabilities, side effects, and cascading resilience.
2. **Phase Isolation**: This skill executes **only the review phase**, compiles `.devweave/work-items/<ID>/review.md`, and halts. It does NOT automatically open a PR.
3. **Mandatory Human Checkpoint**: Execution must present the collective verdict to the developer and wait for human authorization before any PR step.
4. **Audit Invariance**: Append review findings, consensus verdicts, and human gate authorization to `.devweave/work-items/<ID>/audit.md`.

## Step-by-Step Instructions
1. **Load Implementation Context**: Read git diff, modified source files, SQL migrations, `plan.md`, and `.devweave/work-items/<ID>/test-results.json`.
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
4. **Handle Review Verdict**:
   - If **P0/P1 Blocking Findings** exist: Recommend isolated remediation (`devweave-implement <ID>` or fix loop) before proceeding.
   - If **Passed / Advisory Only**: Mark review as ready for human sign-off.
5. **Update State & Audit**:
   - Record `REVIEWED` status in `.devweave/work-items/<ID>/state.md`.
   - Append collective review verdict, specialist summaries, and human gate decision to `.devweave/work-items/<ID>/audit.md`.
6. **Mandatory Human Checkpoint**: Output:
   ```text
   REVIEW COMPLETE
   Work Item: <ID>
   Collective Verdict: CONSENSUS_APPROVED
   Architect Review: APPROVED | DBA Review: APPROVED | Security: PASS
   Downstream Impact: LOW | Side Effects: NONE | Cascading Risks: MITIGATED
   Artifact: .devweave/work-items/<ID>/review.md
   Audit Log: .devweave/work-items/<ID>/audit.md

   Human decision: [Approve Review & Proceed to PR] [Request Changes / Fix] [Stop]
   Suggested next phase: PR (Run: devweave-pr <ID>)
   ```
7. **Terminate Execution**: Stop and wait for user instruction.
