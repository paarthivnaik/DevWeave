---
name: devweave-modernization-pr
description: "[Modernization Phase 7: PR] Assemble comprehensive modernization pull request package, orchestrate modernization review if needed, execute automated PR creation to repository management tool following human approval, promote durable knowledge into DevWeave graph, and prepare pr-description.md and report.md."
---

# Antigravity Modernization PR Preparation Skill (`devweave-modernization-pr`)

## Purpose
Compile the complete modernization release package, reconcile migration deltas into the persistent DevWeave knowledge graph, orchestrate dual-model modernization review if not already generated, log final PR completion into `audit.md`, generate `pr-description.md` and `report.md`, present pull request details for human review, and automatically execute PR creation to the target repository management tool (GitHub, Azure DevOps, GitLab).

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`).

---

## Preconditions
- `phases.VERIFY` is `APPROVED` (Hard Gate #3 must be passed).

---

## Allowed Actions
1. **Mandatory Description Prompting**: Ask developer for any custom PR notes, reviewers, or labels.
2. **Review Prerequisite & Orchestration**:
   - Check if `.devweave/modernization/stories/<ID>/review.md` exists and is `CONSENSUS_APPROVED`.
   - If missing, automatically run the Dual-Model Modernization Review (Principal Architect + Senior DBA & Security Specialist) evaluating migration completeness, SQL safety, and behavioral parity.
   - If blocking findings exist, halt and recommend remediation.
3. Assemble end-to-end modernization artifacts (`architecture-intent.json`, `analysis.md`, `plan.md`, `verification.md`, `mappings.json`).
4. Generate structured PR description containing:
   - Modernization objectives & source context
   - Target architecture & stack choices
   - Behavioral parity & legacy validation proofs
   - Database schema migration notes
   - Test execution evidence
5. Reconcile migration mappings into DevWeave knowledge graph (`graph/knowledge-graph.json`) using `MIGRATED_TO` / `REPLACED_BY` relationships without deleting legacy node history.
6. Generate `pr-description.md` and `report.md`.
7. **Human Approval Checkpoint**:
   ```text
   MODERNIZATION PR PACKAGE READY
   Story: <ID>
   Legacy Parity: VERIFIED | Tests: 100% PASS | Review: CONSENSUS_APPROVED
   Artifacts:
     - PR Description: .devweave/modernization/stories/<ID>/pr-description.md
     - Lifecycle Report: .devweave/modernization/stories/<ID>/report.md
   
   Authorize pull request creation? [Create PR] [Request Changes] [Stop]
   ```
8. **Automated Provider PR Creation (Upon Approval)**:
   - Push modernization branch upstream:
     ```bash
     git push -u origin <branch_name>
     ```
   - Invoke Provider CLI:
     - **GitHub**:
       ```bash
       gh pr create --title "Modernization <ID>: <Title>" --body-file ".devweave/modernization/stories/<ID>/pr-description.md" --base <base_branch> --head <branch_name>
       ```
     - **Azure DevOps**:
       ```bash
       az repos pr create --title "Modernization <ID>: <Title>" --description "$(Get-Content .devweave/modernization/stories/<ID>/pr-description.md -Raw)" --target-branch <base_branch> --source-branch <branch_name>
       ```
     - **Custom/Manual**: Output branch pushed confirmation and direct web URL.
   - Display live PR URL to the developer.
9. Append ONLY human developer prompts, custom PR instructions, and PR creation action with PR URL to `.devweave/modernization/stories/<ID>/audit.md`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── report.md
├── pr-description.md
└── audit.md                    <-- Updated with user activity & PR URL log
```

---

## State Updates
- Sets `currentPhase` = `PR`
- Sets `phases.PR` = `COMPLETED`
- Sets `status` = `COMPLETED`
- Sets `pr.url` = `<live_pr_url>`
- Sets `nextSuggestedPhase` = `NONE`

---

## STOP Rule
- Upon writing PR package, creating remote PR, updating `audit.md`, and updating state, **STOP IMMEDIATELY**.
