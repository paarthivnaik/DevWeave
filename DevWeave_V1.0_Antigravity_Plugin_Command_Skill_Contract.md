# DevWeave V1.0 — Antigravity Plugin Command & Skill Contract

## 1. Purpose

This document defines the official V1.0 developer command surface for DevWeave and its mapping to Antigravity skills.

The objective is to provide a simple developer experience while keeping the AI-DLC lifecycle, state management, artifacts, approvals, knowledge, and host integration deterministic.

DevWeave remains host-neutral at the methodology/specification level.

Antigravity is the first host adapter.

```text
DevWeave AI-DLC Specification
            │
            ▼
   Antigravity Host Adapter
            │
      Skills / Agents
            │
            ▼
       Developer CLI
            │
            ▼
        Repository
```

---

# 2. Official V1.0 command surface

| Command | Antigravity Skill | AI-DLC Phase | Purpose | Primary Artifact |
|---|---|---|---|---|
| `DevWeave init` | `devweave-init` | INIT | Autonomous repository onboarding | `.devweave/repository/*` |
| `DevWeave-context <ID>` | `devweave-discovery` | DISCOVERY | Retrieve/ingest work item and build focused context | `.devweave/work-items/<ID>/context.md` |
| `DevWeave-requirements <ID>` | `devweave-requirements` | REQUIREMENTS | Normalize requirements and acceptance criteria | `requirements.md` |
| `DevWeave-solution <ID>` | `devweave-solution` | SOLUTION | Architectural design and trade-offs | `solution.md` |
| `DevWeave-approve <ID>` | `devweave-approval` | APPROVAL | Authorize progression past approval gate | `approval.json` |
| `DevWeave-plan <ID>` | `devweave-plan` | PLAN | Decompose approved solution into atomic tasks | `plan.md` |
| `DevWeave-implement <ID>` | `devweave-implement` | IMPLEMENT | Execute the approved plan | Modified source files |
| `DevWeave-test <ID>` | `devweave-test` | TEST | Run tests and capture evidence | `test-results.json` |
| `DevWeave-verify <ID>` | `devweave-verify` | VERIFY | Independently validate requirements and build integrity | `verification.md` |
| `DevWeave-review <ID>` | `devweave-review` | REVIEW | Perform multi-perspective code review | `review.md` |
| `DevWeave-pr <ID>` | `devweave-pr` | PR READY | Assemble PR package and final evidence | `pr-description.md` |
| `DevWeave-status <ID>` | — | Cross-phase | Inspect current state and open gates | `current.json` |
| `DevWeave-knowledge capture` | `devweave-knowledge` | Cross-phase | Capture reusable domain rules and conventions | `.devweave/knowledge/*` |

### Command rule

All work-item-specific commands MUST receive the work-item ID explicitly:

```bash
DevWeave-context <ID>
DevWeave-requirements <ID>
DevWeave-solution <ID>
DevWeave-approve <ID>
DevWeave-plan <ID>
DevWeave-implement <ID>
DevWeave-test <ID>
DevWeave-verify <ID>
DevWeave-review <ID>
DevWeave-pr <ID>
DevWeave-status <ID>
```

This prevents accidental execution against the wrong work item.

---

# 3. Complete lifecycle

The normal feature/user-story lifecycle is:

```text
DevWeave init
      │
      ▼
DevWeave-context <ID>
      │
      ▼
DevWeave-requirements <ID>
      │
      ▼
DevWeave-solution <ID>
      │
      ▼
DevWeave-approve <ID>
      │
      ▼
DevWeave-plan <ID>
      │
      ▼
DevWeave-implement <ID>
      │
      ▼
DevWeave-test <ID>
      │
      ▼
DevWeave-verify <ID>
      │
      ▼
DevWeave-review <ID>
      │
      ▼
DevWeave-pr <ID>
```

The developer can inspect progress at any time:

```bash
DevWeave-status <ID>
```

---

# 4. INIT — `DevWeave init`

## Purpose

