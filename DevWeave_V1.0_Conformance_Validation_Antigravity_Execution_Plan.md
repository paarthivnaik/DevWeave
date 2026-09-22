# DevWeave V1.0 — Conformance & Validation Execution Plan for Google Antigravity

## Purpose

V1.0 coding is complete. This plan is for validating the existing DevWeave monorepo, producing evidence, fixing genuine V1.0 defects, and reaching a V1.0 release candidate.

Current repository shape:

```text
DevWeave/
├── adapters/
├── conformance/
├── docs/
├── spec/
├── CHANGELOG.md
├── README.md
└── VERSION
```

The existing conformance audit reports that the repository already contains:
- 18 baseline conformance scenarios
- 13 canonical JSON schemas
- `conformance/fixtures/` currently empty
- `conformance/tests/` currently empty

This plan turns that foundation into an executable V1.0 validation process.

---

# 1. Rules for Google Antigravity

Paste this instruction before starting:

```text
You are executing the DevWeave V1.0 Conformance & Validation Plan.

V1.0 coding is complete. Validate the existing implementation; do not redesign DevWeave.

Architecture rules:
- AI-DLC is the canonical methodology/specification.
- DevWeave must remain generic and host-neutral.
- Google Antigravity is only the current host/development environment.
- Do not introduce mandatory dependencies on TypeScript, Node.js, .NET, Python, Java, Go, Rust, a specific database, cloud provider, AI provider, vector database, or custom runtime.
- Do not weaken security boundaries to make a test pass.
- Never use production databases for conformance testing.
- Never expose credentials in prompts, artifacts, logs, or Git.
- Do not modify the specification just to make a test pass.
- Preserve existing architecture unless a genuine V1.0 defect is demonstrated.

Execution discipline:
1. Execute one task at a time.
2. Inspect before modifying.
3. Explain intended changes before implementing them.
4. Implement only the current task.
5. Run validation.
6. Record evidence.
7. Report PASS, FAIL, BLOCKED, or NOT APPLICABLE.
8. Stop after the current task and wait for approval.
9. Never claim PASS without evidence.
10. Never fabricate token/cost measurements.

For every task report:
- Objective
- Files inspected
- Files changed
- Commands/tools executed
- Expected result
- Actual result
- Evidence
- Status
- Remaining risks
```

---

# 2. Phase 0 — Baseline

## Task 0.1 — Inspect

Ask Antigravity:

```text
Inspect the DevWeave repository and compare the implementation with the V1.0 specification.

Do not modify anything.

Inspect:
- spec/
- adapters/
- conformance/
- docs/
- README.md
- CHANGELOG.md
- VERSION

Report:
1. Existing conformance infrastructure
2. Existing scenarios
3. Existing schemas
4. Existing tests
5. Existing fixtures
6. Existing automation
7. Current version
8. V1.0 gaps

Do not fix anything.
```

## Task 0.2 — Create baseline evidence

Create:

```text
conformance/results/baseline.md
```

Record:
- Git commit
- DevWeave version
- date/environment
- build status
- existing tests
- existing conformance status

Do not record secrets.

---

# 3. Phase 1 — Fixtures

Create minimal deterministic fixtures:

```text
conformance/fixtures/
├── dotnet/
├── java/
├── python/
├── node/
├── legacy/
└── complex-monorepo/
```

Requirements:

### dotnet
Enough files to detect .NET, source, tests, and build.

### java
Enough files to detect Java, Maven/Gradle, source, tests, and build.

### python
Enough files to detect Python, project metadata, source, and tests.

### node
Enough files to detect Node, package metadata, source, and tests.

### legacy
An intentionally imperfect repository with weak/unstructured metadata.

### complex-monorepo

```text
complex-monorepo/
├── services/
│   ├── bookings/
│   ├── payments/
│   └── notifications/
├── frontend/
├── shared/
├── database/
├── tests/
└── README.md
```

Keep fixtures small but meaningful.

Validate that technology and build/test discovery work without dumping the whole source tree into context.

---

# 4. Phase 2 — Schema Validation

The existing 13 schemas under `conformance/schemas/` are canonical.

