---
name: devweave-analyze
description: [Phase 2: Analyze] Performs deep codebase archaeology, root-cause defect diagnosis or feature approach evaluation, and selects applicable best practices.
---

# DevWeave Analysis Skill (`devweave-analyze`)

## Execution Invariants
1. **Single-Phase Execution**: Execute ONLY the ANALYZE phase. Do NOT automatically advance to PLAN.
2. **Prerequisite Guard**: Ensure `CONTEXT` is marked `COMPLETED` and approved.

## Step-by-Step Instructions
1. **Investigate Target Code**: Inspect affected files identified in `context.md`.
2. **Technical Evaluation**:
   - **For Bugs**: Map Symptom $\to$ Evidence $\to$ Hypotheses $\to$ Root Cause $\to$ Fix Strategy.
   - **For Features**: Map Requirements $\to$ Existing Architecture $\to$ Component Reuse $\to$ Solution Strategy.
3. **Technology & Practice Binding**: Select version-aware practices from `.devweave/repository/practices.md`. If runtime versions changed, mark affected knowledge as `NEEDS_REVALIDATION`.
4. **Assemble Artifact**: Write findings to `.devweave/work-items/<ID>/analysis.md` (and `solution.md`).
5. **Update State**: Record `ANALYZE` status in `.devweave/work-items/<ID>/state.md`.
6. **Human Checkpoint**: Output the completion summary:
   ```text
   ANALYZE COMPLETE
   Work Item: <ID>
   Artifact: .devweave/work-items/<ID>/analysis.md
   
   Human decision: [Approve] [Request Changes] [Stop]
   Suggested next phase: PLAN (Run: DevWeave-plan <ID>)
   ```
7. **Terminate Execution**: Stop and wait for user instruction.
