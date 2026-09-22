# DevWeave — User Guide

**AI-Native Software Development Lifecycle**

> **Less Tokens. More Work. Lower Bill.**

DevWeave helps developers take a software work item from requirements through implementation, testing, verification, review, and PR readiness using the AI-DLC methodology.

DevWeave is designed to be **generic**. It is not tied to Jira, Azure DevOps, GitHub, a particular programming language, database, cloud provider, AI model, or AI coding host.

---

# 1. What is DevWeave?

DevWeave is an AI-native engineering workflow built around the **AI-DLC lifecycle**.

It combines:

- Repository discovery
- Requirements understanding
- Technology detection
- Repository knowledge
- Best-practice adaptation
- Solution design
- Human approval
- Implementation planning
- Coding
- Testing
- Independent verification
- Code review
- Database capabilities
- MCP integrations
- Traceability
- Auditability
- Durable workflow state

The goal is not simply to ask an AI model to write code.

The goal is to give the AI a controlled engineering process.

---

# 2. The AI-DLC lifecycle

DevWeave follows this lifecycle:

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
PR READY
```

A failed phase does not mean the entire work item starts again.

DevWeave uses state and artifacts to determine where the work should continue.

For example:

```text
DISCOVERY       ✓
REQUIREMENTS    ✓
SOLUTION        ✓
APPROVAL        ✓
PLAN            ✓
IMPLEMENT       → interrupted
```

When the developer resumes the work, DevWeave loads the existing state and continues from the appropriate point.

---

# 3. How DevWeave works

At a high level:

```text
Work Item
    ↓
DevWeave Context
    ↓
Repository + Technology Discovery
    ↓
Requirements
    ↓
Solution
    ↓
Human Approval
    ↓
Implementation Plan
    ↓
Implementation
    ↓
Tests
    ↓
Independent Verification
    ↓
Review
    ↓
PR Ready
```

The work item can come from:

1. A project-management system through MCP
2. Manual/pasted requirements

Both paths become the same generic DevWeave Work Item.

---

# 4. First step — Initialize a repository

Run DevWeave in the repository:

```bash
DevWeave init
```

DevWeave first inspects the repository.

It should determine, based on repository evidence:

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
- Security-related configuration
- Repository conventions

DevWeave must not assume a technology that it cannot detect from evidence.

---

# 5. Technology detection

DevWeave is technology-neutral but technology-aware.

For example, it may detect:

```text
C#
.NET
ASP.NET Core
EF Core
xUnit
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

or:

```text
Python
FastAPI
pytest
```

The detected technology affects the relevant engineering practices.

For example:

```text
Detected technology
        ↓
Applicable practices
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

DevWeave should not apply unrelated technology practices to a project.

---

# 6. Repository knowledge

During initialization and later workflows, DevWeave builds reusable knowledge.

Typical knowledge includes:

```text
Architecture
Patterns
Conventions
Constraints
Domain information
Technical components
Build/test information
Security constraints
Database information
Deployment information
```

Knowledge is reusable.

This is important because DevWeave should not rediscover the same repository information for every work item.

---

# 7. Project-management integration through MCP

DevWeave can optionally connect to a project-management system through MCP.

Possible providers include:

- Jira
- Azure DevOps
- GitHub
- GitLab
- Linear
- Other MCP-compatible systems

The exact provider is not part of the AI-DLC core.

During initialization DevWeave should ask:

```text
Do you use a project-management tool through MCP?

1. Jira
2. Azure DevOps
3. GitHub
4. GitLab
5. Linear
6. Other MCP provider
7. No
```

If the user selects a provider, DevWeave configures the available MCP capabilities.

---

# 8. MCP authentication and PAT

Some MCP providers require a Personal Access Token (PAT).

For example:

```text
Authentication method:

1. Personal Access Token (PAT)
2. OAuth
3. MCP-managed authentication
```

If PAT is required, DevWeave asks the user to provide it through the secure credential mechanism.

### Never put the PAT in:

```text
.aidlc/
Git
Markdown artifacts
state.md
context.md
audit.md
Prompts
Logs
```

Artifacts should contain only a credential reference, for example:

```yaml
authentication:
  type: pat
  credentialReference: jira-default
