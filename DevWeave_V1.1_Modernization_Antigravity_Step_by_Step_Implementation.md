# DevWeave V1.1 Modernization — Google Antigravity Step-by-Step Implementation Plan

## 0. Purpose

This document is the implementation playbook for adding the **V1.1 Modernization lifecycle** to the existing DevWeave repository using **Google Antigravity**.

The implementation must preserve the existing V1.0 behavior and architecture.

The modernization experience must remain simple for users:

```text
devweave-modernization-init
        ↓
devweave-modernization-context <ID>
        ↓
devweave-modernization-analyze <ID>
        ↓
devweave-modernization-plan <ID>
        ↓
devweave-modernization-branch <ID>
        ↓
devweave-modernization-implement <ID>
        ↓
devweave-modernization-verify <ID>
        ↓
devweave-modernization-pr <ID>
```

Every command performs **only its own phase**, persists state/artifacts, reports the result, suggests the next command, and stops.

The user controls progression.

---

# 1. Non-Negotiable Design Principles

## 1.1 Preserve V1.0

Do not break, rename, or silently change existing V1.0 behavior.

Existing V1.0 commands remain independent.

Examples:

```text
devweave-init
devweave-context <ID>
devweave-analyze <ID>
devweave-plan <ID>
devweave-branch <ID>
devweave-implement <ID>
devweave-pr-review <ID>
devweave-pr <ID>
```

Modernization commands are additive.

---

## 1.2 Mandatory modernization CLI names

Use hyphen-separated commands.

Correct:

```text
devweave-modernization-init
devweave-modernization-context <ID>
devweave-modernization-analyze <ID>
devweave-modernization-plan <ID>
devweave-modernization-branch <ID>
devweave-modernization-implement <ID>
devweave-modernization-verify <ID>
devweave-modernization-pr <ID>
devweave-modernization-status <ID>
devweave-modernization-report <ID>
```

Do not implement:

```text
devweave modernization init
devweave modernization context
```

---

## 1.3 User provides intent, not a giant questionnaire

The modernization initializer must accept natural language.

Example:

> We are using Angular FE with Bootstrap, backend as microservices with CQRS pattern and MySQL database. Write whatever is required as part of the modernization following these architectural decisions.

DevWeave should extract:

```text
Frontend:
  Angular
  Bootstrap

Backend:
  Microservices
  CQRS

Database:
  MySQL

Implementation policy:
  DevWeave may determine unspecified implementation details.
```

Do not ask the user for every implementation detail.

---

## 1.4 Repository inspection is authoritative for observed facts

If code exists:

```text
User declaration
        +
Repository observation
        ↓
Normalized architecture intent
```

If the repository is new or contains insufficient code:

```text
User declaration
        ↓
Initial target architecture intent
        ↓
Unknown details remain UNKNOWN
```

Never fabricate repository facts.

---

## 1.5 Technology-aware engineering intelligence

Based on the declared and detected technology stack, DevWeave should build an engineering practice profile covering applicable:

- Best practices
- Design patterns
- SOLID principles
- Clean code
- Architecture principles
- Security practices
- API practices
- Database practices
- Testing practices
- Performance practices
- Error handling
- Logging
- Observability
- Configuration
- Dependency management
- Code organization
- Git practices
- Anti-patterns

These are guidance and constraints, not a reason to invent requirements.

---

## 1.6 Practice intelligence must be version-aware

Example:

```text
Angular 17
.NET 10
MySQL 8
```

must not be treated as equivalent to arbitrary older versions.

Technology knowledge must support:

```text
technology
version
practice
source
status
lastVerified
```

When a version changes, affected knowledge can become:

```text
NEEDS_REVALIDATION
```

---

## 1.7 Human-controlled progression

Every phase follows:

```text
Execute phase
    ↓
Persist artifacts/state
    ↓
Summarize
    ↓
Suggest next command
    ↓
STOP
```

Never:

```text
Phase A → automatically execute Phase B
```

Approval of Phase N never approves Phase N+1.

---

# 2. Modernization Lifecycle

