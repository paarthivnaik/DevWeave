# DevWeave V1.0 — Project Management MCP & `DevWeave-context` Specification

## 1. Purpose

This specification defines how DevWeave integrates with project-management systems through MCP and how a developer starts an AI-DLC workflow from an external work item.

The design is intentionally generic:

```text
Jira / Azure DevOps / GitHub / GitLab / Linear / Other MCP
                         │
                         ▼
                       MCP
                         │
                         ▼
              Generic DevWeave Work Item
                         │
                         ▼
                 AI-DLC Context
                         │
                         ▼
          Discovery → Requirements → Solution
                         │
                         ▼
          Approval → Plan → Implement → Test
                         │
                         ▼
                Verify → Review → PR Ready
```

MCP is an integration mechanism, not a dependency of the AI-DLC specification.

---

# 2. Relationship to the MMGI AIDLC workflow

The MMGI AIDLC document defines a six-phase general/legacy flow:

1. Context
2. Analyze
3. Plan
4. Branch
5. Implement
6. PR

It also has separate modernization and fix lanes.

DevWeave should **follow the same phase intent**, but it should not copy the MMGI command structure literally because DevWeave's specification has a more granular lifecycle.

## 2.1 MMGI → DevWeave mapping

| MMGI AIDLC | DevWeave AI-DLC | Relationship |
|---|---|---|
| `/mmgi-context` | INIT + DISCOVERY + REQUIREMENTS | Context loading, ticket retrieval, product/domain knowledge and requirements |
| `/mmgi-analyze` | DISCOVERY + SOLUTION | Codebase investigation, impact analysis and approach evaluation |
| `/mmgi-plan` | PLAN | File changes, tests, risks and implementation plan |
| `/mmgi-branch` | APPROVAL / PLAN execution boundary | Git branch creation is a host/repository operation and can be a hard gate |
| `/mmgi-implement` | IMPLEMENT | Execute the approved plan |
| Test execution inside implementation | TEST | Explicit DevWeave lifecycle phase |
| `/mmgi-pr` verification/review | VERIFY + REVIEW + PR READY | DevWeave separates independent verification and review |
| `/mmgi-handoff` | optional handoff artifact | Can be implemented as a post-PR extension |
| `/mmgi-archive` | post-completion lifecycle | Can be implemented as cleanup/archive behavior |
| `/mmgi-document-*` | KNOWLEDGE CAPTURE | Maps to DevWeave durable knowledge |
| `/mmgi-fix-*` | BUG workflow profile | DevWeave BUG profile with bug-specific discovery, diagnosis and verification |
| `/mmgi-modernize-*` | MODERNIZATION workflow profile | DevWeave MODERNIZATION profile with migration-specific artifacts and verification |

### Important conclusion

**Yes, the proposed MCP/context flow follows the MMGI phases.**

However, the correct DevWeave design is:

```text
MMGI proven phase intent
          ↓
DevWeave generic lifecycle
          ↓
Host-specific adapter
```

DevWeave should preserve the useful engineering controls from MMGI while remaining technology-, vendor-, and host-neutral.

---

# 3. `DevWeave init` — Project Management Integration Setup

During initialization, DevWeave should ask whether the repository uses an external project-management system through MCP.

Example:

```text
DevWeave Project Management Integration

Do you use a project-management tool through MCP?

1. Jira
2. Azure DevOps
3. GitHub
4. GitLab
5. Linear
6. Other MCP provider
7. No project-management integration

Select:
```

If the user selects `No`:

```text
No project-management MCP configured.

DevWeave will use local work-item input.

You can start work with:

DevWeave-context <work-item-id>

and paste the requirements when prompted.
```

If the user selects a provider, DevWeave discovers the available MCP capabilities and asks only for the information required by that provider.

---

# 4. MCP authentication

Authentication must be provider- and MCP-dependent.

For example:

```text
Jira MCP Configuration

Authentication method:

1. Personal Access Token (PAT)
2. OAuth
3. MCP-managed authentication

Select:
```

If PAT is required:

```text
Jira Personal Access Token

Please enter your PAT.

PAT:
```

## Security requirements

The raw PAT/token MUST NOT be:

- written to `.aidlc/`
- written to Git
- included in work-item artifacts
- included in prompts unnecessarily
- included in audit logs
- printed to the terminal after entry
- stored in generated Markdown/JSON/YAML
- sent to another model unless explicitly required by the MCP mechanism

Instead, DevWeave should store only a credential reference:

```yaml
authentication:
  type: pat
  credentialReference: jira-default
```

The actual secret belongs to the host's secure credential mechanism or the MCP client's secure configuration.

---

# 5. Generic project-management capability contract

DevWeave must not make Jira concepts part of the AI-DLC core.

The core contract should be generic:

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

Another repository could use:

```yaml
projectManagement:
  enabled: true

  provider:
    name: azure-devops
    adapter: mcp

  capabilities:
    readWorkItems: true
    createWorkItems: false
    updateWorkItems: true
    addComments: true
    attachEvidence: false
    transitionStatus: true
```

Or:

```yaml
projectManagement:
  enabled: false
```

The AI-DLC lifecycle must still work.

---

# 6. `DevWeave-context <WorkItemId>`

This is the primary developer entry point.

Examples:

```bash
DevWeave-context MMGI-1234
```

```bash
DevWeave-context PROJ-123
```

```bash
DevWeave-context AB#1234
```

The identifier itself should remain opaque to the AI-DLC core. The configured adapter determines how to interpret it.

---

# 7. Context command behavior

## Step 1 — Detect integration

```text
DevWeave-context MMGI-1234

Checking project-management integration...
✓ MCP configured
✓ Work-item read capability available
```

If no MCP is configured:

```text
No project-management MCP integration is configured.

DevWeave cannot retrieve MMGI-1234 automatically.

Please copy and paste the requirements below.

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

The pasted content then enters the same generic Work Item pipeline.

---

# 8. MCP retrieval path

When MCP is configured:

```text
DevWeave-context MMGI-1234

Checking project-management integration...
✓ MCP configured

Retrieving work item...
✓ Work item found

Collecting required context...
✓ Type
✓ Title
✓ Description
✓ Acceptance criteria
✓ Priority
✓ Parent/epic
✓ Dependencies
✓ Relevant comments

Creating AI-DLC context...
✓ Context created
```

DevWeave should retrieve only information relevant to the current lifecycle phase.

It should NOT automatically dump an entire Jira project, Epic, comments history, attachments, and all linked tickets into the model.

This is important for the DevWeave objective:

> Less Tokens. More Work. Lower Bill.

---

# 9. Generic Work Item model

External work items should be normalized into a generic contract.

Example:

```yaml
workItem:
  id: MMGI-1234
  type: user-story
  title: Add customer notification preferences

  description: |
    ...

  acceptanceCriteria:
    - ...
    - ...
    - ...

  priority: high

  parent:
    id: MMGI-1200
    type: epic

  dependencies:
    - MMGI-1220

  source:
    provider: jira
    externalId: MMGI-1234
    retrievedAt: "2026-09-22T12:00:00Z"
```

Supported generic types should include at minimum:

- EPIC
- USER_STORY
- BUG
- TASK
- SUBTASK

Provider-specific types may be preserved as metadata.

---

# 10. AI-DLC phase flow after context retrieval

The MCP operation should not replace the AI-DLC lifecycle.

It supplies the input.

```text
DevWeave-context
        │
        ▼
INIT
        │
        ▼
DISCOVERY
        │
        ▼
REQUIREMENTS
        │
        ▼
SOLUTION
        │
        ▼
APPROVAL
        │
        ▼
PLAN
        │
        ▼