```

The actual secret belongs in secure credential storage.

---

# 9. Starting work with `DevWeave-context`

The normal starting command is:

```bash
DevWeave-context <WorkItemId>
```

Examples:

```bash
DevWeave-context MMGI-1234
```

```bash
DevWeave-context PROJ-123
```

The ID itself is generic.

DevWeave uses the configured project-management adapter to determine how to retrieve it.

---

# 10. When MCP is configured

Example:

```text
DevWeave-context PROJ-123

Checking project-management integration...
✓ MCP configured

Retrieving work item...
✓ Work item found

Loading:
✓ Title
✓ Description
✓ Acceptance criteria
✓ Parent/Epic
✓ Dependencies
✓ Relevant information

Creating AI-DLC context...
✓ Context created
```

DevWeave then continues into the AI-DLC lifecycle.

---

# 11. When MCP is not configured

DevWeave must still work.

Example:

```text
DevWeave-context PROJ-123

No project-management MCP integration is configured.

DevWeave cannot retrieve PROJ-123 automatically.

Please copy and paste the work-item requirements.

Include where available:

- Title
- Description
- Acceptance criteria
- Business rules
- Technical notes
- Dependencies
- Relevant comments
- Relevant links

Paste the requirements:
>
```

The user pastes the requirements.

DevWeave converts them into the same generic Work Item structure used by MCP.

Therefore:

```text
MCP Work Item
      │
      ├──────────────┐
      │              │
      ▼              ▼
Generic Work Item  Generic Work Item
      │              │
      └──────┬───────┘
             ↓
        AI-DLC lifecycle
```

---

# 12. Work-item types

DevWeave should support common generic types:

- EPIC
- USER_STORY
- BUG
- TASK
- SUBTASK

Provider-specific types can be preserved as additional metadata.

The workflow can adapt based on the work-item type.

For example:

```text
BUG
 ↓
Evidence
 ↓
Diagnosis
 ↓
Minimal fix
 ↓
Regression testing
 ↓
Verification
```

Whereas:

```text
USER STORY
 ↓
Requirements
 ↓
Discovery
 ↓
Solution
 ↓
Plan
 ↓
Implementation
 ↓
Testing
 ↓
Verification
```

---

# 13. `state.md` — workflow state

Every active work item should have durable state.

Example:

```text
.aidlc/
└── work-items/
    └── PROJ-123/
        ├── state.md
        ├── context.md
        ├── requirements.md
        ├── solution.md
        ├── plan.md
        ├── verification.md
        └── audit.md
```

`state.md` is the workflow control record.

Example:

```yaml
workItemId: PROJ-123
type: USER_STORY

currentPhase: SOLUTION

phases:
  INIT: COMPLETED
  DISCOVERY: COMPLETED
  REQUIREMENTS: COMPLETED
  SOLUTION: IN_PROGRESS
  APPROVAL: PENDING
  PLAN: PENDING
  IMPLEMENT: PENDING
  TEST: PENDING
  VERIFY: PENDING
  REVIEW: PENDING
  PR_READY: PENDING
```

The detailed requirements, solution, plan, etc. belong in their respective artifacts.

---

# 14. Resume an interrupted work item

DevWeave should always inspect existing state before starting a phase.

For example:

```text
Developer A
    ↓
PROJ-123
    ↓
PLAN completed
    ↓
IMPLEMENT partially completed
    ↓
Session ends
```

Later:

```text
Developer B
    ↓
PROJ-123
    ↓
DevWeave reads state.md
    ↓
Existing artifacts loaded
    ↓
Resume from IMPLEMENT
```

DevWeave should not recreate completed artifacts unnecessarily.

---

# 15. Phase 1 — INIT

INIT prepares the repository and workflow.

Typical activities:

```text
Repository detection
Technology detection
Capability detection
MCP detection
Knowledge initialization
Workflow state initialization
```

Output includes repository knowledge and workflow state.

---

# 16. Phase 2 — DISCOVERY

Discovery determines what the work item affects.

DevWeave investigates:

- Relevant source code
- Architecture
- Dependencies
- Existing patterns
- Related components
- Existing tests
- Database impact
- API impact
- Security impact
- Technology-specific concerns

For a large repository, DevWeave should use focused discovery.

It should not send the entire repository to the model.

---

# 17. Phase 3 — REQUIREMENTS

DevWeave converts the work item into explicit requirements.

Typical information:

```text
Requirement ID
Title
Description
Scope
Out of scope
Assumptions
Questions
Acceptance criteria
Dependencies
Affected domains
```

Example:

```text
REQ-001
Add customer notification preferences