Initialize DevWeave in a repository.

Command:

```bash
DevWeave init
```

The command should perform autonomous repository onboarding.

## Discovery areas

At minimum:

- Repository structure
- Programming languages
- Frameworks
- Versions
- Libraries
- Build tools
- Test frameworks
- Database technology
- APIs
- Infrastructure
- CI/CD
- Security configuration
- Repository conventions
- Existing documentation
- Existing AI/DLC configuration
- Available MCP capabilities

## Technology detection

Detection must be evidence-based.

DevWeave must not claim a technology exists unless repository evidence supports the detection.

Examples:

```text
C#
.NET
ASP.NET Core
EF Core
xUnit
```

or:

```text
Angular
TypeScript
RxJS
```

or:

```text
Java
Spring Boot
Maven
JUnit
```

## Outputs

```text
.devweave/
└── repository/
    ├── profile.md
    ├── architecture.md
    ├── technologies.md
    ├── dependencies.md
    ├── build.md
    ├── testing.md
    ├── database.md
    ├── deployment.md
    └── security.md
```

Only relevant artifacts need to be created.

---

# 5. Project-management MCP setup

During initialization DevWeave should determine whether an external project-management system is available through MCP.

Example:

```text
Project Management Integration

Do you use a project-management tool through MCP?

1. Jira
2. Azure DevOps
3. GitHub
4. GitLab
5. Linear
6. Other MCP provider
7. No
```

If a provider is selected, DevWeave should inspect the available capabilities and configure authentication as required.

Potential capabilities:

```yaml
projectManagement:
  readWorkItems: true
  createWorkItems: true
  updateWorkItems: true
  addComments: true
  attachEvidence: true
  transitionStatus: true
```

Capabilities must be detected rather than assumed.

---

# 6. Credentials and PAT

If the selected MCP provider requires a Personal Access Token:

```text
Authentication method:

1. PAT
2. OAuth
3. MCP-managed authentication
```

PATs must never be written to:

```text
.devweave/
Git
state.md
context.md
audit.md
logs
prompts
```

Artifacts may contain only a secure credential reference:

```yaml
authentication:
  type: pat
  credentialReference: jira-default
```

The host/MCP credential mechanism owns the actual secret.

---

# 7. `DevWeave-context <ID>`

## Purpose

Start work on an external or manually supplied work item.

Example:

```bash
DevWeave-context PROJ-123
```

The command must:

1. Check existing work-item state.
2. Detect project-management capability.
3. Retrieve the work item through MCP when configured.
4. Fall back to manual input when MCP is unavailable.
5. Normalize the work item.
6. Load relevant repository knowledge.
7. Build focused context.
8. Create/update `context.md`.
9. Update `state.md`.

## MCP path

```text
DevWeave-context PROJ-123
        │
        ▼
Check MCP
        │
        ▼
Retrieve Work Item
        │
        ▼
Normalize
        │
        ▼
Load Knowledge
        │
        ▼
Focused Context
```

## No-MCP path

```text
DevWeave-context PROJ-123

No project-management MCP is configured.

Please paste the requirements.

Include:
- Title
- Description
- Acceptance criteria
- Business rules
- Technical notes
- Dependencies
- Relevant comments
- Relevant links
```

Manual input must become the same generic Work Item model as MCP input.

---

# 8. Work-item contract

The DevWeave core must use a provider-neutral model.

Example:

```yaml
workItem:
  id: PROJ-123
  type: USER_STORY
  title: Add customer notification preferences

  description: |
    ...

  acceptanceCriteria:
    - ...
    - ...

  dependencies:
    - PROJ-120

  source:
    provider: jira
    externalId: PROJ-123
    retrievedAt: "2026-09-22T12:00:00Z"
```

Supported common types:

```text
EPIC
USER_STORY
BUG
TASK
SUBTASK
```

Provider-specific types can be preserved as metadata.

---

# 9. `state.md` is mandatory

Every active work item must have durable workflow state.

Recommended structure:

```text
.devweave/
└── work-items/
    └── PROJ-123/
        ├── state.md
        ├── context.md
        ├── requirements.md
        ├── solution.md
        ├── approval.json
        ├── plan.md
        ├── test-results.json
        ├── verification.md
        ├── review.md
        ├── pr-description.md
        └── audit.md
```

Example:

```yaml
workItemId: PROJ-123
type: USER_STORY

currentPhase: PLAN

phases:
  INIT: COMPLETED
  DISCOVERY: COMPLETED
  REQUIREMENTS: COMPLETED
  SOLUTION: COMPLETED
  APPROVAL: COMPLETED
  PLAN: IN_PROGRESS
  IMPLEMENT: PENDING
  TEST: PENDING
  VERIFY: PENDING
  REVIEW: PENDING
  PR_READY: PENDING
```

Every phase must read the current state before executing.

Every phase must update state after completion, failure, or interruption.

---

# 10. DISCOVERY — `DevWeave-context`

The discovery skill should investigate the repository based on the work item.

It should identify:

- Relevant components
- Relevant files
- Existing patterns
- Dependencies
- Architecture impact
- API impact
- Database impact
- Security impact
- Tests
- Technology-specific practices
- Relevant knowledge

Discovery should be progressive.

It must not unnecessarily load the entire repository into model context.

---

# 11. REQUIREMENTS — `DevWeave-requirements`

Command:

```bash
DevWeave-requirements PROJ-123
```

The skill converts the discovered work item into explicit requirements.

Typical output:

```text
requirements.md
```

Requirements should contain:

- Requirement IDs
- Description
- Scope
- Out of scope
- Assumptions
- Questions
- Acceptance criteria
- Dependencies
- Affected domains

The original external work item remains the source reference.

---

# 12. SOLUTION — `DevWeave-solution`

Command:

```bash
DevWeave-solution PROJ-123
```

The solution skill determines how the requirement should be implemented.

Structure:

```text
Current State
      ↓
Constraints
      ↓
Options
      ↓
Trade-offs
      ↓
Selected Solution
      ↓
Risks
```

Output:

```text
solution.md
```

The solution must respect:

- Repository conventions
- Detected technology
- Approved knowledge
- Security requirements
- Database constraints
- Existing architecture
- Work-item scope

---

# 13. APPROVAL — `DevWeave-approve`

Command:

```bash
DevWeave-approve PROJ-123
```

Approval is a human governance gate.

Example:

```text
Solution ready.

Approve progression to PLAN?

1. Approve
2. Reject
3. Request changes
```

Output:

```text
approval.json
```

Example:

```json
{
  "workItemId": "PROJ-123",
  "decision": "APPROVED",
  "approvedBy": "developer",
  "timestamp": "2026-09-22T12:00:00Z"
}
```

The exact identity mechanism is host-dependent.

---

# 14. PLAN — `DevWeave-plan`

Command:

```bash
DevWeave-plan PROJ-123
```

The plan converts the approved solution into atomic implementation tasks.

Each task should identify:

- Task ID
- Description
- Affected files/components
- Dependencies
- Implementation intent
- Acceptance checks
- Tests
- Risk

Output:

```text
plan.md
```

The plan is the implementation contract.

Implementation should not silently redesign the approved solution.

---

# 15. IMPLEMENT — `DevWeave-implement`

Command:

```bash
DevWeave-implement PROJ-123
```

Implementation should:

1. Read `state.md`.
2. Load approved solution.
3. Load `plan.md`.
4. Build focused implementation context.
5. Execute plan tasks.
6. Run required deterministic checks.
7. Update artifacts.
8. Update state.

If a major contradiction is discovered:

```text
IMPLEMENT
    ↓
Material contradiction
    ↓
Return to appropriate phase
    ↓
Update solution/plan
    ↓
Approval if required
    ↓
Resume implementation
```

Do not allow silent architectural drift.

---

# 16. TEST — `DevWeave-test`

Command:

```bash
DevWeave-test PROJ-123
```

The test skill should discover and use the repository's native test mechanisms.

Potential tests:

- Unit tests
- Integration tests
- API tests
- Database tests
- Regression tests
- Build validation

Output:

```text
test-results.json
```

Example:

```json
{
  "workItemId": "PROJ-123",
  "status": "PASSED",
  "testsRun": 125,
  "testsPassed": 125,
  "testsFailed": 0
}
```

The actual schema should be defined by the DevWeave contract.

---

# 17. VERIFY — `DevWeave-verify`

Command:

```bash
DevWeave-verify PROJ-123
```

Verification is independent from implementation.

It should validate:

```text
Requirements
Acceptance criteria
Approved solution
Implementation
Tests
Regression risk
Architecture
Security
Database/API safety
Unintended changes
```

Output:

```text
verification.md
```

Verification must contain evidence.

Avoid conclusions such as:

```text
Looks good.
```

without supporting evidence.

---

# 18. REVIEW — `DevWeave-review`

Command:

```bash
DevWeave-review PROJ-123
```

Review should use multiple perspectives when applicable.

### Correctness

- Requirements
- Business logic
- Architecture
- Regression
- Maintainability

### Security

- Authorization
- Data exposure
- Secrets
- Injection
- Dependencies
- Trust boundaries

### Performance

- Database queries
- N+1 risks
- Resource usage
- Concurrency
- Unnecessary processing

Optional specialist reviews:

```text
Database
API compatibility
Cloud
Security
Compliance
Performance
```

Output:

```text
review.md
```

Findings should have:

- Finding ID
- Severity
- Category
- Evidence
- Status
- Resolution
- Verification status

---

# 19. PR READY — `DevWeave-pr`

Command:

```bash
DevWeave-pr PROJ-123
```

This is the final lifecycle phase.

It should validate:

```text
State
Requirements
Solution
Plan
Implementation
Tests
Verification
Review
Traceability
```

Then assemble:

```text
pr-description.md
```

The PR package may include:

- Summary
- Requirements
- Implementation
- Tests
- Verification
- Review status
- Risks
- Database changes
- Migration notes
- Work-item reference

If the configured MCP supports work-item updates, DevWeave may also update the external work item.

---

# 20. STATUS — `DevWeave-status`

Command:

```bash
DevWeave-status PROJ-123
```

This command must be read-only.

Example:

```text
DevWeave Status
────────────────────────────

Work Item: PROJ-123
Type: USER_STORY

INIT           ✓
DISCOVERY      ✓
REQUIREMENTS   ✓
SOLUTION       ✓
APPROVAL       ✓
PLAN           ✓
IMPLEMENT      → IN PROGRESS
TEST           ○
VERIFY         ○
REVIEW         ○
PR READY       ○

Open gates:
- Implementation incomplete

Last activity:
2026-09-22 17:42

Context:
Loaded

MCP:
Available
```

Output:

```text
current.json
```

---

# 21. KNOWLEDGE — `DevWeave-knowledge capture`

Command:

```bash
DevWeave-knowledge capture
```

Purpose:

Capture reusable knowledge discovered during engineering work.

Examples:

```text
Repository patterns
Domain rules
Architecture conventions
Technology practices
Database conventions
API conventions
Security rules
Known constraints
```

Potential output:

```text
.devweave/knowledge/
├── repository/
├── domain/
├── technical/
└── practices/
```

Knowledge should be evidence-based.

Do not promote unverified assumptions as approved knowledge.

---

# 22. Phase state transitions

The normal state progression is:

```text
INIT
 ↓
DISCOVERY
 ↓
REQUIREMENTS
 ↓
SOLUTION
 ↓
APPROVAL
 ↓
PLAN
 ↓
IMPLEMENT
 ↓
TEST
 ↓
VERIFY
 ↓
REVIEW
 ↓
PR_READY
```

Possible recovery transitions:

```text
SOLUTION
   ↓
APPROVAL_REJECTED
   ↓
SOLUTION

IMPLEMENT
   ↓
PLAN_CONFLICT
   ↓
PLAN / SOLUTION

TEST
   ↓
FAILED
   ↓
IMPLEMENT

VERIFY
   ↓
FAILED
   ↓
IMPLEMENT / TEST

REVIEW
   ↓
FINDINGS
   ↓
IMPLEMENT
   ↓
TEST
   ↓
VERIFY
   ↓
REVIEW
```

The state machine must prevent invalid jumps.

---

# 23. Resume behavior

Every command should inspect existing state.

Example:

```text
DevWeave-implement PROJ-123

Existing work item found.

State:
PLAN = COMPLETED
IMPLEMENT = IN_PROGRESS

Loading existing implementation context...

Resuming implementation.
```

DevWeave should not regenerate completed phases unless they have been invalidated.

---

# 24. Requirement-change invalidation

If an external work item changes materially:

```text
DevWeave-context --refresh PROJ-123
```

DevWeave compares the existing context with the refreshed work item.

Example:

```text
Changes detected:

✓ Description changed
✓ Acceptance criterion added
✓ Dependency added

Affected phases:

REQUIREMENTS
SOLUTION
PLAN
IMPLEMENT
VERIFY
REVIEW
```

Affected downstream artifacts should be marked stale/revalidation-required according to the DevWeave state contract.

---

# 25. MCP failure handling

If MCP fails after context was captured:

```text
MCP unavailable.

Existing context is available:

.devweave/work-items/PROJ-123/context.md

Continuing with captured context.
```

If the work item has never been retrieved:

```text
Unable to retrieve PROJ-123.

Options:

1. Retry MCP
2. Paste requirements
3. Cancel
```

DevWeave must never invent external work-item information.

---

# 26. Database capability

Database operations are capabilities, not assumptions.

```text
DevWeave
    ↓
Database capability
    ↓
Host/MCP database adapter
    ↓
Authorized database
```

Before database mutation, DevWeave should determine:

- Target environment
- Authorization
- Schema impact
- Migration mechanism
- Rollback strategy
- Test strategy

Production mutation should be blocked by default.

---

# 27. Technology-aware best practices

DevWeave should detect the technology and apply relevant practices.

Example:

```text
Repository
    ↓
Detect .NET + EF Core
    ↓
Load applicable practices
    ↓
Discovery
    ↓
Solution
    ↓
Implementation
    ↓
Verification
    ↓
Review
```

Practices should be classified as appropriate:

```text
MANDATORY
RECOMMENDED
ADVISORY
ANTI_PATTERN
```

Priority should follow configured governance, for example:

```text
Security / Compliance
        ↓
Organization Policy
        ↓
Repository Convention
        ↓
Official Technology Guidance
        ↓
DevWeave Recommendation
```

---

# 28. Token-efficiency behavior

Every skill should prefer existing artifacts and focused context.

Do not repeatedly:

- rediscover repository structure
- retrieve the entire work item
- reload unrelated knowledge
- send the entire repository to the model
- repeat completed reasoning

Preferred:

```text
Discover Once
     ↓
Persist Knowledge
     ↓
Reuse Knowledge
     ↓
Build Focused Context
     ↓
Execute
```

Measure where possible:

- Model calls
- Estimated token usage
- Context size
- MCP calls
- Execution time
- Rework
- Human interventions

---

# 29. Plugin skill contract

Each Antigravity skill should have a clear contract.

Example:

```text
Skill: devweave-plan

Inputs:
- Work Item ID
- state.md
- requirements.md
- solution.md
- repository knowledge

Preconditions:
- REQUIREMENTS completed
- SOLUTION completed
- APPROVAL granted

Actions:
- Analyze approved solution
- Decompose into atomic tasks
- Identify tests
- Identify risks
- Produce plan.md

Outputs:
- plan.md
- updated state.md
- audit event

Failure:
- Do not mark PLAN completed
- Record failure
- Explain required recovery
```

