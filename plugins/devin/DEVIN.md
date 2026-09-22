# DevWeave AI-DLC Playbook for Cognition Devin

Devin autonomous execution playbook for DevWeave AI-DLC:
1. **Structured Playbook Execution**: Follow the 7-phase workflow deterministically.
2. **Human Gates & Checkpoints**: Pause and present human checkpoints at Phase 4 (Branch), Phase 6 (PR Review), and Phase 7 (PR).
3. **Plan-Bound Changes**: Apply surgical diffs strictly corresponding to plan.md.
4. **Dual-Model Code & SQL Review**: Evaluate system architecture, downstream impact, SQL table locks, and cascading failures.
5. **Durable Knowledge Base**: Populate and reference .devweave/domains/ for 90%+ token reduction.