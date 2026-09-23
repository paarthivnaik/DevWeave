---
name: status
description: [Utility - Lifecycle Status] Inspects current work-item lifecycle phase, completed artifacts, open governance gates, and suggests the next valid phase.
---

# DevWeave Status Skill (`devweave-status`)

## Execution Invariants
- Read-only inspection; does NOT alter current work-item state or files.

## Step-by-Step Instructions
1. Read `.devweave/work-items/<ID>/state.md` and `.devweave/state/current.json`.
2. Output clear status board:
   ```text
   DevWeave Status: <WORK_ITEM_ID>
   ──────────────────────────────────
   [Phase Status Board]
   ✓ CONTEXT
   ✓ ANALYZE
   ✓ PLAN
   ✓ BRANCH
   ○ IMPLEMENT (Ready)
   ○ PR (Pending)

   Current State: READY_FOR_IMPLEMENT
   Suggested Next Phase: IMPLEMENT
   Run: DevWeave-implement <ID>
   ```