IMPLEMENT
        │
        ▼
TEST
        │
        ▼
VERIFY
        │
        ▼
REVIEW
        │
        ▼
PR READY
```

The source work item becomes traceable throughout the lifecycle.

---

# 11. Phase-by-phase mapping to MMGI

## INIT

MMGI equivalent:

- first-run setup
- repository/workflow preparation
- configuration

DevWeave:

```text
INIT
├── detect repository
├── detect configured capabilities
├── detect MCP integrations
├── load repository knowledge
└── prepare lifecycle state
```

No work-item requirements should be invented at this stage.

---

## DISCOVERY

MMGI equivalent:

`/mmgi-context` + `/mmgi-analyze`

DevWeave should:

- retrieve the work item through MCP
- load product/domain knowledge
- inspect repository structure
- detect technology stack
- identify relevant components
- determine impact
- identify dependencies
- build focused context

For a BUG, discovery should emphasize evidence and root-cause investigation.

For a FEATURE, discovery should emphasize affected components, existing patterns, dependencies and acceptance criteria.

---

## REQUIREMENTS

MMGI equivalent:

Context-derived requirements and acceptance-criteria handling.

DevWeave should normalize:

```text
Work Item
    ↓
Business requirements
    ↓
Acceptance criteria
    ↓
Scope
    ↓
Out of scope
    ↓
Assumptions
    ↓
Questions
```

The external ticket is the source input, but DevWeave creates a durable AI-DLC requirements artifact.

---

## SOLUTION

MMGI equivalent:

`/mmgi-analyze` approach evaluation and the design decisions feeding `/mmgi-plan`.

DevWeave should explicitly separate:

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

This is where technology-aware best practices are applied.

---

## APPROVAL

MMGI equivalent:

The hard human gates, especially the branch and PR boundaries.

DevWeave should require explicit approval for configured high-impact decisions.

Approval must be recorded.

---

## PLAN

MMGI equivalent:

`/mmgi-plan`

The plan should contain:

- files/components affected
- implementation steps
- tests
- risks
- database changes
- migration changes
- security considerations
- acceptance checks
- rollback considerations
- required external capabilities

The plan becomes the implementation contract.

---

## IMPLEMENT

MMGI equivalent:

`/mmgi-implement`

Implementation should execute the approved plan rather than silently redesigning the solution.

If implementation discovers a material contradiction, DevWeave should return to the appropriate earlier phase rather than allowing uncontrolled scope expansion.

---

## TEST

MMGI equivalent:

Test execution associated with `/mmgi-implement` and `/mmgi-pr`.

DevWeave makes this an explicit lifecycle phase.

Test evidence should be recorded.

---

## VERIFY

MMGI equivalent:

The verification/compliance checks performed before `/mmgi-pr`.

DevWeave should independently verify:

- requirements
- acceptance criteria
- approved solution
- implementation
- tests
- regression risk
- architecture
- security
- database/API safety
- unintended changes

---

## REVIEW

MMGI equivalent:

`/mmgi-pr` plus review/security-review behavior.

DevWeave should support independent review perspectives such as:

- correctness
- architecture
- security
- performance
- concurrency
- edge cases
- maintainability

---

## PR READY

MMGI equivalent:

`/mmgi-pr`

DevWeave should prepare:

- final evidence
- traceability
- review findings
- test results
- verification results
- PR summary
- external work-item reference

If MCP supports status updates, DevWeave may update the external work item.

---

# 12. Source provenance

Every imported work item should retain provenance.

Example:

```yaml
source:
  provider: jira
  adapter: mcp
  externalId: MMGI-1234
  retrievedAt: "2026-09-22T12:00:00Z"
```

For pasted requirements:

```yaml
source:
  provider: manual
  type: pasted-input
  retrievedAt: "2026-09-22T12:00:00Z"
