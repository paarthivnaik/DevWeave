---
name: devweave-fix-triage
description: Fix Lane Phase 1 - Rapid defect classification, reproduction sequence extraction, and initial triage ledger assembly.
---

# DevWeave Fix Triage Skill (`devweave-fix-triage`)

## Step-by-Step Instructions
1. Ingest defect report/ticket via PM MCP or manual input.
2. Classify defect zone (e.g. `API`, `UI`, `AUTH`, `DATABASE`, `PERFORMANCE`).
3. Extract explicit reproduction steps and expected vs actual behavior.
4. Output `.devweave/work-items/<ID>/triage.md`.
5. Human Checkpoint: Confirm triage classification $\to$ suggest `DevWeave-fix-diagnose <ID>`.
