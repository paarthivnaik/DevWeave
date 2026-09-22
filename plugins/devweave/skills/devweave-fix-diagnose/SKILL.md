---
name: devweave-fix-diagnose
description: Fix Lane Phase 2 - Adversarial root-cause investigation, competing hypotheses evaluation, and minimal-change fix plan.
---

# DevWeave Fix Diagnose Skill (`devweave-fix-diagnose`)

## Step-by-Step Instructions
1. Inspect target source files, stack traces, and logs.
2. Evaluate competing root-cause hypotheses (Hypothesis A vs Hypothesis B).
3. Formulate minimal-change surgical fix plan.
4. Output `.devweave/work-items/<ID>/diagnosis.md`.
5. Human Checkpoint: Confirm diagnosis and fix plan $\to$ suggest `DevWeave-fix-land <ID>`.
