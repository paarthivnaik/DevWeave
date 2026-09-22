# DevWeave V1.0 — Google Antigravity Documentation & Implementation Synchronization Plan

## Purpose

This document is the **step-by-step execution prompt/plan for Google Antigravity** to update the existing DevWeave repository so that the implementation, specification, documentation, conformance scenarios, and Antigravity plugin all follow the agreed DevWeave workflow.

The source workflow model is the uploaded **MMGI AIDLC Plugin** reference. DevWeave should adopt its useful workflow structure and interaction model, while remaining generic and vendor-neutral.

**Important:** Do not copy MMGI-specific assumptions such as JIRA, PHI, HIPAA, gGastro, Angular/.NET versions, Claude model names, Hydra, or ModMed-specific tooling. Convert those concepts into generic DevWeave capabilities/adapters/policies.

---

# 1. NON-NEGOTIABLE DESIGN DECISIONS

Before modifying anything, treat the following as the current DevWeave V1.0 decisions.

## 1.1 DevWeave is generic

DevWeave MUST NOT be tied to:

- JIRA
- Azure DevOps
- GitHub/GitLab
- Claude/Codex/Copilot/Gemini
- Google Antigravity
- TypeScript/Node/.NET/Python
- MySQL/PostgreSQL
- Azure/AWS/GCP
- any specific model vendor
- any specific MCP provider

Google Antigravity is a **host adapter/reference implementation**, not the foundation.

---

## 1.2 Adopt the MMGI six-phase user workflow

The user-facing lifecycle is exactly:

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

The only DevWeave-specific repository-level command is:

```text
DevWeave init
```

After initialization, work starts with:

```text
DevWeave-context <WorkItem-ID>
```

Then the user explicitly runs each subsequent phase.

---

## 1.3 Every phase is isolated

A phase command MUST execute **only its own phase**.

For example:

```text
DevWeave-context ID
```

may perform CONTEXT only.

It MUST NOT automatically execute:

```text
ANALYZE
PLAN
BRANCH
IMPLEMENT
PR
```

After completing CONTEXT, it must stop.

It should tell the user:

```text
CONTEXT COMPLETE

Suggested next phase:
ANALYZE

Run:
DevWeave-analyze <ID>

DevWeave is waiting for your instruction.
```

The same rule applies to every phase.

---

## 1.4 Human-in-the-loop is mandatory

Every phase MUST end with a human checkpoint.

The AI performs the phase, produces its artifact/result, presents a concise summary, and waits for explicit human input.

The human can:

- APPROVE
- REQUEST_CHANGES
- PROVIDE_INFORMATION
- REJECT
- STOP
- RETRY where appropriate

The next phase is never implicitly approved.

Important distinction:

**Human checkpoint does not mean every phase has the same level of ceremony.**

Suggested model:

| Phase | Human checkpoint |
|---|---|
| CONTEXT | Confirm context |
| ANALYZE | Confirm understanding/approach |
| PLAN | Confirm implementation plan |
| BRANCH | Hard approval |
| IMPLEMENT | Confirm implementation |
| PR | Hard approval before PR creation |

---

## 1.5 Phase completion must be durable

Every phase must persist:

- phase status
- artifact/result
- timestamp
- human decision
- decision timestamp
- reviewer/actor
- comments/requested changes
- next suggested phase
- audit event

Do not rely on chat history.

---

## 1.6 No automatic advancement

After every phase:

```text
AI executes
   ↓
artifact/result
   ↓
human checkpoint
   ↓
phase completed
   ↓
suggest next phase
   ↓
STOP
```

The workflow resumes only when the user explicitly invokes the next command.

---

# 2. FIRST TASK — INSPECT THE EXISTING DEVWEAVE REPOSITORY

Before changing any file:

1. Inspect the entire repository structure.
2. Read:
   - `README.md`
   - `VERSION`
   - `CHANGELOG.md`
   - `spec/`
   - `docs/`
   - `conformance/`
   - existing plugin/adapter directories
   - existing Antigravity implementation
   - existing `.devweave` references