Acceptance Criteria:
1. User can enable notifications.
2. User can disable notifications.
3. Preferences are persisted.
4. Existing users remain compatible.
```

Requirements should remain traceable to the original work item.

---

# 18. Phase 4 — SOLUTION

DevWeave does not immediately start coding.

It first determines an appropriate solution.

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

This is where technology-aware best practices and repository conventions are applied.

---

# 19. Human approval

High-impact or configured decisions should require human approval.

For example:

```text
Solution ready.

Proposed:
- Modify CustomerPreferences service
- Add database migration
- Update API endpoint
- Add integration tests

Risks:
- Existing customer data migration
- API compatibility

Approve solution?

1. Approve
2. Reject
3. Request changes
```

Approval becomes part of the audit trail.

---

# 20. Phase 5 — PLAN

The plan converts the approved solution into implementation steps.

A plan should identify:

- Files/components
- Implementation steps
- Tests
- Database changes
- API changes
- Security considerations
- Risks
- Acceptance checks
- Rollback considerations

The plan should be sufficiently precise that the implementation phase does not need to redesign the solution.

---

# 21. Phase 6 — IMPLEMENT

Implementation executes the approved plan.

The implementation phase should:

```text
Read state
 ↓
Read approved solution
 ↓
Read plan
 ↓
Build focused context
 ↓
Implement
 ↓
Update state
 ↓
Record evidence
```

If a major contradiction is discovered, DevWeave should not silently redesign the work.

It should return to the appropriate phase.

---

# 22. Phase 7 — TEST

Testing is an explicit AI-DLC phase.

Depending on the repository and work item, DevWeave may run:

- Existing tests
- New unit tests
- Integration tests
- API tests
- Database tests
- Regression tests
- Build validation

Test evidence should be recorded.

---

# 23. Phase 8 — VERIFY

Verification is independent from implementation.

DevWeave should verify:

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

The verifier should produce evidence rather than simply saying:

```text
Looks good.
```

---

# 24. Phase 9 — REVIEW

Review is a separate quality activity.

Possible review perspectives:

### Correctness

- Requirements
- Business logic
- Regression
- Maintainability
- Architecture

### Security

- Authorization
- Secrets
- Injection
- Data exposure
- Dependency risks

### Performance

- Database queries
- N+1 patterns
- Unnecessary processing
- Concurrency
- Resource usage

Additional specialist reviews can be used when required.

---

# 25. Fix and re-verification loop

If verification or review finds an issue:

```text
Review
  ↓
Finding
  ↓
Fix
  ↓
Retest
  ↓
Reverify
  ↓
Review again
```

A failed review should not simply mark the work item complete.

---

# 26. Database changes

DevWeave can support database-related work.

The database capability is generic.

```text
DevWeave
    ↓
Database Capability
    ↓
Host/MCP Database Adapter
    ↓
Authorized Database
```

DevWeave should detect database impact.

For example:

```text
User Story
   ↓
Database impact detected
   ↓
Inspect relevant schema
   ↓
Design migration/change
   ↓
Approval if required
   ↓
Apply change
   ↓
Test
   ↓
Verify
```

Repository-native migration mechanisms should be preferred.

Production database mutation should be blocked by default unless explicitly governed.

---

# 27. MCP capabilities

MCP is a capability boundary.

Possible capabilities include:

```text
Read work items
Create work items
Update work items
Add comments
Attach evidence
Transition status
Git operations
Database access
CI/CD
Cloud services
Security tools
```

DevWeave must check what is actually supported.

For example:

```yaml
capabilities:
  readWorkItems: true
  updateWorkItems: false
```

DevWeave must not attempt an unsupported update.

---

# 28. External work-item updates

If supported by MCP, DevWeave may write back:

- AI-DLC status
- Plan summary
- Verification result
- Test evidence
- PR URL
- Review result

Example:

```text
DevWeave
   ↓
Verification completed
   ↓
MCP
   ↓