```text
INIT
 ↓
CONTEXT
 ↓
ANALYZE
 ↓
HARD GATE #1
 ↓
PLAN
 ↓
HARD GATE #2
 ↓
BRANCH
 ↓
IMPLEMENT
 ↓
VERIFY
 ↓
HARD GATE #3
 ↓
PR
```

The hard gates are human-controlled checkpoints.

---

# 3. Modernization Workspace

Use the existing `.devweave` convention.

Target structure:

```text
.devweave/
└── modernization/
    └── MOD-001/
        ├── workspace.json
        ├── source-memory.json
        ├── architecture-intent.json
        ├── technology-profile.json
        ├── migration-unit.json
        ├── mappings.json
        ├── state.json
        ├── context.md
        ├── analysis.md
        ├── plan.md
        ├── verification.md
        └── report.md
```

Do not create a second competing `.aidlc` structure.

---

# 4. State Model

Use durable JSON state.

Example:

```json
{
  "id": "MOD-001",
  "type": "MODERNIZATION",
  "currentPhase": "INIT",
  "status": "WAITING_FOR_HUMAN",
  "phases": {
    "INIT": "COMPLETED",
    "CONTEXT": "PENDING",
    "ANALYZE": "PENDING",
    "PLAN": "PENDING",
    "BRANCH": "PENDING",
    "IMPLEMENT": "PENDING",
    "VERIFY": "PENDING",
    "PR": "PENDING"
  },
  "nextSuggestedPhase": "CONTEXT"
}
```

Supported human decisions:

```text
APPROVE
REQUEST_CHANGES
PROVIDE_INFORMATION
REJECT
STOP
RETRY
```

No silence or timeout means approval.

---

# Step 1 — Inspect the Existing DevWeave Repository

## Goal

Understand the existing V1.0 implementation before changing anything.

## Antigravity instruction

```text
Inspect the complete DevWeave repository.

Do not modify files.

Identify:
1. CLI implementation
2. Existing V1.0 commands
3. Existing Antigravity adapter
4. Existing skills
5. Existing workflow/state implementation
6. Existing .devweave structure
7. Existing JSON schemas
8. Existing knowledge graph implementation
9. Existing technology detection/revalidation
10. Existing tests
11. Existing documentation
12. Existing package/build/test commands

Return:
- repository structure
- relevant files
- extension points
- V1.0 behavior
- risks
- exact files likely required for V1.1

STOP after inspection.
```

## Acceptance

No code changes.

Create an implementation map before proceeding.

---

# Step 2 — Freeze the V1.0 Contract

## Goal

Create a clear V1.0 regression boundary.

Record:

```text
Existing command names
Existing command behavior
Existing state model
Existing graph behavior
Existing host adapter behavior
Existing tests
Existing documentation
```

Create or update a V1.0 conformance checklist only if the repository does not already contain one.

## Acceptance

V1.0 tests/build pass before V1.1 changes.

---

# Step 3 — Define the Modernization Command Contract

Implement the command contract:

```text
devweave-modernization-init
devweave-modernization-context <ID>
devweave-modernization-analyze <ID>
devweave-modernization-plan <ID>
devweave-modernization-branch <ID>
devweave-modernization-implement <ID>
devweave-modernization-verify <ID>
devweave-modernization-pr <ID>
devweave-modernization-status <ID>
devweave-modernization-report <ID>
```

Each command must map to exactly one phase.

Do not implement aliases using namespace syntax.

## Acceptance

CLI parser recognizes all required commands and rejects malformed modernization invocations clearly.

---

# Step 4 — Implement Modernization State Machine

Implement:

```text
INIT
CONTEXT
ANALYZE
PLAN
BRANCH
IMPLEMENT
VERIFY
PR
```

State transitions must be validated.

Examples:

```text
INIT → CONTEXT
CONTEXT → ANALYZE
ANALYZE → PLAN
PLAN → BRANCH
BRANCH → IMPLEMENT
IMPLEMENT → VERIFY
VERIFY → PR
```

Invalid progression must be blocked.

Example:

```text
devweave-modernization-implement MOD-001
```

before PLAN approval must produce:

```text
IMPLEMENT cannot start.

Required:
PLAN = APPROVED

Current:
PLAN = PENDING
```

Suggest the correct next command.

STOP.

---

# Step 5 — Implement the Simple Modernization Initializer

Command:

```text
devweave-modernization-init
```

The initializer should allow the user to describe the target system naturally.

Example:

```text
We are using Angular FE with Bootstrap,
backend as microservices with CQRS,
and MySQL database.

Write whatever is required as part of the modernization
following these architectural decisions.
```

Support:

- Natural language
- Short descriptions
- Copy/paste architecture notes
- Optional paths
- Auto-detection when repositories contain code
- Minimal clarification only when genuinely necessary

Do not turn initialization into a long questionnaire.

---

# Step 6 — Build Architecture Intent

Normalize user input into:

```json
{
  "frontend": {
    "technology": "Angular",
    "ui": "Bootstrap",
    "source": "USER_DECLARED"
  },
  "backend": {
    "architecture": "Microservices",
    "pattern": "CQRS",
    "source": "USER_DECLARED"
  },
  "database": {
    "technology": "MySQL",
    "source": "USER_DECLARED"
  },
  "implementationPolicy": {
    "unspecifiedDetails": "AI_DETERMINED"
  }
}
```

Use explicit evidence states:

```text
OBSERVED
USER_DECLARED
INFERRED
AI_PROPOSED
UNKNOWN
DECIDED
```

Do not convert assumptions into facts.

---

# Step 7 — Implement Repository Detection

When source code exists, detect:

```text
Languages
Frameworks
Versions
Build tools
Package managers
Databases
Architecture indicators
Existing patterns
Tests
CI/CD
Containerization
Configuration
```

Compare observed technology with user-declared intent.

Example:

```text
User:
Angular

Repository:
Angular 17 detected

Result:
MATCH
```

Example:

```text
User:
Angular

Repository:
React detected

Result:
CONFLICT
```

Do not silently resolve architectural conflicts.

Surface them to the user.

---

# Step 8 — Handle New/Empty Target Repositories

If there is insufficient target implementation:

```text
Repository observation:
INSUFFICIENT
```

Use the user's architecture intent as the initial target.

Do not ask unnecessary questions.

Unknowns remain:

```text
UNKNOWN
```

DevWeave determines implementation details later during ANALYZE and PLAN.

---

# Step 9 — Implement Technology Practice Intelligence

Build the technology practice profile from declared and observed technologies.

Categories:

```text
Best Practices
Design Patterns
SOLID
Clean Code
Architecture
Security
API
Database
Testing
Performance
Observability
Logging
Configuration
Dependencies
Anti-Patterns
```

Example:

```text
Angular
Bootstrap
Microservices
CQRS
MySQL
```

should produce a combined profile.

Do not send the complete profile to every AI phase.

Create a retrieval mechanism for relevant practices.

---

# Step 10 — Implement Version-Aware Technology Knowledge

For each technology:

```json
{
  "id": "TECH-001",
  "name": "Angular",
  "version": "17",
  "source": "OBSERVED",
  "status": "CURRENT",
  "lastVerified": "..."
}
```

Support:

```text
CURRENT
NEEDS_REVALIDATION
UNKNOWN
```

When technology changes:

```text
.NET 3.0 → .NET 10
```

mark affected practices:

```text
NEEDS_REVALIDATION
```

Refresh only affected knowledge.

---

# Step 11 — Implement Modernization Source Memory

Support source repositories independently from the target repository.

Example:

```json
{
  "sources": [
    {
      "id": "legacy-crm",
      "role": "LEGACY",
      "repositoryPath": "../LegacyCRM",
      "access": "READ_ONLY"
    }
  ]
}
```

Requirements:

- Validate paths
- Prevent accidental writes to legacy source
- Support repository identity
- Support existing DevWeave knowledge graph
- Preserve source identity

---

# Step 12 — Implement Migration Units

Support generic units:

```text
PAGE
SCREEN
FEATURE
MODULE
SERVICE
DOMAIN
WORKFLOW
API
TRANSACTION
COMPONENT
CAPABILITY
CUSTOM
```

Do not hard-code modernization to:

```text
MVC → Angular
```

or:

```text
.NET → ASP.NET Core
```

Those are examples of target mappings, not core rules.

---

# Step 13 — Implement Modernization Context

Command:

```text
devweave-modernization-context MOD-001
```

Responsibilities:

```text
Read modernization state
Read architecture intent
Read repository knowledge
Read source memory
Identify modernization unit
Build migration slice
Retrieve relevant graph neighborhood
Retrieve relevant technology practices
Create context.md
```

The context should be bounded.

Do not load the entire legacy repository into the AI context.

---

# Step 14 — Implement Migration Slice Generation

A migration slice should contain only relevant information.

Example:

```text
Customer
 ├── Legacy page
 ├── Controller
 ├── Services
 ├── Business rules
 ├── Database tables
 ├── Queries
 ├── External APIs
 ├── Tests
 └── Configuration
```

Use graph relationships to discover dependencies.

Persist enough information to reproduce the analysis.

---

# Step 15 — Implement Modernization Analyze

Command:

```text
devweave-modernization-analyze MOD-001
```

Analyze:

```text
Legacy behavior
Business rules
Dependencies
Data access
APIs
Integrations
Tests
Security
Performance
Target architecture
Technology practices
```

Create:

```text
analysis.md
mappings.json
```

Example migration relationships:

```text
MIGRATED_TO
REPLACED_BY
TRANSFORMED_TO
SPLIT_INTO
MERGED_INTO
PRESERVED_AS
RETIRED
DEFERRED
UNKNOWN
```

---

# Step 16 — Implement Analysis Hard Gate

After ANALYZE:

```text
ANALYZE COMPLETED

Findings:
...

Open decisions:
...

Migration mapping:
...

Human decision required.

APPROVE
REQUEST_CHANGES
PROVIDE_INFORMATION
REJECT
```

Only `APPROVE` permits PLAN.

STOP.

---

# Step 17 — Implement Modernization Plan

Command:

```text
devweave-modernization-plan MOD-001
```

Generate:

```text
plan.md
```

The plan must include:

```text
Files to create
Files to modify
Files to retire
Architecture changes
API changes
Database changes
Tests
Security
Observability
Migration mapping
Validation commands
Rollback considerations
```

Apply relevant technology practice intelligence.

Do not blindly apply irrelevant patterns.

---

# Step 18 — Implement Plan Hard Gate

Present:

```text
Target architecture
Implementation sequence
Files
Database impact
API impact
Testing strategy
Known risks
Unknowns
```

Ask:

```text
APPROVE
REQUEST_CHANGES
PROVIDE_INFORMATION
REJECT
```

Only APPROVE allows BRANCH.

STOP.

---

# Step 19 — Implement Modernization Branch

Command:

```text
devweave-modernization-branch MOD-001
```

Validate:

```text
Plan approved
Working tree state
Current branch
Branch naming
Repository safety
```

Create and checkout the modernization branch.

Persist:

```json
{
  "branch": "devweave/modernization/MOD-001",
  "created": true,
  "checkedOut": true
}
```

Never modify the legacy source repository.

STOP.

---

# Step 20 — Implement Modernization Implementation Guardrails

Command:

```text
devweave-modernization-implement MOD-001
```

Implementation sequence:

```text
INSPECT
   ↓
IDENTIFY EXACT FILES
   ↓
READ REQUIRED CONTEXT
   ↓
MODIFY ONLY REQUIRED FILES
   ↓
BUILD
   ↓
RUN TESTS
   ↓
RUN ARCHITECTURE CHECKS
   ↓
GENERATE CHANGE SUMMARY
   ↓
PERSIST STATE
   ↓
STOP
```

Do not automatically run VERIFY or PR.

---

# Step 21 — Implement Behavior Preservation

Modernization is not simply code rewriting.

Verification must compare:

```text
Legacy behavior
        vs
Target behavior
```

Where appropriate, verify:

```text
Inputs
Outputs
Business rules
Validation
Authorization
Persistence behavior
Error behavior
Integration behavior
```

Document intentional behavior changes explicitly.

---

# Step 22 — Implement Verification

Command:

```text
devweave-modernization-verify MOD-001
```

Run:

```text
Build
Unit tests
Integration tests
Relevant acceptance tests
Static analysis
Architecture validation
Security checks
Database validation
Migration mapping validation
Behavior verification
```

Create:

```text
verification.md
```

---

# Step 23 — Implement Verification Hard Gate

Present:

```text
Verification result

Functional:
PASS / FAIL

Architecture:
PASS / FAIL

Tests:
PASS / FAIL

Security:
PASS / FAIL

Database:
PASS / FAIL

Behavior preservation:
PASS / FAIL

Outstanding issues:
...
```

Human decision:

```text
APPROVE
REQUEST_CHANGES
STOP
```

Only APPROVE allows PR preparation.

---

# Step 24 — Implement PR Preparation

Command:

```text
devweave-modernization-pr MOD-001
```

Generate:

```text
report.md
pr-description.md
```

Include:

```text
Modernization objective
Source system
Target architecture
Migration unit
Changes
Behavior preservation
Database changes
Tests
Verification
Known limitations
Migration relationships
Knowledge updates
```

Do not merge automatically.

---

# Step 25 — Implement Modernization Status

Command:

```text
devweave-modernization-status MOD-001
```

Example:

```text
Modernization: MOD-001
Current Phase: VERIFY
Status: WAITING_FOR_HUMAN

Completed:
✓ INIT
✓ CONTEXT
✓ ANALYZE
✓ PLAN
✓ BRANCH
✓ IMPLEMENT

Current:
→ VERIFY

Pending:
  PR

Next suggested command:
devweave-modernization-verify MOD-001
```

---

# Step 26 — Implement Modernization Report

Command:

```text
devweave-modernization-report MOD-001
```

Produce a complete modernization report.

Include:

```text
Source architecture
Target architecture
Technology profile
Modernization units
Migration mappings
Changes
Tests
Verification
Decisions
Human approvals
Unknowns
Known limitations
Knowledge changes
```

---

# Step 27 — Integrate With Existing Knowledge Graph

Do not replace the existing V1.0 JSON knowledge graph.

Extend it.

Modernization should create relationships such as:

```text
LEGACY_NODE
      │
      ├── MIGRATED_TO
      ↓
TARGET_NODE
```

Store incremental graph changes using the existing graph-delta approach where applicable.

Example:

```json
{
  "relationship": {
    "source": "legacy:customer-page",
    "type": "MIGRATED_TO",
    "target": "modern:customer-feature"
  }
}
```

---

# Step 28 — Implement Knowledge Reconciliation

After successful modernization:

```text
Source knowledge
        +
Target repository knowledge
        +
Migration relationships
        ↓
Updated DevWeave knowledge
```

Do not erase legacy knowledge.

Mark relationships and status.

---

# Step 29 — Implement Error Recovery

Each phase must be resumable.

Examples:

```text
BUILD_FAILED
TEST_FAILED
ANALYSIS_INCOMPLETE
PLAN_REJECTED
BRANCH_FAILED
VERIFICATION_FAILED
```

The system should preserve previous artifacts.

A retry must not blindly repeat destructive work.

---

# Step 30 — Implement Human Change Requests

If the user says:

```text
REQUEST_CHANGES
```

preserve the previous artifact.

Prefer versioned artifacts:

```text
plan/
  v1.md
  v2.md
```

State identifies the approved version.

Do not silently overwrite the previous approved decision.

---

# Step 31 — Implement Antigravity Host Adapter

Use the existing Antigravity adapter structure.

Do not create a second independent host architecture.

Add modernization skills that invoke the portable DevWeave modernization contract.

The adapter should translate:

```text
DevWeave modernization phase
        ↓
Antigravity execution instructions
        ↓
Repository changes
        ↓
DevWeave artifacts/state
```