3. Search for:
   - old AI-DLC phase names
   - old command tables
   - `DevWeave-*` commands
   - `devweave-*` skills
   - lifecycle/state definitions
   - artifact definitions
   - workflow profiles
   - human approval/gate definitions
   - technology detection
   - knowledge refresh
   - MCP
   - database
   - security
   - verification/review
   - conformance scenarios
4. Identify the **current canonical terminology and directory structure**.
5. Do not create duplicate structures if equivalent ones already exist.
6. Do not replace `.devweave` with `.aidlc` if `.devweave` is already canonical.

Create an internal implementation inventory before editing.

---

# 3. SECOND TASK — BUILD A CURRENT-STATE GAP MATRIX

Create or update a working matrix:

| Capability | Existing Spec | Existing Implementation | Existing Conformance | Existing Docs | Required Change |
|---|---|---|---|---|---|
| DevWeave init | | | | | |
| CONTEXT | | | | | |
| ANALYZE | | | | | |
| PLAN | | | | | |
| BRANCH | | | | | |
| IMPLEMENT | | | | | |
| PR | | | | | |
| Human checkpoints | | | | | |
| Explicit phase advancement | | | | | |
| State/resume | | | | | |
| Work-item isolation | | | | | |
| Knowledge reuse | | | | | |
| Technology detection | | | | | |
| Technology change/revalidation | | | | | |
| Version-aware practices | | | | | |
| Workflow profiles | | | | | |
| Effort levels | | | | | |
| Project-management MCP | | | | | |
| Database capability | | | | | |
| Security/governance | | | | | |
| Verification/review | | | | | |
| Fix/retest/reverify loop | | | | | |
| Traceability | | | | | |
| Audit | | | | | |
| Metrics | | | | | |
| Handoff | | | | | |
| Archive | | | | | |
| Express | | | | | |
| Host adapter | | | | | |
| Token efficiency | | | | | |

Do not mark something IMPLEMENTED unless the repository actually contains the implementation.

Use status vocabulary:

```text
SPECIFIED
DESIGNED
IMPLEMENTED
TESTED
DOCUMENTED
```

A capability may have more than one status.

---

# 4. THIRD TASK — UPDATE THE CANONICAL AI-DLC SPECIFICATION

Update the normative specification so the six-phase model is canonical.

Use:

```text
DevWeave init
```

for repository initialization.

Then:

```text
CONTEXT → ANALYZE → PLAN → BRANCH → IMPLEMENT → PR
```

## 4.1 Define phase contracts

Each phase must document:

- purpose
- inputs
- prerequisites
- allowed actions
- artifact(s)
- human checkpoint
- completion criteria
- state transition
- next suggested phase
- failure/recovery behavior
- audit events

---

# 5. CONTEXT PHASE CONTRACT

Command:

```text
DevWeave-context <WorkItem-ID>
```

Responsibilities:

1. Load the work item through an available project-management adapter/MCP.
2. If no project-management integration exists, ask the user for the work-item information.
3. Load relevant repository knowledge.
4. Load relevant product/domain/technology knowledge.
5. Detect affected repository areas.
6. Identify missing information.
7. Preserve source provenance.
8. Create/update the context artifact.
9. Record phase metrics and audit events.
10. Present a human checkpoint.
11. Stop.

Example final output:

```text
CONTEXT COMPLETE

Work Item: <ID>

Loaded:
✓ Work item
✓ Repository knowledge
✓ Relevant domain knowledge
✓ Technology context

Affected areas:
- ...
- ...

Open questions:
- ...

Artifact:
.devweave/work-items/<ID>/context.md

Human decision:
[Approve] [Request Changes] [Add Information] [Stop]

Suggested next phase:
ANALYZE

Run:
DevWeave-analyze <ID>

DevWeave is waiting for your instruction.
```

The command MUST NOT invoke ANALYZE.

---

# 6. ANALYZE PHASE CONTRACT

Command:

```text
DevWeave-analyze <WorkItem-ID>
```