Update external work item
```

External write-back should be capability- and permission-driven.

---

# 29. Knowledge reuse

DevWeave builds durable knowledge.

Typical structure:

```text
.aidlc/
├── knowledge/
│   ├── repository/
│   ├── domain/
│   ├── technical/
│   ├── practices/
│   └── candidates/
├── work-items/
├── decisions/
├── verification/
├── audit/
└── state/
```

Knowledge may have statuses such as:

```text
OBSERVED
INFERRED
RECOMMENDED
APPROVED
DEPRECATED
```

Approved knowledge can be reused by future work items.

---

# 30. Token-efficiency model

DevWeave is designed around:

> **Less Tokens. More Work. Lower Bill.**

The workflow should therefore prefer:

```text
Discover Once
      ↓
Build Knowledge
      ↓
Reuse Knowledge
      ↓
Build Focused Context
      ↓
Select Required Skills/Agents
      ↓
Use Appropriate Model Capability
      ↓
Execute
      ↓
Test / Verify / Review
```

Avoid:

```text
Every phase
    ↓
Rediscover repository
    ↓
Reload everything
    ↓
Repeat same reasoning
```

Track where practical:

- Model calls
- Estimated tokens
- Context size
- Execution time
- Human interventions
- Rework
- Estimated AI cost

---

# 31. Model selection

DevWeave should describe model requirements using capabilities rather than vendor/model names.

Example:

```yaml
discovery:
  capability: fast-analysis

solution:
  capability: deep-reasoning

implementation:
  capability: coding

verification:
  capability: independent-reasoning

review:
  capability: independent-review
```

The host adapter maps these capabilities to actual models.

Therefore DevWeave does not require a specific AI provider.

---

# 32. Workflow profiles

Not every change requires the complete lifecycle.

DevWeave can select an appropriate workflow profile.

Examples:

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

For example:

### Express

```text
Context
 ↓
Implement
 ↓
Test
 ↓
Verify
```

### Feature

```text
Discovery
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
```

The profile must never bypass mandatory security or governance requirements.

---

# 33. Bug workflow

For a bug:

```text
BUG
 ↓
Context
 ↓
Evidence
 ↓
Diagnosis
 ↓
Root Cause
 ↓
Minimal Fix
 ↓
Test
 ↓
Regression Sweep
 ↓
Verify
 ↓
Review
```

The diagnosis should be evidence-based.

DevWeave should avoid changing code simply because a particular file looks suspicious.

---

# 34. Modernization workflow

Modernization work can use a specialized profile.

```text
Assessment
 ↓
Target Architecture
 ↓
Migration Strategy
 ↓
Migration Plan
 ↓
Incremental Implementation
 ↓
Testing
 ↓
Verification
 ↓
Review
```

Migration-specific artifacts can be added by the modernization profile.

The core AI-DLC lifecycle remains unchanged.

---

# 35. Security and governance

DevWeave must protect:

- Credentials
- PATs
- Secrets
- Production systems
- Sensitive data
- Destructive operations
- External-system mutations

High-impact actions may require human approval.

Examples:

```text
Production DB mutation
Production deployment
Credential changes
Repository deletion
Mass file deletion
Destructive migration
Bulk external-system updates
```

---

# 36. Traceability

A completed work item should be traceable:

```text
External Work Item
       ↓
REQ-001
       ↓
SOL-001
       ↓
ADR-001
       ↓
PLAN-001
       ↓
TASK-001
       ↓
CODE
       ↓
TEST-001
       ↓
VERIFICATION
       ↓
REVIEW
       ↓
PR
```

This allows a developer or reviewer to understand why a change exists and how it was validated.

---

# 37. Audit

DevWeave should record significant lifecycle events.

Examples:

```text
Run started
State changed
Artifact created
Artifact updated
Approval requested
Approval granted
Tool invoked
MCP accessed
Database accessed
Test executed
Verification completed
Review finding created
Review finding resolved
Run completed
```

Secrets must never be included in the audit trail.

---

# 38. Working with a team

DevWeave is designed for work that may span multiple sessions and developers.

Example:

```text
Developer A
    ↓
Discovery
    ↓
Requirements
    ↓
Solution
    ↓
Plan
    ↓
Handoff
    ↓
Developer B
    ↓
Read state + artifacts
    ↓
Implement
    ↓
Test
    ↓
Verify
    ↓