Every skill should follow the same pattern.

---

# 30. Recommended Antigravity plugin structure

The host adapter should contain the skills, rules and agents required by the commands.

Conceptually:

```text
devweave-antigravity/
│
├── skills/
│   ├── devweave-init/
│   ├── devweave-discovery/
│   ├── devweave-requirements/
│   ├── devweave-solution/
│   ├── devweave-approval/
│   ├── devweave-plan/
│   ├── devweave-implement/
│   ├── devweave-test/
│   ├── devweave-verify/
│   ├── devweave-review/
│   └── devweave-knowledge/
│
├── agents/
│   ├── repository-analyst.md
│   ├── requirements-analyst.md
│   ├── architect.md
│   ├── developer.md
│   ├── tester.md
│   ├── verifier.md
│   └── reviewer.md
│
├── rules/
│   └── devweave.md
│
├── templates/
│   ├── state.md
│   ├── context.md
│   ├── requirements.md
│   ├── solution.md
│   ├── approval.json
│   ├── plan.md
│   ├── test-results.json
│   ├── verification.md
│   ├── review.md
│   ├── pr-description.md
│   └── audit.md
│
└── README.md
```

The exact Antigravity packaging/manifest layout must follow the current host contract. The AI-DLC schemas and lifecycle must remain outside the host-specific implementation.

---

# 31. Skill naming convention

Use:

```text
devweave-<phase>
```

Examples:

```text
devweave-init
devweave-discovery
devweave-requirements
devweave-solution
devweave-approval
devweave-plan
devweave-implement
devweave-test
devweave-verify
devweave-review
devweave-knowledge
```

Avoid names such as:

```text
jira-devweave-plan
antigravity-devweave-plan
dotnet-devweave-plan
```

because those names couple the core workflow to a provider or technology.

---

# 32. First implementation target — Dating App Repository

The first real dogfooding target should be the user's dating application repository.

The test should start with:

```bash
DevWeave init
```

Then verify:

```text
✓ Repository discovery
✓ Technology detection
✓ Architecture discovery
✓ Test detection
✓ Database detection
✓ MCP detection
✓ Knowledge initialization
✓ Security initialization
```

Then choose a real User Story:

```bash
DevWeave-context <DatingApp-WorkItemId>
```

Complete the full lifecycle:

```text
Context
 ↓
Requirements
 ↓
Solution
 ↓
Approval
 ↓
Plan
 ↓
Implement
 ↓
Test
 ↓
Verify
 ↓
Review
 ↓
PR
```

This is the first real DevWeave V1.0 dogfooding test.

---

# 33. V1.0 plugin acceptance criteria

## Plugin

- [ ] Antigravity adapter exists.
- [ ] Skills are discoverable.
- [ ] Commands map to the correct skills.
- [ ] Rules are loaded.
- [ ] Agents are available where required.
- [ ] Templates are available.
- [ ] Plugin does not hard-code a programming language.
- [ ] Plugin does not hard-code Jira.
- [ ] Plugin does not hard-code a database.
- [ ] Plugin does not hard-code an AI model.

## Lifecycle

- [ ] INIT works.
- [ ] DISCOVERY works.
- [ ] REQUIREMENTS works.
- [ ] SOLUTION works.
- [ ] APPROVAL works.
- [ ] PLAN works.
- [ ] IMPLEMENT works.
- [ ] TEST works.
- [ ] VERIFY works.
- [ ] REVIEW works.
- [ ] PR READY works.

## State

- [ ] `state.md` is created.
- [ ] Every phase reads state.
- [ ] Every phase updates state.
- [ ] Interrupted sessions can resume.
- [ ] Invalid transitions are rejected.
- [ ] Material requirement changes invalidate affected downstream phases.

## MCP

- [ ] MCP provider can be configured.
- [ ] PAT can be configured securely where required.
- [ ] PAT is never stored in repository artifacts.
- [ ] Work items can be retrieved.
- [ ] Epic is supported.
- [ ] User Story is supported.
- [ ] Bug is supported.
- [ ] Task is supported.
- [ ] No-MCP manual fallback works.
- [ ] MCP failure recovery works.
- [ ] Capability negotiation works.