Do not duplicate or redefine them.

Implement the smallest appropriate validator under:

```text
conformance/tests/
```

Validate:

```text
approval
audit-event
context
decision
knowledge
plan
requirement
review-finding
solution
state
task
test-result
verification
```

Validator requirements:
1. Load schema.
2. Load artifact.
3. Validate.
4. Report deterministic PASS/FAIL.
5. Show useful validation errors.
6. Do not modify canonical schemas.

Create:

```text
conformance/results/schema-validation.md
```

---

# 5. Phase 3 — State Transition Validation

Validate the expected lifecycle:

```text
INIT
→ DISCOVERED
→ REQUIREMENTS_READY
→ SOLUTION_READY
→ APPROVED
→ PLANNED
→ IMPLEMENTING
→ IMPLEMENTED
→ TESTED
→ VERIFIED
→ REVIEWING
→ REVIEWED
→ PR_READY
```

Also validate recovery states such as:

```text
APPROVAL_REJECTED
TEST_FAILED
VERIFY_FAILED
REVIEW_FAILED
FIX_REQUIRED
```

Invalid examples:

```text
INIT → IMPLEMENTING
SOLUTION_READY → IMPLEMENTING
TESTED → PR_READY
REVIEW_FAILED → PR_READY
```

Expected result: blocked/rejected according to the current specification.

Create:

```text
conformance/results/state-validation.md
```

---

# 6. Phase 4 — Execute Existing 18 Scenarios

Existing scenarios:

```text
01-init.md
02-discovery.md
03-requirements.md
04-context.md
05-solution.md
06-approval.md
07-plan.md
08-implementation.md
09-test.md
10-verification.md
11-review.md
12-fix-loop.md
13-knowledge-reuse.md
14-database.md
15-security.md
16-traceability.md
17-modernization.md
18-capability-negotiation.md
```

For each:

1. Read scenario.
2. Identify inputs.
3. Identify expected outputs.
4. Select fixture.
5. Execute.
6. Validate generated artifacts.
7. Record evidence.
8. Mark PASS/FAIL/BLOCKED.

Create one result file per scenario under:

```text
conformance/results/
```

Do not rewrite scenarios merely to make them pass.

---

# 7. Phase 5 — Phase-to-Phase Context Sharing

This is a mandatory V1.0 test.

Create:

```text
conformance/scenarios/19-phase-context-sharing.md
```

Test:

```text
DISCOVERY
   ↓
persistent artifacts
   ↓
NEW AI SESSION
   ↓
REQUIREMENTS
   ↓
persistent artifacts
   ↓
NEW AI SESSION
   ↓
SOLUTION
   ↓
NEW AI SESSION
   ↓
PLAN
   ↓
NEW AI SESSION
   ↓
IMPLEMENT
```

The next phase must reconstruct required context from persistent DevWeave artifacts, not the previous chat.

Validate:
- discovery output is consumed by requirements
- requirements are consumed by solution
- solution is consumed by plan
- plan is consumed by implementation
- irrelevant repository content is not unnecessarily included

Create:

```text
conformance/results/19-phase-context-sharing.md
```

PASS means the workflow can continue correctly after terminating the previous AI session.

---

# 8. Phase 6 — Knowledge Creation and Reuse

Work Item A:
- Discover a business/technical rule.
- Persist it as validated knowledge with evidence.

Example:

```text
Bookings cannot be cancelled after check-in.
```

Work Item B:
- Create another work item requiring the same rule.
- Verify that the existing knowledge is retrieved rather than rediscovering the entire repository.

Record:
- knowledge created
- evidence
- knowledge retrieved
- redundant discovery
- context size where available

Create:

```text
conformance/results/knowledge-reuse.md
```

---

# 9. Phase 7 — Knowledge Invalidation

Create a knowledge item whose evidence references a source file.

Modify that source file.

Run knowledge validation.

Expected behavior is the state/revalidation behavior defined by the current specification, for example:

```text
APPROVED
   ↓
evidence changed
   ↓
NEEDS_REVALIDATION / equivalent supported state
```

Do not invent a new state without checking the current schema/specification.