Responsibilities:

- investigate the repository
- map requirements to code/components
- investigate bugs and root causes where applicable
- identify existing patterns
- identify dependencies
- evaluate options
- identify constraints
- identify risks
- identify technology/version implications
- refresh affected knowledge when technology changes
- produce analysis/solution information
- present human checkpoint
- stop

For bugs, support:

```text
symptom
→ evidence
→ hypotheses
→ separating evidence
→ root cause
→ fix approach
```

For features:

```text
requirements
→ existing components
→ reuse/extend/new
→ architecture impact
→ solution
```

Do not automatically start PLAN.

---

# 7. PLAN PHASE CONTRACT

Command:

```text
DevWeave-plan <WorkItem-ID>
```

The plan must be an implementation contract.

It should include, where applicable:

- exact files
- symbols/anchors
- changes
- reason
- dependencies
- database changes
- API changes
- UI changes
- tests
- migrations
- security checks
- acceptance criteria mapping
- risks
- rollback considerations

Avoid vague instructions such as:

```text
Update the service and add tests.
```

Prefer:

```text
File:
Symbol:
Change:
Reason:
Acceptance check:
Test:
```

After producing the plan:

```text
PLAN COMPLETE

Artifact:
.devweave/work-items/<ID>/plan.md

Human decision:
[Approve] [Request Changes] [Stop]

Suggested next phase:
BRANCH

Run:
DevWeave-branch <ID>

DevWeave is waiting for your instruction.
```

Do not automatically branch.

---

# 8. BRANCH PHASE CONTRACT

Command:

```text
DevWeave-branch <WorkItem-ID>
```

Validate:

- CONTEXT completed
- ANALYZE completed
- PLAN completed
- plan is approved
- repository state is suitable
- branch does not conflict with work-item isolation rules

Then show:

```text
Work Item: <ID>
Branch: <branch>
Base: <base>
Plan: APPROVED
Expected scope: <summary>

Create branch?

[Approve]
[Cancel]
```

Branch creation requires explicit human approval.

After success:

```text
BRANCH COMPLETE

Branch:
<name>

Suggested next phase:
IMPLEMENT

Run:
DevWeave-implement <ID>

DevWeave is waiting for your instruction.
```

Stop.

---

# 9. IMPLEMENT PHASE CONTRACT

Command:

```text
DevWeave-implement <WorkItem-ID>
```

Implementation MUST:

1. Load durable state.
2. Load approved plan.
3. Load only relevant context.
4. Execute the plan.
5. Avoid unnecessary rediscovery.
6. Run appropriate tests.
7. Record deviations.
8. Stop and return to ANALYZE/PLAN if the approved plan becomes materially invalid.
9. Record implementation evidence.
10. Present a human checkpoint.
11. Stop.

Implementation MUST NOT automatically call PR.

If implementation discovers unexpected scope:

```text
IMPLEMENTATION BLOCKED

Reason:
<reason>

The approved plan is no longer sufficient.

Suggested action:
Return to ANALYZE or PLAN.

No automatic phase transition was performed.
```

---

# 10. PR PHASE CONTRACT

Command:

```text
DevWeave-pr <WorkItem-ID>
```

Internally this phase may perform:

```text
Build
↓
Tests
↓
Requirement verification
↓
Acceptance verification
↓
Regression checks
↓
Security checks
↓
Independent review
↓
Fix
↓
Retest
↓
Reverify
↓
Re-review
```

But these are **internal activities of PR**, not new user-facing lifecycle commands.

The user-facing lifecycle remains six phases.

When all checks pass:

```text
PR READY

Verification: PASS
Tests: PASS
Review: PASS
Security: PASS

PR summary:
...

Human decision:
[Create PR]
[Request Changes]
[Re-run Checks]
[Stop]
```

Creating the external PR requires explicit human approval.

---

# 11. HUMAN-IN-THE-LOOP SPECIFICATION

Add a normative HITL section.

Every phase MUST:

1. produce a reviewable result
2. persist the result
3. present the result to the human
4. ask for an explicit decision
5. persist the decision
6. only then mark the phase complete
7. suggest the next phase
8. terminate

Supported decision types:

```text
APPROVE
REQUEST_CHANGES
PROVIDE_INFORMATION
REJECT
STOP
RETRY
```

Do not treat silence, timeout, or model completion as approval.

Do not allow the AI to approve its own phase.

---

# 12. EXPLICIT PHASE ADVANCEMENT

Add this as a formal invariant:

> A lifecycle phase MUST NOT invoke the next lifecycle phase automatically. The next phase may be suggested, but the user must explicitly invoke it.

Example:

```text
DevWeave-context ID
        ↓
CONTEXT COMPLETE
        ↓
suggest ANALYZE
        ↓
STOP
```

Not:

```text
DevWeave-context ID
        ↓
ANALYZE
        ↓
PLAN
```

This invariant must be reflected in:

- specification
- architecture
- CLI documentation
- skill instructions
- state machine
- conformance tests
- user guide

---

# 13. STATE MACHINE

Use the six user-visible phases.

Example:

```yaml
workItemId: <ID>
currentPhase: CONTEXT
status: WAITING_FOR_HUMAN
phases:
  CONTEXT:
    status: WAITING_FOR_HUMAN
  ANALYZE:
    status: PENDING
  PLAN:
    status: PENDING
  BRANCH:
    status: PENDING
  IMPLEMENT:
    status: PENDING
  PR:
    status: PENDING
nextSuggestedPhase: ANALYZE
```

Internal activities such as requirements analysis, solution design, testing, verification, and review may remain internal execution details.

Do not expose them as additional lifecycle commands.

---

# 14. RESUME BEHAVIOR

Every phase command should perform resume/state detection before execution.

If the work item already contains completed artifacts:

- do not overwrite completed phases
- show current phase
- show previous decisions
- show pending human action
- continue only when explicitly requested

Example:

```text
Work Item: US-123

✓ CONTEXT
✓ ANALYZE
✓ PLAN
✓ BRANCH
○ IMPLEMENT
○ PR

Current state:
READY_FOR_IMPLEMENT

Run:
DevWeave-implement US-123
```

Do not automatically resume execution.

---

# 15. STATUS COMMAND

Maintain:

```text
DevWeave-status <WorkItem-ID>
```

Example:

```text
DevWeave
────────────────────────

Work Item: US-123

✓ CONTEXT
✓ ANALYZE
✓ PLAN
✓ BRANCH
○ IMPLEMENT
○ PR

State:
WAITING_FOR_USER

Suggested next phase:
IMPLEMENT

Run:
DevWeave-implement US-123
```

---

# 16. KNOWLEDGE AND TECHNOLOGY CHANGE

Retain the previously designed technology-aware knowledge system.

Skills are stable.

Knowledge and practices are refreshable.

If technology changes:

```text
.NET Core 3.0
      ↓
.NET 10
```

do NOT recreate the Skill.

Instead:

```text
Technology change detected
↓
Identify affected knowledge
↓
Identify affected practices
↓
Mark knowledge NEEDS_REVALIDATION
↓
Refresh affected knowledge
↓
Refresh version-specific practices
↓
Continue
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

This behavior belongs primarily in CONTEXT/ANALYZE.

---

# 17. VERSION-AWARE PRACTICES

Keep practice categories:

```text
MANDATORY
RECOMMENDED
ADVISORY
ANTI_PATTERN
```

Practice sources:

```text
Security/Compliance
Organization Policy
Repository Convention
Official Technology Guidance
DevWeave Recommendation
```

Practices must be version-aware.

Do not invent framework rules without evidence.

---

# 18. WORKFLOW PROFILES

Keep workflow profiles internally:

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

The six lifecycle phases remain the same.

Profiles modify phase behavior; they do not create another command model.

Example:

```text
BUG
CONTEXT → ANALYZE → PLAN → BRANCH → IMPLEMENT → PR