```

This allows DevWeave to distinguish:

- externally retrieved requirements
- user-provided requirements
- repository-derived knowledge
- AI-inferred information
- approved decisions

---

# 13. Context should be reusable

Once retrieved and validated, context should become reusable knowledge.

```text
MCP
 ↓
Work Item
 ↓
AI-DLC Context
 ↓
Requirements
 ↓
Approved Knowledge
 ↓
Future phases
```

The later phases should not repeatedly fetch the entire external ticket.

For example:

```text
DISCOVERY
  → retrieve ticket

REQUIREMENTS
  → reuse normalized work item

SOLUTION
  → reuse requirements + repository knowledge

PLAN
  → reuse solution + requirements

IMPLEMENT
  → reuse plan + focused context

VERIFY
  → reuse acceptance criteria + solution + evidence

REVIEW
  → reuse plan + implementation + evidence
```

This is both a correctness and token-efficiency requirement.

---

# 14. External-system failure behavior

If MCP is temporarily unavailable after the work item has already been retrieved:

```text
MCP unavailable.

Using previously captured AI-DLC context:
.aidlc/work-items/MMGI-1234/context.md

Continuing without external refresh.
```

If the work item has never been retrieved:

```text
Unable to retrieve MMGI-1234 from the configured MCP.

Options:

1. Retry MCP connection
2. Paste the work-item requirements manually
3. Cancel
```

DevWeave should not fabricate ticket content.

---

# 15. Work-item refresh

Optional command:

```bash
DevWeave-context --refresh MMGI-1234
```

Behavior:

```text
Existing context found.

Refreshing external work item...
✓ Retrieved latest version

Changes detected:
- Description changed
- Acceptance criteria changed
- One dependency added

Existing AI-DLC artifacts may now require revalidation.

Returning to:
REQUIREMENTS
```

A significant source change should invalidate downstream artifacts rather than silently continuing.

---

# 16. Project-management write-back

If the MCP supports write capabilities, DevWeave can optionally write back:

- AI-DLC status
- analysis summary
- plan reference
- verification result
- test evidence
- PR URL
- review status
- completion status

Example:

```text
AI-DLC
  ↓
Verification completed
  ↓
MCP
  ↓
Jira comment/status update
```

Write-back must be capability-driven.

Never assume that every provider supports:

```text
create
update
comment
attach
transition
```

---

# 17. Local fallback is mandatory

DevWeave must work without any project-management system.

Therefore:

```text
                 ┌── MCP Work Item
                 │
DevWeave-context ┤
                 │
                 └── Manual/Pasted Work Item
                         │
                         ▼
                  Generic Work Item
                         │
                         ▼
                    AI-DLC Flow
```

This protects DevWeave's generic nature.

---

# 18. Recommended command behavior

### Basic

```bash
DevWeave-context <WorkItemId>
```

### Refresh

```bash
DevWeave-context --refresh <WorkItemId>
```

### Provider-specific override

Only if the host supports it:

```bash
DevWeave-context jira <WorkItemId>
```

The provider-specific form must not become required by the AI-DLC specification.

---

# 19. Security and governance

The following operations should require explicit configured permissions or approval:

- production work-item mutation
- production database mutation
- credential changes
- external system bulk updates
- mass ticket transitions
- destructive MCP operations

MCP should be treated as a capability boundary.

```text
AI-DLC
   ↓
Capability contract
   ↓
Host policy
   ↓
MCP
   ↓
