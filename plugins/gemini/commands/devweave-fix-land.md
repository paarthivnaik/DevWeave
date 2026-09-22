---
name: devweave-fix-land
description: "[Fix Lane - Phase 3: Land] Branch from verified base, apply minimal fix, execute regression test suite, run dual-model collective review, and assemble fix PR."
---

# DevWeave Fix Land Skill (`devweave-fix-land`)

## Step-by-Step Instructions
1. Request human authorization to create fix branch (`fix/<ID>`).
2. Apply surgical fix diffs declared in `diagnosis.md`.
3. Execute automated test runners and targeted regression sweep.
4. Verify defect resolution and compile `.devweave/work-items/<ID>/fix-evidence.md`.
5. Execute **Dual-Model Collective Code Review** (Model A: Logic/Regression, Model B: Security/Side Effects).
6. Human Checkpoint: Hard Gate $\to$ Authorize fix PR creation.
