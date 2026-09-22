---
name: devweave-improve
description: Maintainer-facing analysis tool that reads survey friction logs and phase abort rates to propose specific improvements to plugin skills and rules.
---

# DevWeave Improvement Proposer Skill (`devweave-improve`)

## Purpose
Analyzes developer survey feedback from `.devweave/feedback/_log.jsonl` and correlates free-text friction signals with phase abort rates in `audit.md` to propose targeted updates to DevWeave skills, templates, or rules.

---

## Behavior Invariants
1. **Propose-Only**: Outputs a structured proposal document at `.devweave/improvements/<DATE>.md`.
2. **Zero Automatic Edits**: Never alters plugin files automatically; maintainers review proposals before merging.

---

## Analysis Workflow
1. Clusters free-text friction responses into phase buckets (Context, Analysis, Planning, Branching, Implementation, PR).
2. Cross-references abort and failure spikes to identify bottleneck commands.
3. Formulates actionable recommendations with exact prompt/rule diff proposals.
