---
name: devweave-implement
description: "[Phase 5: Implement] Executes surgical, plan-bound code modifications adhering to stack-aware naming conventions and coding standards, runs automated tests, and captures execution evidence."
---

# DevWeave Implement Skill (`devweave-implement`)

## Execution Invariants
1. **Plan-Bound Modifications**: Modify ONLY files and symbols explicitly declared in `plan.md`.
2. **Stack-Aware Standards**: Strictly adhere to the detected ecosystem's naming conventions, typing rules, and coding standards recorded in `.devweave/repository/practices.md` and `.editorconfig`.
3. **Scope Deviation Halt**: If unexpected conflicts invalidate the plan, stop and recommend returning to `ANALYZE`/`PLAN`. Do NOT silently expand scope.

## Step-by-Step Instructions
1. **Load Approved Plan & Stack Standards**: Read `plan.md` tasks, acceptance checks, and `.devweave/repository/practices.md`.
2. **Apply Code Edits**: Perform incremental, bounded edits on target source files strictly matching repository style (e.g. PascalCase for C#, camelCase for TS, snake_case for Python, explicit errors for Go, RAII for Rust/C++).
3. **Execute Test Suites**: Run deterministic test runners discovered in `.devweave/repository/testing.md`.
4. **Compute Graph Delta & Capture Evidence**:
   - Extract newly introduced/modified symbols, dependencies, and database schemas.
   - Write task graph patch to `.devweave/work-items/<ID>/graph-delta.json`.
   - Write test outcomes to `.devweave/work-items/<ID>/test-results.json`.
5. **Update State**: Record `IMPLEMENT` status in `.devweave/work-items/<ID>/state.md`.
6. **Human Checkpoint**: Output:
   ```text
   IMPLEMENTATION COMPLETE
   Work Item: <ID>
   Files Modified: <list>
   Graph Delta: Generated (.devweave/work-items/<ID>/graph-delta.json)
   Standards Adherence: VERIFIED (Stack Conventions Checked)
   Tests: <X passed, 0 failed>
   
   Human decision: [Approve] [Request Changes] [Stop]
   Suggested next phase: Review (Run: devweave-pr-review <ID>)
   ```
7. **Terminate Execution**: Stop and wait for user instruction.
