---
name: devweave-implement
description: Executes surgical, plan-bound code modifications, runs automated tests, and captures execution evidence.
---

# DevWeave Implement Skill (`devweave-implement`)

## Execution Invariants
1. **Plan-Bound Modifications**: Modify ONLY files and symbols explicitly declared in `plan.md`.
2. **Scope Deviation Halt**: If unexpected conflicts invalidate the plan, stop and recommend returning to `ANALYZE`/`PLAN`. Do NOT silently expand scope.

## Step-by-Step Instructions
1. **Load Approved Plan**: Read `plan.md` tasks and acceptance checks.
2. **Apply Code Edits**: Perform incremental, bounded edits on target source files.
3. **Execute Test Suites**: Run deterministic test runners discovered in `.devweave/repository/testing.md`.
4. **Capture Evidence**: Write test outcomes to `.devweave/work-items/<ID>/test-results.json`.
5. **Update State**: Record `IMPLEMENT` status in `.devweave/work-items/<ID>/state.md`.
6. **Human Checkpoint**: Output:
   ```text
   IMPLEMENTATION COMPLETE
   Work Item: <ID>
   Files Modified: <list>
   Tests: <X passed, 0 failed>
   
   Human decision: [Approve] [Request Changes] [Stop]
   Suggested next phase: PR (Run: DevWeave-pr <ID>)
   ```
7. **Terminate Execution**: Stop and wait for user instruction.
