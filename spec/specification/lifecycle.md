# DevWeave AI-DLC Lifecycle Specification

The AI-Driven Development Lifecycle (AI-DLC) defines the canonical progression of engineering work items from inception to completion.

---

## 1. Canonical Lifecycle Sequence

```text
       ┌───────────────┐
       │     INIT      │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │   DISCOVERY   │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │ REQUIREMENTS  │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │   SOLUTION    │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │   APPROVAL    │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │     PLAN      │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │   IMPLEMENT   │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │     TEST      │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │    VERIFY     │
       └───────┬───────┘
               ▼
       ┌───────────────┐
       │    REVIEW     │
       └───────┬───────┘
               │  ◄───────────────────────────┐
               ▼ (Fail / Iteration)           │
       ┌───────────────────────────────┐      │
       │    FIX / RETEST / REVERIFY    ├──────┘
       └───────────────┬───────────────┘
               ▼ (Pass)
       ┌───────────────┐
       │   PR READY    │
       └───────────────┘
```

---

## 2. Phase Breakdown

### Phase 1: INIT
- **Objective**: Initialize work item tracking, allocate work item identifier, and assign workflow profile.
- **Input**: User prompt, issue description, ticket, or task trigger.
- **Artifact**: `work-item.json` (initial state metadata).

### Phase 2: DISCOVERY
- **Objective**: Extract relevant repository intelligence (tech stack, existing patterns, dependencies, conventions) without bloating the context.
- **Input**: Existing repository knowledge base (`.devweave/knowledge/`) and targeted codebase inspection.
- **Artifact**: `discovery.md` (scoped context and technical findings).

### Phase 3: REQUIREMENTS
- **Objective**: Synthesize functional and non-functional requirements, edge cases, acceptance criteria, and out-of-scope boundaries.
- **Input**: User intent and discovery findings.
- **Artifact**: `requirements.md` (explicit, testable requirements).

### Phase 4: SOLUTION
- **Objective**: Formulate architectural approach, component design, schema adjustments, interface contracts, and trade-off evaluations.
- **Input**: Requirements and repository conventions.
- **Artifact**: `solution.md` (architectural and technical design).

### Phase 5: APPROVAL
- **Objective**: Explicit gate validating solution alignment with requirements and architectural guidelines before implementation planning.
- **Input**: `solution.md` and `requirements.md`.
- **Artifact**: `approval.json` / Human confirmation.

### Phase 6: PLAN
- **Objective**: Break down solution into ordered, atomic, verifiable implementation steps with defined verification gates for each step.
- **Input**: Approved solution.
- **Artifact**: `plan.md` (actionable task list and dependency tree).

### Phase 7: IMPLEMENT
- **Objective**: Execute code changes incrementally according to the approved plan.
- **Input**: `plan.md`, relevant knowledge snippets, and precise target files.
- **Artifact**: Code modifications and implementation notes.

### Phase 8: TEST
- **Objective**: Author and execute unit, integration, and regression tests validating the implementation against acceptance criteria.
- **Input**: Modified codebase and test framework commands.
- **Artifact**: `test-results.json` / test execution output.

### Phase 9: VERIFY
- **Objective**: Run deterministic quality checks (linters, type checkers, static analysis, security scanners, build scripts).
- **Input**: Verification policy definitions and build tools.
- **Artifact**: `verification.md` (verification log and pass/fail summary).

### Phase 10: REVIEW
- **Objective**: Multi-perspective code review focusing on safety, readability, adherence to repo conventions, and token efficiency.
- **Input**: Git diff and review checklist policy.
- **Artifact**: `review.md` (review comments and approval status).

### Phase 11: FIX / RETEST / REVERIFY
- **Objective**: Remediate any failures encountered during Testing, Verification, or Review in an isolated loop.
- **Input**: Failure logs and review feedback.
- **Artifact**: Updated diff and delta verification results.

### Phase 12: PR READY
- **Objective**: Finalize change documentation, generate pull request description with structured audit trails, and prepare work item for merging.
- **Input**: All completed phase artifacts and git history.
- **Artifact**: `pr-description.md` and complete work item archive.
