# DevWeave V1.0 — Comprehensive MMGI-Inspired Antigravity Implementation Plan

## Purpose

This document is the **master step-by-step implementation instruction for Google Antigravity**.

DevWeave should adopt almost all of the useful engineering workflow capabilities demonstrated by the uploaded MMGI AIDLC plugin reference, while remaining generic and vendor-neutral.

Reference source:

- MMGI AIDLC Plugin document supplied by the user.
- MMGI's useful concepts include phase-based orchestration, durable knowledge, bug/feature routing, modernization, fix workflows, resume, handoff, archive, express execution, audit, metrics, domain-driven behavior, MCP exposure, model/capability routing, and strong execution gates.

DevWeave additionally introduces a capability that MMGI does **not** adequately provide:

> **Technology/version change detection must automatically identify affected repository knowledge, skills/rules/templates/configuration references, and implementation guidance, mark them for revalidation, and refresh the affected files before dependent work continues.**

Example:

```text
.NET Core 3.0
      ↓
.NET 10
      ↓
Detect technology change
      ↓
Identify affected DevWeave knowledge/rules/templates
      ↓
Mark affected items NEEDS_REVALIDATION
      ↓
Refresh affected files
      ↓
Validate refreshed content
      ↓
Continue modernization
```

The refresh must be **targeted**, not a complete repository rediscovery.

---

# 0. NON-NEGOTIABLE PRINCIPLES

Antigravity must preserve these principles throughout implementation.

## 0.1 Generic

The DevWeave core must not depend on:

- JIRA
- Azure DevOps
- GitHub
- GitLab
- Linear
- Claude
- Gemini
- Codex
- Copilot
- Google Antigravity
- .NET
- Angular
- React
- Node
- Python
- MySQL
- PostgreSQL
- Azure
- AWS
- GCP

These belong behind adapters, capability contracts, or repository configuration.

---

## 0.2 MMGI-style six-phase user workflow

The canonical user workflow is:

```text
CONTEXT
   ↓
ANALYZE
   ↓
PLAN
   ↓
BRANCH
   ↓
IMPLEMENT
   ↓
PR
```

The only repository-level initialization command is:

```text
DevWeave init
```

Work-item execution starts with:

```text
DevWeave-context <WorkItem-ID>
```

---

## 0.3 Human-in-the-loop at every phase

Every phase MUST:

1. execute its own work
2. create/update its artifact
3. summarize what it did
4. ask the human for a decision
5. persist the decision
6. suggest the next phase
7. STOP

The AI MUST NOT automatically execute the next phase.

---

## 0.4 Explicit phase advancement

This is mandatory:

```text
DevWeave-context ID
        ↓
CONTEXT complete
        ↓
Human decision
        ↓
Suggest ANALYZE
        ↓
STOP
```

The user later explicitly runs:

```text
DevWeave-analyze ID
```

No implicit chaining.

---

## 0.5 Durable state

All workflow state must survive:

- session termination
- IDE restart
- model change
- developer handoff
- branch checkout
- interrupted execution

---

# 1. STEP 1 — INSPECT THE EXISTING DEVWEAVE REPOSITORY

Before modifying anything:

1. Inspect the repository tree.
2. Read existing:
   - `README.md`
   - `VERSION`
   - `CHANGELOG.md`
   - `spec/`
   - `docs/`
   - `conformance/`
   - plugin/adapter directories
   - Skills
   - agents
   - rules
   - MCP configuration
   - hooks
3. Search for all lifecycle commands and phase definitions.
4. Locate `.devweave/` usage.
5. Identify current knowledge structure.
6. Identify current state structure.
7. Identify current implementation status.

Do not modify code in this step.

Produce a current-state report if one does not already exist.

### STOP.

---

# 2. STEP 2 — CREATE A CAPABILITY GAP MATRIX

Create a matrix covering all capabilities below.