Create:

```text
conformance/results/knowledge-invalidation.md
```

---

# 10. Phase 8 — Workflow Profiles

Inspect the profiles actually defined by V1.0 and validate them.

At minimum check:

```text
EXPRESS
BUG
FEATURE
REFACTOR
MODERNIZATION
SECURITY
DATABASE
HIGH_RISK
```

Validate that profiles intentionally differ in depth/approval/verification.

Examples:

### EXPRESS

```text
Context
→ Implement
→ Test
→ Verify
```

### REFACTOR

```text
Baseline tests
→ Implement
→ Regression tests
→ Verify
```

### HIGH_RISK

Validate deeper analysis, approval, and stronger verification/review as specified.

Create:

```text
conformance/results/workflow-profiles.md
```

---

# 11. Phase 9 — Database Conformance

Use only local/dev/test databases.

Never use production.

Validate:

```text
Work Item
→ detect DB impact
→ inspect relevant schema
→ design change
→ approval where required
→ apply migration/change
→ test
→ verify DB + application
→ review
```

Validate:
- schema discovery
- relevant object selection
- migration/change
- application compatibility
- tests
- verification
- audit/traceability

Keep the generic specification database-neutral.

Create:

```text
conformance/results/database.md
```

---

# 12. Phase 10 — Database Security

Validate environment boundaries:

```text
LOCAL       → allowed by configuration
DEVELOPMENT → allowed by configuration
TEST        → allowed by configuration
STAGING     → explicit approval
PRODUCTION  → blocked by default
```

Attempt a clearly marked production/simulated-production mutation.

Expected:

```text
BLOCKED
```

Do not weaken the protection to make the test pass.

Create:

```text
conformance/results/database-security.md
```

---

# 13. Phase 11 — Security

Test:
- secret detection
- credential protection
- dangerous shell commands
- destructive operations
- tool permissions
- MCP trust boundaries
- production restrictions

Verify that credentials are not written to:

```text
.aidlc/
conformance/results/
logs/
Git
```

where the implementation can reasonably prevent this.

Create:

```text
conformance/results/security.md
```

---

# 14. Phase 12 — Approval Gates

Test:

```text
SOLUTION_READY
      ↓
APPROVAL
```

Reject approval.

Expected:
- no implementation
- state remains recoverable
- decision recorded

Then approve and continue.

Create:

```text
conformance/results/approval-gates.md
```

---

# 15. Phase 13 — Failure and Recovery

Test:

### Approval rejection

```text
SOLUTION → REJECT
```

### Test failure

```text
IMPLEMENT
→ TEST
→ FAIL
→ FIX
→ RETEST
```

### Review failure

```text
REVIEW
→ FINDING
→ FIX
→ RETEST
→ REVERIFY
→ REVIEW
```

A review finding is not resolved merely because code changed.

Create:

```text
conformance/results/failure-recovery.md
```

---

# 16. Phase 14 — Interrupted Session / Resume

Start a work item and stop around:

```text
SOLUTION_READY
```

Terminate the AI session.

Start a new session.

Ask DevWeave to continue.

Verify it can reconstruct:
- work item
- current state
- requirements
- solution
- decisions
- tasks
- approvals
- pending work

from persistent artifacts/state.

Create:

```text
conformance/results/session-resume.md
```

---

# 17. Phase 15 — Complex Monorepo

Use:

```text
conformance/fixtures/complex-monorepo/
```

Example request:

> Change cancellation behavior in the bookings service.

Expected focused context:

```text
bookings
→ relevant shared components
→ relevant database objects
→ relevant tests
```

Do not indiscriminately load the entire repository.

Record where available:
- files discovered
- relevant files
- context size
- tools used
- token count
- unrelated files avoided

Create:

```text
conformance/results/complex-monorepo.md
```

---

# 18. Phase 16 — DevWeave Self-Validation

After controlled fixtures pass, validate DevWeave against itself.

Repository:

```text
DevWeave/
├── adapters/
├── conformance/
├── docs/
└── spec/
```

Run the existing DevWeave initialization/discovery mechanism.

