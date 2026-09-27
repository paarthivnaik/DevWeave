---
name: plan
description: [Phase 3: Plan] Decomposes approved analysis into concrete, file-anchored implementation tasks with test commands, verification gates, and audit.md logging.
---

# DevWeave Plan Skill (`devweave-plan`)

## Execution Invariants
1. **Single-Phase Execution**: Execute ONLY the PLAN phase. Do NOT automatically advance to BRANCH.
2. **Implementation Contract**: Every task must cite exact files, anchors, changes, and verification checks.
3. **Audit Invariance**: Append plan details, prompt, and approval decisions to `.devweave/work-items/<ID>/audit.md`.

## Step-by-Step Instructions
1. **Load Approved Analysis**: Read `analysis.md` and `context.md`.
2. **Decompose Tasks**: Specify atomic implementation steps with explicit file paths, symbols, changes, and test commands.
3. **Database & API Safeguards**: Explicitly specify schema migrations, API backward compatibility checks, and rollback steps.
4. **Assemble Artifact**: Write to `.devweave/work-items/<ID>/plan.md`.
5. **Update State & Audit**:
   - Record `PLAN` status in `.devweave/work-items/<ID>/state.md`.
   - Append plan creation log, task count, and human decision to `.devweave/work-items/<ID>/audit.md`.
6. **Human Checkpoint**: Output the completion summary:
   ```text
   PLAN COMPLETE
   Work Item: <ID>
   Artifact: .devweave/work-items/<ID>/plan.md
   Audit Log: .devweave/work-items/<ID>/audit.md
   
   Human decision: [Approve Plan] [Request Changes] [Stop]
   Suggested next phase: BRANCH (Run: DevWeave-branch <ID>)
   ```
7. **Terminate Execution**: Stop and wait for user instruction.