MODERNIZATION
CONTEXT → ANALYZE → PLAN → BRANCH → IMPLEMENT → PR

DATABASE
CONTEXT → ANALYZE → PLAN → BRANCH → IMPLEMENT → PR
```

---

# 19. MODEL/CAPABILITY ROUTING

Do not hard-code vendor model names into the core.

Use capability categories such as:

```text
FAST_CONTEXT
DEEP_ANALYSIS
DEEP_PLANNING
DETERMINISTIC_EXECUTION
CODE_EXECUTION
INDEPENDENT_REVIEW
```

The Antigravity adapter maps these capabilities to available models.

The core specification remains vendor-neutral.

---

# 20. PROJECT-MANAGEMENT MCP

During `DevWeave init`, optionally ask which project-management system is available through MCP.

Support a generic contract:

```text
readWorkItem
createWorkItem
updateWorkItem
addComment
attachEvidence
transitionStatus
```

Providers may include:

- JIRA
- Azure DevOps
- GitHub
- GitLab
- Linear
- other adapters

Do not make any provider mandatory.

If unavailable:

```text
Project-management integration not configured.

Please provide:
- Work item ID
- title
- description
- acceptance criteria
- relevant context
```

Manual input must remain a first-class path.

Never store raw PATs in repository artifacts.

---

# 21. DATABASE CAPABILITY

Retain the database capability design.

Database work remains inside the six phases.

Example:

```text
CONTEXT
→ identify DB impact

ANALYZE
→ inspect schema/design

PLAN
→ migration/change plan

BRANCH
→ human approval

IMPLEMENT
→ apply authorized change

PR
→ DB + application verification
```

Use environment policies.

Production/destructive operations require explicit policy and human approval.

Credentials must never enter artifacts or prompts.

---

# 22. SECURITY AND GOVERNANCE

Retain:

- secret protection
- permission boundaries
- tool allowlists
- destructive command restrictions
- production database restrictions
- MCP trust
- hooks trust
- network restrictions
- audit logging
- high-impact human approvals

High-impact examples:

- production DB mutation
- destructive migration
- production deployment
- credential changes
- repository deletion
- mass file deletion
- external system mutation

---

# 23. TRACEABILITY

Maintain:

```text
External Work Item
        ↓
Context
        ↓
Analysis
        ↓
Plan
        ↓
Implementation
        ↓
Tests
        ↓
Verification
        ↓
Review
        ↓
PR
```

Every artifact must be attributable to the work item.

---

# 24. AUDIT

Record:

```text
run started
phase started
artifact created/updated
human decision requested
human decision received
state changed
tool invoked
MCP accessed
database accessed
test executed
verification completed
review finding created
review finding resolved
phase completed
phase stopped
phase failed
run completed
```

Human decisions must include:

```text
actor
timestamp
decision
comment
```

---

# 25. METRICS

Keep phase metrics inspired by MMGI.

Measure:

- duration
- phase outcome
- estimated tokens when available
- model/capability
- files changed
- tests
- human interventions
- retries
- rework
- knowledge reuse
- failures
- aborts

Do not fabricate token measurements if the host does not expose them.

---

# 26. HANDOFF

Support:

```text
DevWeave-handoff <ID>
```

Produce a durable handoff artifact containing:

- current status
- completed phases
- decisions
- implementation summary
- tests
- known issues
- PR
- remaining work
- next recommended action

---

# 27. ARCHIVE

Support:

```text
DevWeave-archive <ID>
```

After merge, move the active work-item workspace into the canonical archive structure.

Do not delete audit history.

---

# 28. EXPRESS

Support an optional express mode:

```text
DevWeave-express <ID> ...
```

It may process multiple work items, but it MUST NOT silently bypass the Human-in-the-Loop principle.

If express mode intentionally bypasses individual phase checkpoints:

- require explicit batch-level confirmation
- clearly show which gates are bypassed
- record the bypass
- restrict express mode for high-risk work unless explicitly authorized

Do not make express mode the default.

---

# 29. ANTIGRAVITY PLUGIN IMPLEMENTATION

Now inspect the existing Antigravity plugin.

The plugin should map the user-facing commands to Skills.

Conceptually:

```text
DevWeave-context
      ↓
