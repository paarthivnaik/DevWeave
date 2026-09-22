# DevWeave Human-in-the-Loop (HITL) & Governance Specification

This document defines the normative requirements for human checkpoints, phase isolation, and explicit phase advancement across DevWeave.

---

## 1. Core Principles

1. **AI Proposes, Human Decides**: The AI coding assistant executes analysis, planning, and coding within bounded limits, but the human engineer remains in total control of progression.
2. **Phase Isolation**: Every phase command must execute **only its own phase**, generate its artifact, present a structured summary, and terminate.
3. **Zero Automatic Chaining**: No phase may automatically invoke the next phase. The next command is suggested, but must be explicitly invoked by the developer.
4. **Durable Decision Audit**: Human decisions must be permanently recorded in `.devweave/work-items/<ID>/state.md` and `audit.md`.

---

## 2. Standard Human Checkpoint Interface

At the conclusion of every phase execution, DevWeave presents a standardized checkpoint:

```text
======================================================================
  PHASE COMPLETE: <PHASE_NAME>
  Work Item: <WORK_ITEM_ID>
  Artifact: .devweave/work-items/<ID>/<artifact-name>
======================================================================
Key Findings / Summary:
- ...
- ...

Human Decision Options:
  [APPROVE]              -> Accept phase outcome and mark phase COMPLETED.
  [REQUEST_CHANGES]      -> Provide feedback; phase remains IN_PROGRESS.
  [PROVIDE_INFORMATION]  -> Supply missing requirements or context.
  [REJECT]               -> Reject outcome; revert to preceding phase.
  [STOP]                 -> Pause workflow without further execution.

Suggested Next Phase: <NEXT_PHASE>
Run: DevWeave-<next-phase> <WORK_ITEM_ID>

DevWeave is waiting for your instruction.
```

---

## 3. Human Decision Taxonomy

| Decision | System Action | State Transition |
| :--- | :--- | :--- |
| `APPROVE` | Phase artifact marked approved; records actor & timestamp. | `<PHASE>_COMPLETED` (Ready for next phase) |
| `REQUEST_CHANGES` | Ingests feedback notes; re-executes targeted sub-tasks within the phase. | `<PHASE>_IN_PROGRESS` |
| `PROVIDE_INFORMATION` | Updates `context.md` with additional user inputs. | `<PHASE>_IN_PROGRESS` |
| `REJECT` | Reverts to preceding phase (e.g. Rejecting Plan resets to Analyze). | `<PREVIOUS_PHASE>_IN_PROGRESS` |
| `STOP` | Suspends turn immediately; preserves all existing state. | `SUSPENDED` / `WAITING_FOR_HUMAN` |
| `RETRY` | Re-executes current phase from scratch. | `<PHASE>_IN_PROGRESS` |

---

## 4. Phase Checkpoint Rigor Tiers

| Phase | Checkpoint Type | Rigor & Failure Handling |
| :--- | :--- | :--- |
| `CONTEXT` | Information Confirmation | Validates scope and acceptance criteria. Missing info triggers prompt. |
| `ANALYZE` | Approach Sign-Off | Confirms architectural strategy and root cause diagnosis. |
| `PLAN` | Implementation Contract | Reviews file diffs, test specifications, and rollback plans. |
| `BRANCH` | **HARD GOVERNANCE GATE** | Explicit authorization required before Git branch creation. |
| `IMPLEMENT` | Code & Test Confirmation | Verifies test pass rate and reviewable diffs. |
| `PR` | **HARD GOVERNANCE GATE** | Explicit authorization required before pushing or opening PR. |

---

## 5. Security & Safety Anti-Patterns

- ❌ **Anti-Pattern 1: Implicit Timeout Approval**: Never treat absence of response, timeout, or turn completion as human approval.
- ❌ **Anti-Pattern 2: AI Self-Approval**: The AI assistant must never fabricate or simulate human authorization.
- ❌ **Anti-Pattern 3: Chained Multi-Phase Execution**: Never execute `CONTEXT` $\to$ `ANALYZE` $\to$ `PLAN` in a single prompt turn unless explicitly authorized in a declared `EXPRESS` batch profile.