## Quality

- [ ] Technology detection works.
- [ ] Repository knowledge works.
- [ ] Knowledge reuse works.
- [ ] Database workflow works.
- [ ] Security boundaries work.
- [ ] Traceability works.
- [ ] Audit works.
- [ ] Token/cost measurements can be collected.

---

# 34. Recommended developer experience

A developer should ideally experience DevWeave like this:

```text
$ DevWeave init

✓ Repository analyzed
✓ Technology detected
✓ Knowledge initialized
✓ MCP configured
✓ DevWeave ready


$ DevWeave-context DATING-123

✓ Work item retrieved
✓ User Story identified
✓ Context created
✓ State initialized


$ DevWeave-requirements DATING-123

✓ Requirements normalized
✓ Acceptance criteria captured


$ DevWeave-solution DATING-123

✓ Solution proposed
✓ Risks identified


$ DevWeave-approve DATING-123

Approve solution? [Y/n]

✓ Approved


$ DevWeave-plan DATING-123

✓ Implementation plan created


$ DevWeave-implement DATING-123

✓ Implementation completed


$ DevWeave-test DATING-123

✓ Tests passed


$ DevWeave-verify DATING-123

✓ Requirements verified
✓ Build verified
✓ Regression checks completed


$ DevWeave-review DATING-123

✓ Correctness review completed
✓ Security review completed
✓ Performance review completed


$ DevWeave-pr DATING-123

✓ PR package ready
✓ Traceability complete
✓ Work item linked
```

---

# 35. Final design principle

The Antigravity plugin is **not DevWeave itself**.

It is the first host adapter.

```text
                    DEVWEAVE
                       │
             AI-DLC Specification
                       │
        ┌──────────────┼──────────────┐
        │              │              │
     Skills          Agents        Policies
        │              │              │
        └──────────────┼──────────────┘
                       │
                 Host Contract
                       │
             Antigravity Adapter
                       │
                       ▼
                Developer Repo
```

The same AI-DLC specification can later be mapped to another AI coding host without redesigning the methodology.

---

# 36. V1.0 implementation order

Implement the plugin in this order:

```text
1. Plugin skeleton
       ↓
2. Host registration / discovery
       ↓
3. DevWeave rules
       ↓
4. devweave-init
       ↓
5. state.md + state machine
       ↓
6. devweave-discovery
       ↓
7. devweave-requirements
       ↓
8. devweave-solution
       ↓
9. devweave-approval
       ↓
10. devweave-plan
       ↓
11. devweave-implement
       ↓
12. devweave-test
       ↓
13. devweave-verify
       ↓
14. devweave-review
       ↓
15. devweave-pr
       ↓
16. devweave-status
       ↓
17. devweave-knowledge
       ↓
18. MCP integration
       ↓
19. Dating-app dogfooding
       ↓
20. V1.0 conformance
```

Do not start with all 20 commands simultaneously.

Implement one command/skill, validate it, commit it, and then move to the next.

---

# 37. Definition of Done for the Antigravity plugin

The plugin is V1.0-ready when a developer can enter an unfamiliar repository and do:

```bash
DevWeave init
```

then:

```bash
DevWeave-context <WorkItemId>
```

and complete:

```text
DISCOVERY
→ REQUIREMENTS
→ SOLUTION
→ APPROVAL
→ PLAN
→ IMPLEMENT
→ TEST
→ VERIFY
→ REVIEW
→ PR READY
```

while DevWeave:

- maintains durable state
- reuses knowledge
- minimizes unnecessary context
- respects technology-specific practices
- respects security boundaries
- handles MCP or manual input
- preserves traceability
- records evidence
- resumes interrupted work
- does not expose credentials
- remains independent of any single project-management provider, technology, database, AI model, or host.

This is the V1.0 plugin contract.