| Capability | Spec | Design | Implementation | Conformance | Documentation |
|---|---|---|---|---|---|
| Init | | | | | |
| Context | | | | | |
| Analyze | | | | | |
| Plan | | | | | |
| Branch | | | | | |
| Implement | | | | | |
| PR | | | | | |
| HITL | | | | | |
| Explicit phase stop | | | | | |
| Resume | | | | | |
| Handoff | | | | | |
| Archive | | | | | |
| Express | | | | | |
| Bug flow | | | | | |
| Feature flow | | | | | |
| Modernization | | | | | |
| Fix lane | | | | | |
| Durable knowledge | | | | | |
| Technology detection | | | | | |
| Technology version refresh | | | | | |
| Knowledge invalidation | | | | | |
| Practice refresh | | | | | |
| Project-management MCP | | | | | |
| Database | | | | | |
| Security | | | | | |
| Audit | | | | | |
| Metrics | | | | | |
| Traceability | | | | | |
| Model routing | | | | | |
| Token optimization | | | | | |
| Host adapter | | | | | |

Do not claim IMPLEMENTED unless actual code exists.

Use:

```text
SPECIFIED
DESIGNED
IMPLEMENTED
TESTED
DOCUMENTED
```

### STOP.

---

# 3. STEP 3 — CANONICAL WORKFLOW SPECIFICATION

Update the AI-DLC specification.

Canonical user workflow:

```text
DevWeave init

CONTEXT
→ ANALYZE
→ PLAN
→ BRANCH
→ IMPLEMENT
→ PR
```

Do not expose internal subphases as the primary lifecycle.

The following remain internal:

```text
Requirements
Solution
Approval
Testing
Verification
Review
Fix/retest/reverify
```

They execute inside the appropriate six phases.

### STOP.

---

# 4. STEP 4 — HUMAN-IN-THE-LOOP CONTRACT

Define:

```text
APPROVE
REQUEST_CHANGES
PROVIDE_INFORMATION
REJECT
STOP
RETRY
```

Every phase must have a human checkpoint.

Example:

```text
CONTEXT COMPLETE

Summary:
...

Artifact:
...

Human decision:
[Approve]
[Request Changes]
[Add Information]
[Stop]

Suggested next:
ANALYZE

Run:
DevWeave-analyze ID

DevWeave is waiting for your instruction.
```

Do not automatically continue.

### STOP.

---

# 5. STEP 5 — STATE MACHINE

Use:

```yaml
workItemId: <ID>
currentPhase: CONTEXT
status: WAITING_FOR_HUMAN

phases:
  CONTEXT: PENDING
  ANALYZE: PENDING
  PLAN: PENDING
  BRANCH: PENDING
  IMPLEMENT: PENDING
  PR: PENDING

nextSuggestedPhase: ANALYZE
```

Persist:

- phase
- status
- artifact
- decision
- decision actor
- decision timestamp
- comments
- next phase
- errors
- retries
- audit references

### STOP.

---

# 6. STEP 6 — CONTEXT

Command:

```text
DevWeave-context <ID>
```

Adopt MMGI's context concept.

Perform:

- work-item retrieval
- repository context loading
- product/domain knowledge loading
- relevant technology knowledge loading
- affected-area identification
- dependency identification
- provenance
- security/policy checks
- context artifact creation

For a feature, include where available:

- parent/epic context
- acceptance criteria
- design references
- sibling work items

For a bug:

- attachments/evidence
- environment
- reproduction information
- relevant runtime context

After completion:

```text
CONTEXT COMPLETE
```

Human decision.

Suggest ANALYZE.

Stop.

### STOP.

---

# 7. STEP 7 — ANALYZE

Command:

```text
DevWeave-analyze <ID>
```

For feature work:

```text
requirements
→ component mapping
→ reuse/extend/new
→ architecture impact
→ options
→ trade-offs
→ risks
```

For bugs:

```text
symptom
→ evidence
→ hypotheses
→ separating observation
→ root cause
→ minimal change
→ regression sweep
```

For modernization:

```text
current state
→ target state
→ gap
→ migration options
→ compatibility
→ risks
→ migration strategy
```

For database work:

```text
schema
→ dependencies
→ migration impact
→ data risk
→ rollback
```

After completion:

Human checkpoint.

Suggest PLAN.

Stop.

### STOP.

---

# 8. STEP 8 — PLAN

Command:

```text
DevWeave-plan <ID>
```

Produce an implementation-grade plan.

Each change should contain:

```text
file
symbol/anchor
change
reason
dependencies
acceptance check
tests
risk
```

Where relevant:

- API
- UI
- DB
- migration
- security
- performance
- deployment
- rollback
- compatibility

For modernization, the plan must additionally produce a migration plan/manifest equivalent where required.

After completion:

Human checkpoint.

Suggest BRANCH.

Stop.

### STOP.

---

# 9. STEP 9 — BRANCH

Command:

```text
DevWeave-branch <ID>
```

Validate:

- context completed
- analyze completed
- plan completed
- plan human-approved
- repository clean/suitable
- branch rules satisfied

Ask explicit human approval.

Create branch only after approval.

Then:

```text
BRANCH COMPLETE

Suggested:
DevWeave-implement <ID>
```

Stop.

### STOP.

---

# 10. STEP 10 — IMPLEMENT

Command:

```text
DevWeave-implement <ID>
```

Execute only the approved plan.

Must:

- load durable state
- load focused context
- load approved plan
- implement
- run relevant tests
- record changes
- record deviations
- update migration status where applicable

If the plan becomes invalid:

```text
IMPLEMENTATION BLOCKED

The approved plan is no longer valid.

Suggested:
Return to ANALYZE or PLAN.
```

Do not silently redesign.

At completion:

Human checkpoint.

Suggest PR.

Stop.

### STOP.

---

# 11. STEP 11 — PR

Command:

```text
DevWeave-pr <ID>
```

Internally execute:

```text
build
tests
requirements verification
acceptance verification
regression checks
security checks
architecture checks
code review
```

If findings exist:

```text
FIX
→ RETEST
→ REVERIFY
→ RE-REVIEW
```

When ready:

```text
PR READY
```

Ask explicit human approval before creating the external PR.

Stop.

### STOP.

---

# 12. STEP 12 — BUG AND FEATURE ROUTING

Use one command set.

Do not create separate:

```text
DevWeave-feature-*
DevWeave-bug-*
```

Instead detect work-item type and adapt phase behavior.

Example:

```text
BUG
→ root cause + evidence + regression

FEATURE
→ acceptance criteria + component mapping

TASK
→ scoped implementation

REFACTOR
→ behavior preservation + architecture improvement

SECURITY
→ threat/risk analysis + security verification

DATABASE
→ schema/data/migration controls

MODERNIZATION
→ current/target architecture + migration
```

Same six phases.

### STOP.

---

# 13. STEP 13 — MODERNIZATION FIRST-CLASS FLOW

DevWeave must support modernization as a first-class profile.

Examples:

```text
.NET Core 3.0 → .NET 10
Angular 8 → Angular 21
legacy API → modern API
monolith → services
old database version → supported database version
old authentication → modern authentication
```

Flow:

```text
CONTEXT
→ ANALYZE
→ PLAN
→ BRANCH
→ IMPLEMENT
→ PR
```

Modernization ANALYZE must establish:

- current architecture
- current technology versions
- target versions
- target architecture
- compatibility constraints
- deprecated APIs/packages
- affected components
- migration risks
- migration strategy

Modernization PLAN must produce:

- migration manifest/plan
- milestones
- feature parity where relevant
- compatibility checks
- migration sequencing
- rollback strategy

IMPLEMENT must update migration status as work progresses.

PR must verify migration completion and regression behavior.

### STOP.

---

# 14. STEP 14 — TECHNOLOGY VERSION CHANGE DETECTION AND REFRESH

## This is a mandatory DevWeave enhancement beyond the MMGI reference.

DevWeave MUST detect technology/version changes and refresh affected knowledge.

Example:

```text
Repository initially:

.NET Core 3.0

Later:

.NET 10
```

DevWeave must detect:

```text
Technology changed:
.NET 3.0 → .NET 10
```

Then identify:

```text
affected repository knowledge
affected technology knowledge
affected practices
affected rules
affected templates
affected examples
affected configuration guidance
affected Skills where they contain version-specific material
affected MCP/tool guidance
affected tests/conformance fixtures
```

### Important distinction

Do not blindly rewrite every Skill.

Classify every affected item:

```text
STABLE
VERSION_SENSITIVE
NEEDS_REVALIDATION
REFRESHED
OBSOLETE
```

A stable Skill should remain unchanged.

A version-sensitive Skill/document should be refreshed.

---

# 15. STEP 15 — TECHNOLOGY KNOWLEDGE REGISTRY