DevWeave remains host-neutral.

---

# Step 32 — Create Antigravity Skills

Create or extend skills for:

```text
devweave-modernization-init
devweave-modernization-context
devweave-modernization-analyze
devweave-modernization-plan
devweave-modernization-branch
devweave-modernization-implement
devweave-modernization-verify
devweave-modernization-pr
devweave-modernization-status
devweave-modernization-report
```

Each skill must contain:

```text
Purpose
Inputs
Preconditions
Allowed actions
Artifacts
State updates
Human checkpoint
Next suggested command
Failure behavior
STOP rule
```

---

# Step 33 — Add Technology Practice Retrieval to Skills

Do not put a huge practice catalog into every skill.

Instead:

```text
Skill
  ↓
Technology Profile
  ↓
Relevant Practice Retrieval
  ↓
Current phase
```

For example, implementation of a MySQL repository should retrieve database practices relevant to that implementation.

Angular UI implementation should retrieve Angular/UI practices.

CQRS command implementation should retrieve CQRS/application practices.

This keeps prompts small.

---

# Step 34 — Add Security and Isolation Controls

Validate:

```text
Repository paths
Source repository access
Target repository access
Path traversal
Symlinks
Secrets
Credentials
Tokens
PII
Generated artifacts
```

Legacy source should default to:

```text
READ_ONLY
```

Target repository:

```text
READ_WRITE
```

unless explicitly configured otherwise.

---

# Step 35 — Add Tests

At minimum test:

```text
CLI parsing
State transitions
Invalid phase progression
Init with natural language
Existing repository detection
New repository behavior
Architecture intent normalization
Technology profile generation
Version revalidation
Migration units
Migration relationships
Context slicing
Analysis
Plan
Branch
Implementation guardrails
Verification
PR generation
Status
Report
Human approval
Request changes
Retry
Path isolation
Legacy repository protection
```

---

# Step 36 — V1.0 Regression

Run the complete existing V1.0 suite.

Verify:

```text
V1.0 command behavior unchanged
V1.0 graph behavior unchanged
V1.0 host adapter behavior unchanged
V1.0 documentation remains valid
```

Any regression blocks completion.

---

# Step 37 — End-to-End Modernization Test

Use a small representative modernization repository.

Test:

```text
devweave-modernization-init
        ↓
APPROVE
        ↓
devweave-modernization-context MOD-001
        ↓
APPROVE
        ↓
devweave-modernization-analyze MOD-001
        ↓
APPROVE
        ↓
devweave-modernization-plan MOD-001
        ↓
APPROVE
        ↓
devweave-modernization-branch MOD-001
        ↓
devweave-modernization-implement MOD-001
        ↓
devweave-modernization-verify MOD-001
        ↓
APPROVE
        ↓
devweave-modernization-pr MOD-001
```

Verify that no phase automatically triggers the next phase.

---

# Step 38 — Test the New Repository Scenario

Test exactly this user experience:

```text
Angular + Bootstrap
Microservices + CQRS
MySQL
Build whatever is required.
```

Target repository contains no meaningful implementation.

Expected:

```text
✓ User intent captured
✓ No false repository facts
✓ Technology profile created
✓ Architecture intent created
✓ Unknown details remain unknown
✓ No unnecessary questionnaire
✓ Human approval requested
```

---

# Step 39 — Test Existing Repository Scenario

Provide a repository with existing code.

Verify:

```text
✓ Technology auto-detection
✓ Version detection
✓ Repository conventions
✓ Existing architecture discovery
✓ Conflict detection
✓ Relevant practices
✓ Migration slice
```

The system must distinguish:

```text
USER_DECLARED
OBSERVED
INFERRED
UNKNOWN
```

---

# Step 40 — Documentation

Update only canonical documentation.

Document:

```text
Modernization overview
Modernization architecture
CLI reference
Initialization UX
Technology practice intelligence
Migration units
Migration mappings
State machine
Human approval
Source repository isolation
Antigravity usage
Troubleshooting
Examples
```

