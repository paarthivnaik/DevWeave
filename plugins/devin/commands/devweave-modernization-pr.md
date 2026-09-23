---
name: devweave-modernization-pr
description: "[Modernization Phase 7: PR] Assemble comprehensive modernization pull request package, promote durable knowledge into DevWeave graph, update audit.md, and prepare pr-description.md and report.md."
---

# Cognition Devin Modernization PR Preparation Command (`devin run /devweave-modernization-pr`)

## Purpose
Compile the complete modernization release package, reconcile migration deltas into the persistent DevWeave knowledge graph, log final PR completion into `audit.md`, generate `pr-description.md` and `report.md`, and present final pull request details for human review.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`).

---

## Preconditions
- `phases.VERIFY` is `APPROVED` (Hard Gate #3 must be passed).

---

## Allowed Actions
1. **Mandatory Description Prompting**: Ask developer for any custom PR notes, reviewers, or labels.
2. Assemble end-to-end modernization artifacts (`architecture-intent.json`, `analysis.md`, `plan.md`, `verification.md`, `mappings.json`).
3. Generate structured PR description containing:
   - Modernization objectives & source context
   - Target architecture & stack choices
   - Behavioral parity & legacy validation proofs
   - Database schema migration notes
   - Test execution evidence
4. Reconcile migration mappings into DevWeave knowledge graph (`graph/knowledge-graph.json`) using `MIGRATED_TO` / `REPLACED_BY` relationships without deleting legacy node history.
5. Generate `pr-description.md` and `report.md`.
6. Append final PR completion and graph promotion log to `.devweave/modernization/stories/<ID>/audit.md`.
7. Prepare PR branch for review (never auto-merge).

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── report.md
├── pr-description.md
└── audit.md                    <-- Final release audit log
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
- Upon writing PR package, updating `audit.md`, and updating state, **STOP IMMEDIATELY**.
