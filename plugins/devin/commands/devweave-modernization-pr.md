---
name: devweave-modernization-pr
description: "[Modernization Phase 7: PR] Assemble comprehensive modernization pull request package, promote durable knowledge into DevWeave graph, and prepare pr-description.md and report.md."
---

# Antigravity Modernization PR Preparation Skill (`devweave-modernization-pr`)

## Purpose
Compile the complete modernization release package, reconcile migration deltas into the persistent DevWeave knowledge graph, generate `pr-description.md` and `report.md`, and present final pull request details for human review.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- `phases.VERIFY` is `APPROVED` (Hard Gate #3 must be passed).

---

## Allowed Actions
1. Assemble end-to-end modernization artifacts (`architecture-intent.json`, `analysis.md`, `plan.md`, `verification.md`, `mappings.json`).
2. Generate structured PR description containing:
   - Modernization objectives & source context
   - Target architecture & stack choices
   - Behavioral parity & legacy validation proofs
   - Database schema migration notes
   - Test execution evidence
3. Reconcile migration mappings into DevWeave knowledge graph (`graph/knowledge-graph.json`) using `MIGRATED_TO` / `REPLACED_BY` relationships without deleting legacy node history.
4. Generate `pr-description.md` and `report.md`.
5. Prepare PR branch for review (never auto-merge).

---

## Artifacts Generated
```text
.devweave/modernization/<ID>/
â”œâ”€â”€ report.md
â””â”€â”€ pr-description.md
```

---

## State Updates
- Sets `currentPhase` = `PR`
- Sets `phases.PR` = `COMPLETED`
- Sets `status` = `COMPLETED`
- Sets `nextSuggestedPhase` = `NONE`

---

## Human Checkpoint
- Present PR description and generated report.

---

## Next Suggested Command
- None (Modernization lifecycle completed).

---

## STOP Rule
- Upon writing PR package and updating state, **STOP IMMEDIATELY**.

