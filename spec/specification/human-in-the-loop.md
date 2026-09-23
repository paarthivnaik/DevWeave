# DevWeave Human-in-the-Loop (HITL) & Governance Specification

This document defines the normative requirements for human checkpoints, phase isolation, and explicit phase advancement across DevWeave.

---

## 1. Core Principles

1. **AI Proposes, Human Decides**: The AI coding assistant executes analysis, planning, and coding within bounded limits, but the human engineer remains in total control of progression.
2. **Phase Isolation**: Every phase command must execute **only its own phase**, generate its artifact, present a structured summary, and terminate.
3. **Zero Automatic Chaining**: No phase may automatically invoke the next phase. The next command is suggested, but must be explicitly invoked by the developer.
4. **Durable Decision Audit**: Human decisions must be permanently recorded in `.devweave/work-items/<ID>/state.md` and `audit.md`.
5. **Mandatory Description Prompting (Optional Input)**: For **every phase**, it is **mandatory** for DevWeave to ask the user/developer if they have any additional description, custom requirements, or constraints. Providing input is **optional**; if no additional description is provided, DevWeave continues with standard defaults.
6. **Pre-Processing Transparency**: Before performing any processing, inspections, or mutations in any phase, DevWeave must explicitly explain what it is about to do, which files/areas it will inspect or edit, and its specific objective.

---

## 2. Standard Human Checkpoint Interface & Description Solicitation

For **every phase** in the lifecycle (both V1.0 standard development and V1.1 modernization), DevWeave must explicitly ask the user/developer if they have any additional description, context, or specific requirements:

```text
======================================================================
  PHASE: <PHASE_NAME> | Work Item: <WORK_ITEM_ID>
  Artifact: .devweave/work-items/<ID>/<artifact-name>
======================================================================
Key Findings / Summary:
- ...
- ...

Developer Context & Description Solicitation:
> "Please provide any additional description, architectural constraints, 
   or specific instructions for this phase (or press Enter/Submit to proceed with defaults)."

Human Decision & Input Options:
  [APPROVE]              -> Accept phase outcome and mark phase COMPLETED.
  [PROVIDE_DESCRIPTION]  -> Supply custom description, additional requirements, or domain context.
  [REQUEST_CHANGES]      -> Provide feedback; phase remains IN_PROGRESS.
  [PROVIDE_INFORMATION]  -> Supply missing requirements or context.
  [REJECT]               -> Reject outcome; revert to preceding phase.
  [STOP]                 -> Pause workflow without further execution.

Suggested Next Phase: <NEXT_PHASE>
Run: DevWeave-<next-phase> <WORK_ITEM_ID>
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
