# DevWeave AI-DLC State Machine Specification

This document formally defines the state model, valid transitions, guard conditions, and recovery paths for DevWeave work items.

---

## 1. State Enumeration

### 1.1 Progression States
| State | Description | Preceding State |
| :--- | :--- | :--- |
| `INIT` | Initialized state upon work item creation. | None |
| `DISCOVERED` | Repository context and relevant dependencies discovered. | `INIT` |
| `REQUIREMENTS_READY` | Functional and non-functional requirements drafted and signed off. | `DISCOVERED` |
| `SOLUTION_READY` | Technical architecture and solution strategy formulated. | `REQUIREMENTS_READY` |
| `APPROVED` | Solution and approach approved by human or policy gate. | `SOLUTION_READY` |
| `PLANNED` | Implementation plan decomposed into atomic, ordered steps. | `APPROVED` |
| `IMPLEMENTING` | Implementation actively in progress across planned steps. | `PLANNED` / `FIX_REQUIRED` |
| `IMPLEMENTED` | All planned code changes applied. | `IMPLEMENTING` |
| `TESTED` | Unit and integration test suites executed and passing. | `IMPLEMENTED` |
| `VERIFIED` | Deterministic verification (build, lint, type-check, policy) passed. | `TESTED` |
| `REVIEWING` | Code review and multi-agent critique actively in progress. | `VERIFIED` |
| `REVIEWED` | Code review completed with positive consensus. | `REVIEWING` |
| `PR_READY` | Pull request summary and artifacts compiled; ready for merge. | `REVIEWED` |

### 1.2 Failure & Recovery States
| State | Description | Trigger | Recovery Target |
| :--- | :--- | :--- | :--- |
| `APPROVAL_REJECTED` | Solution rejected during approval gate. | Reviewer rejection | `REQUIREMENTS_READY` or `SOLUTION_READY` |
| `TEST_FAILED` | Automated test suite encountered failures. | Test exit code != 0 | `FIX_REQUIRED` |
| `VERIFY_FAILED` | Lint, type-check, or build verification failed. | Verification error | `FIX_REQUIRED` |
| `REVIEW_FAILED` | Code review identified critical issues. | Review rejection | `FIX_REQUIRED` |
| `FIX_REQUIRED` | Work item staged for remediation and fix application. | Any test/verify/review failure | `IMPLEMENTING` |

---

## 2. Transition Matrix

```mermaid
stateDiagram-v2
    [*] --> INIT
    INIT --> DISCOVERED: Run Discovery
    DISCOVERED --> REQUIREMENTS_READY: Define Requirements
    REQUIREMENTS_READY --> SOLUTION_READY: Design Solution
    SOLUTION_READY --> APPROVED: Approve Solution
    SOLUTION_READY --> APPROVAL_REJECTED: Reject Solution
    APPROVAL_REJECTED --> SOLUTION_READY: Revise Solution

    APPROVED --> PLANNED: Generate Plan
    PLANNED --> IMPLEMENTING: Start Implementation
    IMPLEMENTING --> IMPLEMENTED: All Steps Applied
    
    IMPLEMENTED --> TESTED: Tests Pass
    IMPLEMENTED --> TEST_FAILED: Tests Fail
    TEST_FAILED --> FIX_REQUIRED: Diagnose Failure
    
    TESTED --> VERIFIED: Verification Pass
    TESTED --> VERIFY_FAILED: Verification Fail
    VERIFY_FAILED --> FIX_REQUIRED: Diagnose Failure
    
    VERIFIED --> REVIEWING: Initiate Review
    REVIEWING --> REVIEWED: Review Approved
    REVIEWING --> REVIEW_FAILED: Changes Requested
    REVIEW_FAILED --> FIX_REQUIRED: Diagnose Feedback

    FIX_REQUIRED --> IMPLEMENTING: Apply Fixes
    
    REVIEWED --> PR_READY: Finalize Package
    PR_READY --> [*]
```

---

## 3. Transition Guards and Policies

1. **No Skip Rule**: Progression cannot bypass prerequisite states unless explicitly permitted by the assigned `WorkflowProfile` (e.g., `EXPRESS` profiles may combine Discovery and Requirements).
2. **Artifact Preservation Guard**: State cannot advance from `SOLUTION_READY` to `APPROVED` without a valid `solution.md` artifact.
3. **Deterministic Verification Guard**: Transition to `REVIEWING` strictly requires all automated verification checks in `VERIFIED` to report zero errors.
4. **Fix Convergence Guard**: If a work item enters `FIX_REQUIRED` more than 3 consecutive cycles for the same failure, execution must halt and request human operator intervention.