devweave-context Skill

DevWeave-analyze
      ↓
devweave-analyze Skill

DevWeave-plan
      ↓
devweave-plan Skill

DevWeave-branch
      ↓
devweave-branch Skill

DevWeave-implement
      ↓
devweave-implement Skill

DevWeave-pr
      ↓
devweave-pr Skill
```

And:

```text
DevWeave init
      ↓
devweave-init Skill
```

Do not expose internal AI-DLC subskills as the primary lifecycle.

---

# 30. SKILL DESIGN RULE

Each Skill must be independently executable.

A Skill MUST:

1. validate prerequisites
2. load the minimum required context
3. execute only its phase
4. create/update its artifact
5. update durable state
6. request human decision
7. record the decision
8. suggest the next phase
9. stop

A Skill MUST NOT call the next lifecycle Skill automatically.

---

# 31. CONFORMANCE UPDATES

Update conformance to test the new behavior.

At minimum add scenarios for:

### C1 — Context stops after context

```text
Run context
Assert:
- context artifact exists
- context is complete
- next phase is suggested
- analyze was NOT executed
```

### C2 — Human approval required

```text
Run context
Assert:
- workflow waits for human decision
- no automatic advancement
```

### C3 — Request changes

```text
Context
→ REQUEST_CHANGES
→ context remains incomplete/pending
→ analyze cannot start
```

### C4 — Explicit advancement

```text
Context approved
→ command terminates

Analyze starts only after explicit command.
```

### C5 — Wrong phase

```text
Implement requested before plan/branch
→ reject execution
→ suggest next valid phase
→ do not auto-run plan
```

### C6 — Resume

```text
Context completed
session ends
new session
status/context invoked
→ state restored
```

### C7 — Human approval at every phase

Test all six phases.

### C8 — PR hard approval

Ensure PR is not created without explicit human confirmation.

### C9 — Technology change

Test:

```text
.NET Core 3
→ .NET 10
```

and assert:

```text
affected knowledge = NEEDS_REVALIDATION
version practices refreshed
skills are not recreated
```

### C10 — Token/context reuse

Ensure later phases reuse durable artifacts rather than rediscovering the entire repository.

---

# 32. DOCUMENTATION STRUCTURE

Update the existing repository rather than blindly creating duplicate documents.

At minimum, ensure there is documentation covering:

```text
README
   ↓
What is DevWeave?

User Guide
   ↓
How to use the six phases

Workflow
   ↓
CONTEXT → ANALYZE → PLAN → BRANCH → IMPLEMENT → PR

Architecture
   ↓
Core + Host Adapter + Skills + Knowledge + State

Human-in-the-loop
   ↓
Phase checkpoints and explicit advancement

Knowledge
   ↓
Repository/domain/technology knowledge

Technology changes
   ↓
Revalidation

MCP
   ↓
Project-management integration

Database
   ↓
DB workflow and security

Security
   ↓
Governance and approvals

State
   ↓
Resume/interruption

Conformance
   ↓
Proof of behavior

Antigravity
   ↓