Validate:
- repository discovery
- architecture discovery
- technology detection
- specification discovery
- adapter discovery
- conformance discovery
- documentation discovery
- test discovery

Then execute one small safe work item against the DevWeave repository.

Do not change the specification unless a genuine specification defect is demonstrated.

Create:

```text
conformance/results/devweave-self-validation.md
```

---

# 19. Phase 17 — Token and Cost Efficiency

This validates the product vision:

> Less Tokens. More Work. Lower Bill.

Compare the same work item in:

```text
A: unstructured AI workflow
B: DevWeave workflow
```

Measure where the host exposes metrics:

```text
Input tokens
Output tokens
Total tokens
AI turns
Context size
Files inspected
Tools used
Time
Rework cycles
Human interventions
Estimated cost
```

Never fabricate unavailable metrics.

If exact token counts are unavailable, report:

```text
NOT AVAILABLE
```

and measure valid proxies:
- AI turns
- files included
- repeated discovery
- context artifacts
- redundant tool calls

Create:

```text
conformance/results/token-efficiency.md
```

---

# 20. Phase 18 — Traceability

Validate:

```text
REQ
 ↓
SOLUTION
 ↓
DECISION
 ↓
PLAN
 ↓
TASK
 ↓
CODE
 ↓
TEST
 ↓
VERIFICATION
 ↓
REVIEW
 ↓
PR
```

For at least one complete feature, every link must be discoverable.

Create:

```text
conformance/results/traceability.md
```

---

# 21. Phase 19 — Modernization

Test:

```text
Assessment
→ Target Architecture
→ Migration Strategy
→ Migration Plan
→ Implementation
→ Tests
→ Verification
→ Review
```

Verify that the workflow does not automatically choose a rewrite when incremental modernization is appropriate.

Create:

```text
conformance/results/modernization.md
```

---

# 22. Phase 20 — Capability Negotiation

Test a capability profile such as:

```yaml
skills: true
agents: true
hooks: true
mcp: true
parallelAgents: true
dynamicModelSelection: true
backgroundAgents: false
```

Verify:

```text
SUPPORTED
PARTIALLY_SUPPORTED
NOT_SUPPORTED
FALLBACK
```

Never pretend an unavailable host capability exists.

Create:

```text
conformance/results/capability-negotiation.md
```

---

# 23. Phase 21 — Full Conformance Run

After individual scenarios pass, execute the full suite:

```text
01 → 02 → 03 → ... → 18
```

Then execute the added V1.0 validations:

```text
phase context sharing
knowledge invalidation
workflow profiles
database security
session resume
complex monorepo
token efficiency
traceability
modernization
capability negotiation
self-validation
```

---

# 24. Final Conformance Matrix

Create:

```text
conformance/results/V1.0-conformance-matrix.md
```

Use:

| ID | Area | Scenario | Expected | Actual | Status | Evidence |
|---|---|---|---|---|---|---|
| LC-001 | Lifecycle | INIT | Pass | | | |
| LC-002 | Lifecycle | Discovery | Pass | | | |
| CT-001 | Context | Phase handoff | Pass | | | |
| CT-002 | Context | New session resume | Pass | | | |
| KN-001 | Knowledge | Create | Pass | | | |
| KN-002 | Knowledge | Reuse | Pass | | | |
| KN-003 | Knowledge | Invalidation | Pass | | | |
| DB-001 | Database | Schema discovery | Pass | | | |
| DB-002 | Database | Migration | Pass | | | |
| SEC-001 | Security | Production block | Pass | | | |
| REC-001 | Recovery | Test failure | Pass | | | |
| REC-002 | Recovery | Review failure | Pass | | | |
| MON-001 | Repository | Complex monorepo | Pass | | | |
| EFF-001 | Efficiency | Context/token measurement | Pass | | | |
| TR-001 | Traceability | End-to-end chain | Pass | | | |

---

# 25. Failure Classification

Before fixing a failure classify it:

```text
CONFORMANCE FAILURE
        |
        +-- Specification defect
        +-- Core implementation defect
        +-- Host adapter defect
        +-- Fixture/test defect
        +-- Environment/tooling defect
        +-- Documentation defect
```

