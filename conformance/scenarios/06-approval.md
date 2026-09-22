# Scenario 06: Approval Gate Conformance

## Objective
Verify that state progression halts at the approval gate until explicit sign-off is granted.

## Steps
1. Attempt transition from `SOLUTION_READY` to `PLANNED` without approval artifact.
2. Assert transition fails or blocks.
3. Supply valid `approval.json` conforming to `schemas/approval.schema.json`.
4. Assert transition to `APPROVED` succeeds.
