---
name: express
description: [Express Lane - Fast Track] Runs Context -> Analyze -> Plan -> Branch -> Implement -> PR for one or more low-risk work items with batch confirmation and test gate.
---

# DevWeave Express Skill (`devweave-express`)

## Purpose
Accelerate execution for queues of similar, non-tier-0 work items (backlog sweeps, epic-child tickets) by batching lifecycle phases while strictly preserving safety gates.

---

## Execution Workflow

### Step 0: Batch Initialization & Safety Checks
1. **Bypass Confirmation**: Ask ONCE for the entire batch:
   ```text
   [Express Lane Bypass Confirmation]
   Running Express Mode for <N> work items: <IDs>
   Branching and PR gates will be automatically approved and logged to audit.md.
   Do you authorize batch express execution? [Confirm & Proceed] [Cancel]
   ```
2. **Sibling-Coupling Check (When N > 1)**:
   - Ask developer: **Parallel** (all branches off shared base) vs. **Sequential** (stacked branches, item N off item N-1).
3. **Test Execution Gate (When `--handoff` is passed)**:
   - Ask once: Run tests after each implement | Hand off with tests-pending | Tests run out-of-band (CI).
4. **Safety Restrictions**: Do NOT use Express mode for tier-0, critical security, or unverified database schema migrations.

### Step 1: Sequential / Parallel Ticket Processing
For each work item in the queue:
- **`CONTEXT`**: Executes PII/privacy check per item.
- **`ANALYZE`**: Maps components or root causes.
- **`PLAN`**: Emits step-level `plan.md`.
- **`BRANCH`**: Auto-approves and logs `gate_bypass_reason="express_mode"` in `audit.md`.
- **`IMPLEMENT`**: Applies changes and runs configured test policy.
- **`PR`**: Opens PR and logs bypass.
- **`HANDOFF`** *(if `--handoff` passed)*: Generates `handoff.md`.
- *Note:* Mid-implement scope expansion, test failure, or blocking dependency halts that specific item (not the whole batch) for human triage.

### Step 2: Batch Summary & Survey
- Generate run report at `.devweave/express-runs/<timestamp>.md`.
- Conduct 3-question Likert batch effectiveness survey (recorded in `.devweave/feedback/_log.jsonl`).