Create/update a technology registry.

Example:

```yaml
technology:
  id: dotnet
  name: .NET
  detectedVersion: "3.0"
  targetVersion: "10"
  status: NEEDS_REVALIDATION
  lastVerified: "..."
  evidence:
    - file: global.json
    - file: project.csproj
    - file: README.md
```

After refresh:

```yaml
technology:
  id: dotnet
  name: .NET
  detectedVersion: "10"
  status: CURRENT
  lastVerified: "..."
```

Use repository evidence.

Never infer a version without evidence.

### STOP.

---

# 16. STEP 16 — TARGETED REFRESH ENGINE

When a technology changes:

```text
Detect change
↓
Build impact graph
↓
Find dependent knowledge
↓
Find dependent practices
↓
Find version-sensitive Skills/rules/templates
↓
Mark affected artifacts
↓
Refresh only affected artifacts
↓
Validate
↓
Record refresh
```

Do NOT:

```text
technology changed
→ rediscover entire repository
→ rewrite everything
```

The goal is low token/cost impact.

---

# 17. STEP 17 — KNOWLEDGE INVALIDATION

Use:

```text
NEEDS_REVALIDATION
```

Example:

```yaml
id: TECH-DOTNET-001
type: technology
name: .NET
version: "3.0"
status: NEEDS_REVALIDATION
reason: Target technology changed to .NET 10
```

Affected artifacts should reference why they became stale.

Example:

```yaml
dependsOn:
  - technology: dotnet
    version: "3.0"
status: NEEDS_REVALIDATION
```

This makes stale knowledge visible.

### STOP.

---

# 18. STEP 18 — PRACTICE REFRESH

Practices must be version-aware.

Categories:

```text
MANDATORY
RECOMMENDED
ADVISORY
ANTI_PATTERN
```

Sources:

```text
Security/Compliance
Organization Policy
Repository Convention
Official Technology Guidance
DevWeave Recommendation
```

When technology changes, refresh applicable practices.

Example:

```text
.NET Core 3 practice
       ↓
NEEDS_REVALIDATION
       ↓
.NET 10 practice
```

### STOP.

---

# 19. STEP 19 — DURABLE PRODUCT AND DOMAIN KNOWLEDGE

Adopt the MMGI durable knowledge concept.

Use the existing DevWeave canonical structure.

Conceptually:

```text
.devweave/
├── knowledge/
│   ├── products/
│   ├── domains/
│   ├── architecture/
│   ├── patterns/
│   ├── technologies/
│   └── registry.yaml
├── repository/
├── work-items/
├── archive/
├── audit/
└── state/
```

Do not replace an existing canonical structure without inspection.

Knowledge should be reusable across work items.

### STOP.

---

# 20. STEP 20 — KNOWLEDGE CAPTURE

Support:

```text
DevWeave-knowledge capture
```

or the repository's existing equivalent.

Support product/domain/technical knowledge capture.

Promotion should be explicit and auditable.

The PR phase may suggest:

```text
New reusable knowledge detected.

Promote to:
product/domain/technology knowledge?
```

Do not silently change long-lived knowledge.

### STOP.

---

# 21. STEP 21 — PROJECT-MANAGEMENT MCP

Support a generic project-management adapter.

During initialization, optionally configure:

```text
provider
authentication
capabilities
```

Example:

```yaml
projectManagement:
  enabled: true
  provider:
    name: jira
    adapter: mcp
  capabilities:
    readWorkItems: true
    createWorkItems: true
    updateWorkItems: true
    addComments: true
    attachEvidence: true
    transitionStatus: true
```

The provider must be replaceable.

Manual work-item input remains supported.

### STOP.

---

# 22. STEP 22 — DATABASE WORKFLOW

Support DB work through adapters/capabilities.

Flow:

```text
CONTEXT
→ detect DB impact
→ ANALYZE
→ inspect relevant schema
→ PLAN
→ human approval
→ BRANCH
→ IMPLEMENT
→ test
→ PR verification
```

Enforce:

- environment policy
- least privilege
- credential protection
- audit
- migration/versioning
- production restrictions
- destructive-operation approval

### STOP.

---

# 23. STEP 23 — SECURITY/GOVERNANCE

Retain:

- secret protection
- permission boundaries
- tool allowlists
- destructive-command restrictions
- production DB restrictions
- MCP trust
- hooks trust
- network restrictions
- audit
- high-impact approval

High-impact actions include:

- production DB mutation
- destructive migration
- production deployment
- credential changes
- repository deletion
- mass file deletion
- external-system mutation

### STOP.

---

# 24. STEP 24 — FIX LANE

Adopt the useful MMGI fix-lane idea, but make it generic.

For difficult bugs, internal handling may be:

```text
TRIAGE
→ DIAGNOSE
→ LAND
```

These are internal bug activities inside the six user-facing phases.

The user still sees:

```text
CONTEXT
→ ANALYZE
→ PLAN
→ BRANCH
→ IMPLEMENT
→ PR
```

Bug analysis may include:

- evidence ledger
- hypotheses
- runtime evidence
- reproduction sequence
- affected environment
- root cause
- minimal change
- regression sweep
- multiple findings/dispositions

Do not create a second public lifecycle.

### STOP.

---

# 25. STEP 25 — RESUME

Every phase checks durable state.

If an existing work item exists:

```text
✓ CONTEXT
✓ ANALYZE
✓ PLAN
○ BRANCH
○ IMPLEMENT
○ PR
```

Do not regenerate completed work.

Show:

```text
Current phase:
PLAN

Suggested next:
BRANCH
```

Wait for user.

### STOP.

---

# 26. STEP 26 — HANDOFF

Support:

```text
DevWeave-handoff <ID>
```

Generate:

```text
handoff.md
```

Include:

- current phase
- decisions
- artifacts
- implementation status
- tests
- known issues
- PR
- remaining work
- next action

### STOP.

---

# 27. STEP 27 — ARCHIVE

Support:

```text
DevWeave-archive <ID>
```

After merge:

```text
work-items/<ID>
      ↓
archive/<ID>
```

Preserve audit history.

### STOP.

---

# 28. STEP 28 — EXPRESS

Support optional:

```text
DevWeave-express <IDs>
```

For batch processing.

However:

- explicit human confirmation is required
- bypasses must be logged
- high-risk work should be restricted
- batch failures should isolate individual work items
- final report must show completed/failed/skipped items

Do not make Express the default.

### STOP.

---

# 29. STEP 29 — DOMAIN-DRIVEN POLICY

Adopt MMGI's domain-driven behavior.

Avoid global flags such as:

```yaml
enableSecurity: true
enableCompliance: true
```

Instead use domain metadata.

Example:

```yaml
type: domain
name: payments
criticality: tier-1
security: high
compliance:
  - PCI
technology:
  - payment-api
owners:
  - team: payments
```

The affected domain influences:

- analysis
- plan
- implementation
- tests
- verification
- review
- security checks
- reviewer suggestions

### STOP.

---

# 30. STEP 30 — MODEL/CAPABILITY ROUTING

Do not hard-code model vendor names.

Use:

```text
FAST_CONTEXT
DEEP_ANALYSIS
DEEP_PLANNING
DETERMINISTIC_EXECUTION
CODE_EXECUTION
INDEPENDENT_REVIEW
```

Example conceptual mapping:

```text
CONTEXT    → FAST_CONTEXT
ANALYZE    → DEEP_ANALYSIS
PLAN       → DEEP_PLANNING
BRANCH     → DETERMINISTIC_EXECUTION
IMPLEMENT  → CODE_EXECUTION
PR         → INDEPENDENT_REVIEW
```

Antigravity maps these to available models.

### STOP.

---

# 31. STEP 31 — TOKEN/COST OPTIMIZATION

Adopt the MMGI principle that expensive reasoning should be concentrated where needed.

Core loop:

```text
Discover once
↓
Persist knowledge
↓
Reuse knowledge
↓
Focused context
↓
Minimum required Skills
↓
Appropriate capability/model
↓
Execute
↓
Persist result
```

Do not repeatedly load:

- entire repository
- entire work item
- unrelated domain documents
- unrelated Skills

Measure where possible:

- context size
- token usage
- model calls
- duration
- rework
- human interventions

### STOP.

---

# 32. STEP 32 — AUDIT

Every phase records:

```text
phase started
phase completed
phase failed
phase stopped
artifact created
artifact changed
human decision requested
human decision received
tool invoked
MCP invoked
DB accessed
test executed
verification completed
review finding created
review finding resolved
technology refresh performed
knowledge invalidated
knowledge refreshed
```

Human decision must contain:

```text
actor
timestamp
decision
comment
```

### STOP.

---

# 33. STEP 33 — PHASE METRICS

Add phase metrics similar to MMGI.

Record:

- phase
- start
- end
- duration
- outcome
- work-item type
- effort
- capability/model if available
- token estimate if available
- files changed
- tests
- human interventions
- retries
- rework

Do not fabricate unavailable measurements.

### STOP.

---

# 34. STEP 34 — CONFORMANCE

Add/update conformance scenarios for:

1. init
2. context
3. analyze
4. plan
5. branch
6. implement
7. PR
8. HITL
9. explicit phase stop
10. wrong phase
11. resume
12. handoff
13. archive
14. express
15. bug
16. feature
17. modernization
18. fix lane
19. knowledge reuse
20. technology detection
21. technology version change
22. `NEEDS_REVALIDATION`
23. targeted knowledge refresh
24. version-specific practice refresh
25. project-management MCP
26. database
27. security
28. traceability
29. audit
30. metrics
31. token/context reuse
32. multi-service/polyglot repository

### Critical technology-refresh conformance

Create a fixture where:

```text
Initial:
.NET Core 3.0

Change:
.NET 10
```

Assert:

```text
technology change detected
affected knowledge identified
affected files marked NEEDS_REVALIDATION
version-specific guidance refreshed
unaffected knowledge unchanged
skills recreated only when actually version-sensitive
audit event recorded
```

### STOP.

---

# 35. STEP 35 — ANTIGRAVITY SKILL IMPLEMENTATION

Map:

```text
DevWeave init
        ↓
devweave-init

DevWeave-context
        ↓
devweave-context

DevWeave-analyze
        ↓
devweave-analyze

DevWeave-plan
        ↓
devweave-plan

DevWeave-branch
        ↓
devweave-branch

DevWeave-implement
        ↓
devweave-implement

DevWeave-pr
        ↓
devweave-pr
```

Each Skill must:

- validate prerequisites
- execute only one phase
- load minimum context
- persist artifact
- persist state
- perform HITL
- suggest next phase
- stop

Do not let a Skill invoke the next lifecycle Skill.

### STOP.

---

# 36. STEP 36 — DOCUMENTATION

Update existing canonical documents.

At minimum cover:

```text
What is DevWeave
Installation
Init
Six-phase workflow
Human-in-the-loop
Explicit phase advancement
State/resume
Knowledge
Technology detection
Technology version refresh
Modernization
Bug workflow
Feature workflow
Fix workflow
MCP
Database
Security
Audit
Metrics
Traceability
Handoff
Archive
Express
Antigravity adapter
Conformance
Troubleshooting
Examples
```

Do not create duplicate documents where an existing document should be updated.

### STOP.

---

# 37. STEP 37 — DOCUMENTATION COMPLETENESS MATRIX

Create/update a capability matrix:

| Capability | Spec | Design | Code | Conformance | User Docs | Status |
|---|---|---|---|---|---|---|
| Init | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Context | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Analyze | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Plan | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Branch | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Implement | ✓ | ✓ | ✓ | ✓ | ✓ | |
| PR | ✓ | ✓ | ✓ | ✓ | ✓ | |
| HITL | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Modernization | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Technology refresh | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Knowledge | ✓ | ✓ | ✓ | ✓ | ✓ | |
| MCP | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Database | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Security | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Audit | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Metrics | ✓ | ✓ | ✓ | ✓ | ✓ | |

### STOP.

---

# 38. STEP 38 — CONSISTENCY SCAN

Search for contradictory lifecycle references.

Search:

```text
DevWeave-requirements
DevWeave-solution
DevWeave-approve
DevWeave-test
DevWeave-verify
DevWeave-review
```

These may remain internally, but they must not be documented as the primary user workflow.

Search for:

```text
automatic next phase
auto advance
auto approve
```

Remove contradictions.

Search for hard-coded:

```text
JIRA
Claude
Antigravity
.NET
Angular
Azure
```

inside core specification.