Host-specific implementation
```

---

# 33. DO NOT DUPLICATE DOCUMENTATION

Before adding a new document:

1. Search for an existing document covering the topic.
2. Update the existing canonical document if possible.
3. Only create a new document when the topic genuinely deserves its own document.
4. Cross-link related documents.
5. Update the documentation index.

Avoid multiple contradictory versions of the lifecycle.

---

# 34. DOCUMENTATION COMPLETENESS RULE

For every implemented capability:

```text
Specification
+
Architecture/design
+
Implementation
+
Conformance
+
User/developer documentation
```

must be updated.

A feature is not considered complete merely because code exists.

Use:

```text
Discuss
→ Decide
→ Specify
→ Design
→ Implement
→ Conformance
→ Document
→ Validate
→ Mark complete
```

---

# 35. IMPLEMENTATION ORDER

Antigravity MUST execute this work in the following order.

## Step 1
Inspect repository and existing documentation.

Do not modify code.

## Step 2
Create the current-state gap matrix.

Do not modify implementation yet.

## Step 3
Update the canonical lifecycle specification.

Lock:

```text
init
+
CONTEXT
→ ANALYZE
→ PLAN
→ BRANCH
→ IMPLEMENT
→ PR
```

## Step 4
Update HITL and explicit advancement rules.

## Step 5
Update state machine and resume behavior.

## Step 6
Update artifact contracts.

## Step 7
Update Antigravity Skills/commands to follow the six-phase model.

## Step 8
Update knowledge/technology revalidation behavior.

## Step 9
Update MCP/database/security/governance documentation.

## Step 10
Update conformance scenarios.

## Step 11
Implement only the code required by the documented changes.

## Step 12
Run conformance/validation.

## Step 13
Update README/user/developer documentation.

## Step 14
Validate links, terminology, paths, commands, schemas and examples.

## Step 15
Produce a final implementation report.

---

# 36. ONE STEP AT A TIME RULE FOR ANTIGRAVITY

Do NOT ask Antigravity to blindly implement everything in one uncontrolled operation.

After each major step:

```text
Inspect
→ Modify
→ Validate
→ Report
→ Stop
```

Then continue with the next step.

Prefer small commits where the repository workflow supports them.

---

# 37. FINAL ACCEPTANCE CRITERIA

The implementation is complete only when all of the following are true:

### Workflow

```text
DevWeave init
DevWeave-context <ID>
DevWeave-analyze <ID>
DevWeave-plan <ID>
DevWeave-branch <ID>
DevWeave-implement <ID>
DevWeave-pr <ID>
```

### Phase isolation

Each command executes only its own phase.

### Human control

Every phase stops for explicit human input.

### No automatic chaining

No phase invokes the next phase automatically.

### Next-phase suggestion

Every completed phase clearly suggests the next valid command.

### State

The current phase and decisions survive session interruption.

### Resume

The workflow can continue without rediscovering completed work.

### Genericity

No vendor-specific technology is required by the core.

### Knowledge

Repository and technology knowledge are reusable.

### Technology change

Affected knowledge can be marked `NEEDS_REVALIDATION`.

### Security

High-impact operations have appropriate approval.

### Traceability

Work item → artifacts → implementation → tests → verification → review → PR is traceable.

### Conformance

The behavior is tested, especially:

- phase isolation
- HITL
- explicit advancement
- resume
- wrong-phase protection
- technology revalidation

### Documentation

Every implemented capability is documented.

---

# 38. FINAL OUTPUT REQUIRED FROM ANTIGRAVITY

After completing the requested updates, provide:

```text
1. Files inspected
2. Files created
3. Files modified
4. Specification changes
5. Architecture changes
6. Antigravity Skill changes
7. State-machine changes
8. HITL implementation
9. Conformance changes
10. Documentation changes
11. Tests executed
12. Validation results
13. Remaining gaps
14. Recommended next implementation step
```

Do not claim a capability is implemented unless it was actually implemented and validated.

---

# END STATE

The final DevWeave experience should be extremely simple:

```text
Developer:
DevWeave-context US-123

DevWeave:
CONTEXT COMPLETE
Here is what I found...
Here is the artifact...
Do you approve?

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

Then the developer explicitly decides when to run:

```text
DevWeave-analyze US-123
```

and the same pattern continues:

```text
CONTEXT
   ↓
[HUMAN]
   ↓
ANALYZE
   ↓
[HUMAN]
   ↓
PLAN
   ↓
[HUMAN]
   ↓
BRANCH
   ↓
[HUMAN]
   ↓
IMPLEMENT
   ↓
[HUMAN]
   ↓
PR
   ↓
[HUMAN]
```

**AI performs the work.  
Human controls advancement.  
DevWeave preserves the state and evidence.**

This is the canonical DevWeave V1.0 interaction model.
