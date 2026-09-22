---
name: devweave-context
description: Ingests work item via PM MCP or manual input, extracts requirements, scopes context to the task blast radius, and builds .devweave/work-items/<ID>/context.md.
---

# DevWeave Context Skill (`devweave-context`)

## Execution Invariants
1. **Single-Phase Execution**: Execute ONLY the CONTEXT phase. Do NOT automatically advance to ANALYZE.
2. **Zero Secret Storage**: Never write Personal Access Tokens (PATs) or credentials into artifacts.

## Step-by-Step Instructions
1. **Load Work Item**: Query configured PM MCP (Jira, ADO, GitHub, Linear) using the provided `<ID>`. If unconfigured, prompt developer to paste requirements.
2. **Context Scoping**: Inspect repository structure and identify only the relevant source zones and dependencies.
3. **Assemble Artifact**: Create or update `.devweave/work-items/<ID>/context.md`.
4. **Update State**: Record `CONTEXT` status in `.devweave/work-items/<ID>/state.md` and `.devweave/state/current.json`.
5. **Human Checkpoint**: Output the completion summary:
   ```text
   CONTEXT COMPLETE
   Work Item: <ID>
   Artifact: .devweave/work-items/<ID>/context.md
   
   Human decision: [Approve] [Request Changes] [Provide Info] [Stop]
   Suggested next phase: ANALYZE (Run: DevWeave-analyze <ID>)
   ```
6. **Terminate Execution**: Stop and wait for user instruction.
