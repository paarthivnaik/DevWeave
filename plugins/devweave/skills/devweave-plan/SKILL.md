---
name: devweave-plan
description: Decomposes approved analysis into concrete, file-anchored implementation tasks with test commands and verification gates.
---

# DevWeave Plan Skill (`devweave-plan`)

## Execution Invariants
1. **Single-Phase Execution**: Execute ONLY the PLAN phase. Do NOT automatically advance to BRANCH.
2. **Implementation Contract**: Every task must cite exact files, anchors, changes, and verification checks.

## Step-by-Step Instructions
1. **Load Approved Analysis**: Read `analysis.md` and `context.md`.
2. **Decompose Tasks**: Specify atomic implementation steps with explicit file paths, symbols, changes, and test commands.
3. **Database & API Safeguards**: Explicitly specify schema migrations, API backward compatibility checks, and rollback steps.
4. **Assemble Artifact**: Write to `.devweave/work-items/<ID>/plan.md`.
5. **Update State**: Record `PLAN` status in `.devweave/work-items/<ID>/state.md`.
6. **Human Checkpoint**: Output the completion summary:
   ```text
   PLAN COMPLETE
   Work Item: <ID>
   Artifact: .devweave/work-items/<ID>/plan.md
   
   Human decision: [Approve Plan] [Request Changes] [Stop]
   Suggested next phase: BRANCH (Run: DevWeave-branch <ID>)
   ```
7. **Terminate Execution**: Stop and wait for user instruction.