Review
```

The repository artifacts, rather than the previous AI conversation, are the durable source of workflow state.

---

# 39. Recommended daily usage

For a normal User Story:

```bash
DevWeave-context US-123
```

Then follow the lifecycle:

```text
DISCOVERY
REQUIREMENTS
SOLUTION
APPROVAL
PLAN
IMPLEMENT
TEST
VERIFY
REVIEW
PR READY
```

For a bug:

```bash
DevWeave-context BUG-123
```

Then use the BUG workflow profile.

For a modernization item:

```bash
DevWeave-context MOD-123
```

Then select/use the MODERNIZATION workflow profile.

---

# 40. What happens if there is no project-management tool?

Nothing breaks.

Use:

```bash
DevWeave-context US-123
```

DevWeave asks you to paste the requirements.

After that:

```text
Manual requirements
      ↓
Generic Work Item
      ↓
AI-DLC
```

The external project-management system is optional.

---

# 41. What happens if MCP stops working?

If context was already captured:

```text
MCP unavailable
      ↓
Existing context.md
      ↓
Continue workflow
```

If the work item has never been retrieved:

```text
MCP unavailable
      ↓
Retry
or
Paste requirements
or
Cancel
```

DevWeave must never invent missing external-system information.

---

# 42. Recommended repository structure

A typical DevWeave-enabled repository may contain:

```text
repository/
│
├── .aidlc/
│   ├── repository/
│   ├── knowledge/
│   │   ├── repository/
│   │   ├── domain/
│   │   ├── technical/
│   │   └── practices/
│   │
│   ├── work-items/
│   │   └── US-123/
│   │       ├── state.md
│   │       ├── context.md
│   │       ├── requirements.md
│   │       ├── solution.md
│   │       ├── plan.md
│   │       ├── verification.md
│   │       └── audit.md
│   │
│   ├── decisions/
│   ├── verification/
│   └── audit/
│
├── src/
├── tests/
└── ...
```

The exact repository layout may vary by DevWeave version and host adapter.

---

# 43. Complete example

Suppose the user has:

```text
Jira Story: MMGI-1234
Title: Add customer notification preferences
```

The developer starts:

```bash
DevWeave-context MMGI-1234
```

DevWeave:

```text
✓ Jira MCP detected
✓ Authentication available
✓ Work item retrieved
✓ User Story identified
✓ Repository loaded
✓ .NET detected
✓ Angular detected
✓ Database impact detected
✓ Relevant domain knowledge loaded

Context ready.
```

Then:

```text
DISCOVERY
```

DevWeave identifies:

```text
Frontend:
CustomerPreferencesComponent

Backend:
CustomerPreferencesService

API:
GET/PUT /preferences

Database:
CustomerPreferences
```

Then:

```text
REQUIREMENTS
```

Acceptance criteria are recorded.

Then:

```text
SOLUTION
```

DevWeave proposes the implementation approach.

The developer approves.

Then:

```text
PLAN
```

The implementation plan is created.

Then:

```text
IMPLEMENT
```

Code changes are made.

Then:

```text
TEST
```

Tests execute.

Then:

```text
VERIFY
```

DevWeave checks the implementation against the original requirements.

Then:

```text
REVIEW
```

Correctness/security/performance checks run.

Finally:

```text
PR READY
```

The work item, code, tests, verification and review remain traceable.

---

# 44. The most important rule for users

Developers should not think:

> "I need to tell the AI how to implement this."

Instead think:

> "I give DevWeave the work item, and DevWeave guides the engineering lifecycle."

The developer remains responsible for:

- Approvals
- Business decisions
- High-impact operations
- Reviewing important changes
- Final engineering judgment

DevWeave provides the structured process, context, automation and evidence.

---

# 45. Quick reference

## Initialize

```bash
DevWeave init
```

## Start from a work item

```bash
DevWeave-context <WorkItemId>
```

## Refresh work item

```bash
DevWeave-context --refresh <WorkItemId>
```

## No MCP

Paste the requirements when DevWeave asks.

## Lifecycle

```text
INIT
→ DISCOVERY
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

## State

```text
.aidlc/work-items/<WorkItemId>/state.md
```

## Core principle

```text
Work Item
   ↓
Context
   ↓
Knowledge
   ↓
Focused Context
   ↓
AI-DLC
   ↓
Evidence
   ↓
Verified Change
```

---

# 46. DevWeave in one sentence

> **DevWeave turns a software work item into a controlled, traceable, knowledge-aware AI engineering workflow from discovery to PR readiness — while minimizing unnecessary AI work and token usage.**
