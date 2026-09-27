---
name: devweave-handoff
description: [Utility - Team Handoff] Generates a durable handoff.md package capturing decisions, test results, open issues, and implementation summaries for teammates.
---

# DevWeave Handoff Skill (`devweave-handoff`)

## Step-by-Step Instructions
1. Load work-item artifacts (`context.md`, `analysis.md`, `plan.md`, `test-results.json`, `verification.md`).
2. Synthesize into `.devweave/work-items/<ID>/handoff.md`:
   - Work Item Summary & Acceptance Status
   - Architectural Decisions & Trade-offs
   - Modified Components & Test Verification Evidence
   - Known Limitations & Next Steps
3. Present handoff package to user.