Ask:
1. Is the expected behavior actually in the specification?
2. Is the scenario correct?
3. Is the fixture correct?
4. Is the adapter translating correctly?
5. Is the host missing a capability?
6. Is the implementation wrong?

Do not immediately modify the core.

---

# 26. Fix Loop

For a genuine V1.0 defect:

```text
FAIL
→ classify
→ create defect
→ fix
→ run focused test
→ run affected scenario
→ run regression tests
→ update evidence
```

Never mark a failure PASS without rerunning it.

---

# 27. V1.0 Release Gate

V1.0 is ready for release candidate only when:

```text
[ ] 18 baseline scenarios executed
[ ] Schema validation passes
[ ] State transition validation passes
[ ] Phase-to-phase context sharing passes
[ ] New-session resume passes
[ ] Knowledge creation passes
[ ] Knowledge reuse passes
[ ] Knowledge invalidation passes
[ ] Workflow profiles pass
[ ] Database workflow passes
[ ] Production DB protection passes
[ ] Security tests pass
[ ] Approval gates pass
[ ] Failure/recovery passes
[ ] Complex monorepo passes
[ ] Traceability passes
[ ] Modernization passes
[ ] Capability negotiation passes
[ ] Token/context measurement completed
[ ] DevWeave self-validation completed
[ ] Documentation reviewed
[ ] No unresolved V1.0 critical/high defects
```

---

# 28. Final Evidence Package

Create:

```text
conformance/results/
├── baseline.md
├── V1.0-conformance-matrix.md
├── 01-init.md
├── 02-discovery.md
├── ...
├── 18-capability-negotiation.md
├── phase-context-sharing.md
├── knowledge-reuse.md
├── knowledge-invalidation.md
├── workflow-profiles.md
├── database.md
├── database-security.md
├── security.md
├── approval-gates.md
├── failure-recovery.md
├── session-resume.md
├── complex-monorepo.md
├── token-efficiency.md
├── traceability.md
├── modernization.md
├── capability-negotiation.md
└── devweave-self-validation.md
```

Never put secrets or credentials in these files.

---

# 29. Final V1.0 Report

Create:

```text
docs/V1.0-CONFORMANCE-REPORT.md
```

Include:
- executive summary
- lifecycle results
- context results
- knowledge results
- database results
- security results
- complex repository results
- token/context measurements
- defects
- known limitations
- factual release status

Do not claim a release is ready unless the evidence supports it.

---

# 30. Git Discipline

After each major successful phase:

```bash
git status
git diff
git add <specific-files>
git commit -m "<appropriate message>"
```

Suggested commits:

```text
test: add V1.0 conformance fixtures
test: add schema validation
test: add state transition validation
test: execute lifecycle conformance
test: validate phase context sharing
test: validate knowledge reuse
test: validate database boundaries
test: validate security controls
test: validate recovery workflows
test: validate complex repository behavior
test: add token efficiency measurements
docs: add V1.0 conformance report
```

Do not create one giant unrelated commit.

---

# 31. V1.1 Boundary

During this validation:

```text
V1.0 bug
    → fix

V1.0 required behavior missing
    → implement

V1.1 enhancement
    → backlog
```

Do not pull V1.1 features into V1.0 simply because a validation run suggests an enhancement.

---

# 32. Final Definition of Done

The V1.0 Conformance & Validation phase is complete when:

```text
Specification validated
        ↓
Host adapter validated
        ↓
Lifecycle validated
        ↓
Persistent phase context validated
        ↓
Knowledge validated
        ↓
Database validated
        ↓
Security validated
        ↓
Failure recovery validated
        ↓
Complex repositories validated
        ↓
Token/context efficiency measured
        ↓
DevWeave validates itself
        ↓
Evidence package complete
        ↓
V1.0 Release Candidate
```

The final proof should demonstrate that an unfamiliar developer can use DevWeave on an unfamiliar repository, execute an AI-DLC work item, continue across independent AI sessions using persistent artifacts, reuse knowledge, make authorized database changes, recover from failures, and obtain traceable verification evidence.
