---
name: devweave-branch
description: Enforces hard governance gate to create an isolated Git branch from verified base before implementation begins.
---

# DevWeave Branch Skill (`devweave-branch`)

## Execution Invariants
1. **Hard Governance Gate**: Requires explicit human approval before Git branch creation.
2. **Prerequisite Guard**: `PLAN` must be in `APPROVED` status.

## Step-by-Step Instructions
1. **Check Prerequisites**: Confirm `plan.md` exists and is marked approved.
2. **Determine Branch Target**: Format branch name (e.g. `feature/<ID>`, `fix/<ID>`, `modernize/<ID>`).
3. **Prompt for Approval**:
   ```text
   Work Item: <ID>
   Target Branch: <branch-name>
   Base Branch: main / master
   Plan Status: APPROVED
   
   Authorize branch creation? [Approve] [Cancel]
   ```
4. **Execute Branch Creation**: Upon human authorization, run Git branch creation.
5. **Update State**: Record branch name and timestamp in `.devweave/work-items/<ID>/state.md`.
6. **Human Checkpoint**: Output:
   ```text
   BRANCH COMPLETE
   Active Branch: <branch-name>
   Suggested next phase: IMPLEMENT (Run: DevWeave-implement <ID>)
   ```
7. **Terminate Execution**: Stop and wait for user instruction.