External system
```

The AI-DLC core must never assume that MCP access implies permission to mutate data.

---

# 20. Audit trail

The following events should be auditable where supported:

```text
context retrieval started
context retrieval completed
context retrieval failed
manual fallback selected
work item normalized
external context refreshed
external context changed
approval requested
approval granted
MCP tool invoked
external system updated
verification completed
PR reference recorded
```

Do not log secrets.

---

# 21. Token-efficiency rules

The integration must follow these rules:

### Rule 1 — Retrieve once

Do not repeatedly retrieve unchanged ticket data.

### Rule 2 — Retrieve focused data

Fetch only the information required for the current phase.

### Rule 3 — Reuse normalized context

Do not repeatedly send raw external-system payloads to the model.

### Rule 4 — Follow dependencies selectively

Do not recursively retrieve every linked issue.

### Rule 5 — Detect changes

Refresh only when requested or when the workflow requires current external state.

### Rule 6 — Separate retrieval from reasoning

MCP retrieves data.

AI-DLC decides what the data means.

### Rule 7 — Preserve evidence

The normalized context and provenance allow later phases to operate without repeatedly calling the MCP.

---

# 22. V1.0 acceptance criteria

## MCP configuration

- [ ] DevWeave asks whether a project-management MCP is used.
- [ ] Provider selection is generic.
- [ ] Provider capabilities are detected.
- [ ] Authentication requirements are provider-specific.
- [ ] PAT authentication is supported where required.
- [ ] Raw credentials are never written to `.aidlc`.
- [ ] Raw credentials are never committed to Git.
- [ ] Missing/invalid credentials produce a clear setup error.

## Context command

- [ ] `DevWeave-context <WorkItemId>` exists.
- [ ] Configured MCP is used to retrieve the work item.
- [ ] Epic is supported.
- [ ] User Story is supported.
- [ ] Bug is supported.
- [ ] Task is supported.
- [ ] Provider-specific types can be represented.
- [ ] Work item is normalized to the generic contract.
- [ ] Source provenance is recorded.
- [ ] Focused context is created.
- [ ] Existing context can be reused.
- [ ] Refresh detects material changes.

## No-MCP fallback

- [ ] DevWeave detects that no MCP is configured.
- [ ] It asks the user to paste requirements.
- [ ] Pasted requirements are normalized into the same generic Work Item model.
- [ ] Manual input can continue through the same AI-DLC lifecycle.
- [ ] DevWeave never invents missing requirements.

## Lifecycle

- [ ] MCP retrieval feeds INIT/DISCOVERY.
- [ ] Requirements are preserved for REQUIREMENTS.
- [ ] Discovery feeds SOLUTION.
- [ ] Approved solution feeds PLAN.
- [ ] PLAN feeds IMPLEMENT.
- [ ] TEST evidence is preserved.
- [ ] VERIFY uses the original requirements and approved solution.
- [ ] REVIEW uses implementation and verification evidence.
- [ ] PR READY contains traceability to the original work item.

## Resilience

- [ ] Workflow can continue using previously captured context when MCP becomes unavailable.
- [ ] First-time MCP failure offers retry/manual input/cancel.
- [ ] Material external changes invalidate affected downstream phases.
- [ ] No fabricated external-system data is allowed.

---

# 23. Final architecture

The final architecture should be:

```text
                    DEVWEAVE
                       │
                AI-DLC Specification
                       │
                 Project Management
                    Capability
                       │
              ┌────────┴────────┐
              │                 │
             MCP             Manual Input
              │                 │
       ┌──────┼──────┐          │
       │      │      │          │
     Jira    ADO   GitHub      Paste
       │      │      │          │
       └──────┼──────┴──────────┘
              │
              ▼
       Generic Work Item
              │
              ▼
          INIT / DISCOVERY
              │
              ▼
         REQUIREMENTS
              │
              ▼
           SOLUTION
              │
              ▼
           APPROVAL
              │
              ▼
             PLAN
              │
              ▼
          IMPLEMENT
              │
              ▼
             TEST
              │
              ▼
            VERIFY
              │
              ▼
            REVIEW
              │
              ▼
          PR READY
```

## Design principle

> **The external project-management system provides the work item. DevWeave owns the engineering lifecycle.**

This keeps the MMGI-proven workflow concepts while making DevWeave generic, MCP-capable, technology-neutral, host-neutral and usable even without an external project-management system.