Do not create duplicate competing documentation.

---

# Step 41 — Conformance Audit

Verify every requirement against implementation.

Create a conformance table:

```text
Requirement
Implementation
Test
Documentation
Status
```

Allowed status:

```text
SPECIFIED
DESIGNED
IMPLEMENTED
TESTED
DOCUMENTED
COMPLETE
```

Do not mark COMPLETE until implementation, tests, and documentation exist.

---

# Step 42 — Final Antigravity Audit

Ask Antigravity to inspect the final implementation.

Instruction:

```text
Perform a final V1.0/V1.1 audit.

Verify:
1. V1.0 has not been broken.
2. All modernization commands use mandatory hyphenated names.
3. Human-controlled phase progression is enforced.
4. Modernization init does not become a long questionnaire.
5. User architecture intent is captured.
6. Existing repositories are inspected.
7. New repositories can start from user intent.
8. Technology-specific practices are generated.
9. Practices are version-aware.
10. SOLID and design principles are available as engineering guidance.
11. Migration units are generic.
12. Legacy source is protected.
13. Migration mappings are persisted.
14. State is durable.
15. Each phase stops after its own work.
16. Next phase is suggested but never auto-executed.
17. Tests pass.
18. Documentation matches implementation.

Do not modify anything during this audit.

Report:
PASS / FAIL
with evidence for each item.

STOP.
```

---

# Step 43 — Final User Experience Validation

The final experience should be simple.

User:

```text
devweave-modernization-init
```

User:

```text
We are using Angular with Bootstrap.
Backend is microservices with CQRS.
Database is MySQL.
Build whatever is required following these patterns.
```

DevWeave:

```text
✓ Target architecture understood
✓ Repository inspected
✓ Technologies detected where possible
✓ Engineering practices prepared
✓ SOLID/design principles prepared
✓ Security/testing/database practices prepared
✓ Unknown implementation details will be determined during analysis

Modernization intent is ready.

APPROVE / MODIFY / CANCEL
```

Then:

```text
devweave-modernization-context MOD-001
```

and so on.

The user should never need to understand the internal complexity.

---

# Step N — Final Definition of Done

V1.1 Modernization is complete only when all of the following are true:

```text
[ ] Existing V1.0 behavior remains intact
[ ] Mandatory hyphenated modernization CLI exists
[ ] Modernization state machine works
[ ] Human checkpoints work
[ ] Natural-language initialization works
[ ] Existing repository detection works
[ ] New repository initialization works
[ ] Architecture intent is persisted
[ ] Technology profile is generated
[ ] Best practices are technology-aware
[ ] Design patterns are technology-aware
[ ] SOLID guidance is available
[ ] Security practices are available
[ ] Testing practices are available
[ ] Database practices are available
[ ] Version-aware technology knowledge works
[ ] Source-memory isolation works
[ ] Migration units are generic
[ ] Migration mappings work
[ ] Context slicing works
[ ] Analyze works
[ ] Plan works
[ ] Branch works
[ ] Implement works
[ ] Verify works
[ ] PR preparation works
[ ] Status works
[ ] Report works
[ ] Retry/change-request behavior works
[ ] Knowledge graph integration works
[ ] V1.0 regression suite passes
[ ] V1.1 modernization tests pass
[ ] End-to-end modernization test passes
[ ] Antigravity adapter works
[ ] Documentation is synchronized
[ ] Final conformance audit passes
```

## Final implementation rule

**Do not implement all steps in one Antigravity execution.**

Execute this plan progressively:

```text
Step 1
  ↓
Validate
  ↓
STOP

Step 2
  ↓
Validate
  ↓
STOP

...

Step N
  ↓
Validate
  ↓
STOP
```

At every step, Antigravity must:

1. Inspect before modifying.
2. Identify exact files.
3. Modify only required files.
4. Run the smallest relevant validation.
5. Preserve V1.0 behavior.
6. Report what changed.
7. Report what was validated.
8. Report remaining work.
9. Stop.

This makes the modernization implementation auditable, reversible, and safe for the existing DevWeave repository.
