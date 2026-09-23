---
name: devweave-modernization-branch
description: "[Modernization Phase 4: Branch] Enforce isolated workspace branching prior to executing modernization code modifications, protecting legacy source and target main branches."
---

# Cognition Devin Modernization Branch Command (`devin run /devweave-modernization-branch`)

## Purpose
Safely establish an isolated Git branch (e.g., `devweave/modernization/<ID>`) in the target workspace to guarantee sandbox isolation and protect the main branch and legacy source from unverified changes.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- `phases.PLAN` is `APPROVED` (Hard Gate #2 must be passed).
- Target repository working tree is clean or verified safe.

---

## Allowed Actions
1. Verify target repository clean state (`git status`).
2. Generate standardized branch name: `devweave/modernization/<ID>`.
3. Create and switch to the target modernization branch.
4. Verify legacy source repository remains untouched and read-only.
5. Record branch metadata in `state.json`.

---

## Artifacts Generated
- Branch creation recorded in `.devweave/modernization/<ID>/state.json`.

---

## State Updates
- Sets `currentPhase` = `BRANCH`
- Sets `phases.BRANCH` = `COMPLETED`
- Sets `branch.name` = `devweave/modernization/<ID>`
- Sets `branch.created` = `true`
- Sets `branch.checkedOut` = `true`
- Sets `phases.IMPLEMENT` = `PENDING`
- Sets `nextSuggestedPhase` = `IMPLEMENT`

---

## Human Checkpoint
- Report branch checkout confirmation.

---

## Next Suggested Command
```text
devweave-modernization-implement <ID>
```

---

## STOP Rule
- Upon completing branch setup, **STOP IMMEDIATELY**.