Move those into adapters/examples where appropriate.

### STOP.

---

# 39. STEP 39 — END-TO-END VALIDATION

Perform an actual work-item test:

```text
DevWeave init

DevWeave-context TEST-001
→ STOP

DevWeave-analyze TEST-001
→ STOP

DevWeave-plan TEST-001
→ STOP

DevWeave-branch TEST-001
→ STOP

DevWeave-implement TEST-001
→ STOP

DevWeave-pr TEST-001
→ STOP
```

At every phase confirm:

```text
✓ requested phase executed
✓ no later phase executed
✓ artifact created
✓ state updated
✓ human checkpoint shown
✓ human decision persisted
✓ next phase suggested
✓ execution stopped
```

### STOP.

---

# 40. STEP 40 — MODERNIZATION VERSION-CHANGE TEST

Perform a dedicated test of the new capability that goes beyond MMGI.

Example repository:

```text
Before:
.NET Core 3.0
```

Change target:

```text
.NET 10
```

Expected:

```text
CONTEXT
  ↓
Technology change detected
  ↓
Affected knowledge identified
  ↓
Affected files/rules/practices marked
NEEDS_REVALIDATION
  ↓
ANALYZE
  ↓
Version-specific knowledge refreshed
  ↓
PLAN
  ↓
Migration plan
```

The system must show the user:

```text
Technology change detected.

Current:
.NET Core 3.0

Target:
.NET 10

Affected knowledge:
5 items

Affected practices:
8 items

Refresh required before modernization analysis.

Proceed with targeted knowledge refresh?
```

Human approves.

Then refresh only affected material.

This is a key DevWeave differentiator.

### STOP.

---

# 41. STEP 41 — FINAL REPORT

Antigravity must report:

```text
Files inspected
Files created
Files modified

Specification changes
Architecture changes
Skill changes
State changes
HITL changes
Knowledge changes
Technology refresh changes
Modernization changes
MCP changes
Database changes
Security changes
Audit changes
Metrics changes
Conformance changes
Documentation changes

Tests executed
Validation results
Known gaps
Remaining implementation work
```

Do not claim a capability is implemented unless verified.

---

# FINAL DEVWEAVE EXPERIENCE

The target developer experience is:

```text
Developer:
DevWeave-context US-123

DevWeave:
CONTEXT COMPLETE

✓ Work item loaded
✓ Repository context loaded
✓ Relevant knowledge loaded
✓ Technology detected

Human decision required.

[Approve]
[Request Changes]
[Add Information]
[Stop]

Developer:
Approve

DevWeave:
Context approved.

Suggested next phase:
ANALYZE

Run:
DevWeave-analyze US-123

DevWeave is waiting for your instruction.
```

Then:

```text
DevWeave-analyze US-123
```

and the same pattern continues.

The final lifecycle is:

```text
              ┌──────────────┐
              │   CONTEXT    │
              └──────┬───────┘
                     ↓
              HUMAN CHECKPOINT
                     ↓
                   STOP
                     ↓
              ┌──────────────┐
              │   ANALYZE    │
              └──────┬───────┘
                     ↓
              HUMAN CHECKPOINT
                     ↓
                   STOP
                     ↓
              ┌──────────────┐
              │     PLAN     │
              └──────┬───────┘
                     ↓
              HUMAN CHECKPOINT
                     ↓
                   STOP
                     ↓
              ┌──────────────┐
              │    BRANCH    │
              └──────┬───────┘
                     ↓
              HUMAN APPROVAL
                     ↓
                   STOP
                     ↓
              ┌──────────────┐
              │  IMPLEMENT   │
              └──────┬───────┘
                     ↓
              HUMAN CHECKPOINT
                     ↓
                   STOP
                     ↓
              ┌──────────────┐
              │      PR      │
              └──────┬───────┘
                     ↓
              HUMAN APPROVAL
                     ↓
                   STOP
```

## Core DevWeave principle

> **AI performs the work. Human controls advancement. DevWeave preserves the state, knowledge, evidence and decisions.**

And the additional DevWeave differentiator:

> **When repository technology changes, DevWeave detects the change, identifies stale dependent knowledge and version-sensitive guidance, refreshes only what is affected, validates the refreshed material, and records the change before modernization work continues.**
