---
name: devweave-modernization-branch
description: "[Modernization Phase 4: Branch] Enforce isolated workspace branching with customizable branch name and base branch prior to executing modernization code modifications, protecting legacy source and target main branches, and logging to audit.md."
---

# Antigravity Modernization Branch Skill (`devweave-modernization-branch`)

## Purpose
Safely establish an isolated Git branch in the target workspace to guarantee sandbox isolation and protect the main branch and legacy source from unverified changes. Allows developers to specify custom branch names (e.g. `feature/99-User-Registration`) and source base branches (e.g. `master`, `develop`, `release/*`, `epic/*`) interactively or via command arguments, logging all branch choices into `audit.md`.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`).
- `--name <branch_name>` (Optional): Explicit target branch name (e.g., `feature/99-User-Registration`, `feat/MOD-001-auth`).
- `--base <base_branch>` (Optional): Explicit base branch from which to branch (e.g., `master`, `main`, `develop`, `release/2.4`, `epic/checkout`).

### Natural Phrasing Support
The agent must recognize natural developer requests, such as:
- `"create feature/99-User Registration from master branch"`
- `"create branch feature/98-login from develop"`
- `"branch MOD-001 feat/payment from release/v1.0"`

---

## Preconditions
- `phases.PLAN` is `APPROVED` (Hard Gate #2 must be passed).
- Target repository working tree is clean or verified safe.

---

## Interactive Branch Configuration Checkpoint (Mandatory Blocking Gate)
If `--name` or `--base` are not provided on the command line or via natural phrasing, the agent **MUST NOT** make assumptions or silently create a default branch. The agent **MUST IMMEDIATELY STOP AND ASK** the developer for branch details, discovering and listing available repository branches:

```text
=======================================================
           DEVWEAVE MODERNIZATION BRANCH SETUP
=======================================================
Work Item ID: <ID>
Plan Status:  APPROVED

Detected Repository Branches:
- master / main (Production/Default)
- develop (Development Integration)
- release/* (Release Tracks)
- epic/* (Feature Epics)

Please specify your branch configuration:
1. Target Branch Name: (e.g., feature/<ID>-User-Registration, fix/<ID>-xxx)
2. Base / Source Branch: (e.g., master, develop, epic/xxx, release/2.4)

Confirm:
- Do you want to proceed with creating and checking out this branch? (Yes/No)
=======================================================
```

---

## Allowed Actions
1. Verify target repository clean state (`git status`).
2. Resolve target branch name:
   - Use explicitly provided name from flags, natural phrasing, or prompt.
   - Fall back to standard default: `devweave/modernization/<ID>`.
3. Resolve base branch:
   - Use explicitly provided base branch from flags, natural phrasing, or prompt.
   - Fall back to current active branch or repository default (`main`/`master`).
4. Validate base branch exists (`git rev-parse --verify <base_branch>`).
5. Create and switch to the target modernization branch:
   ```bash
   git checkout -b <target_branch> <base_branch>
   ```
6. Verify legacy source repository configured in `source-memory.json` remains untouched and read-only (`READ_ONLY` invariant).
7. Record branch metadata in `.devweave/modernization/stories/<ID>/state.json`.
8. Append branch creation activity, user input/prompt, resolved target branch, and base branch to `.devweave/modernization/stories/<ID>/audit.md`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── state.json                  <-- Updated with branch metadata
└── audit.md                    <-- Updated with branch creation log
```

---

## State Updates
- Sets `currentPhase` = `BRANCH`
- Sets `phases.BRANCH` = `COMPLETED`
- Sets `branch.name` = `<target_branch>`
- Sets `branch.baseBranch` = `<base_branch>`
- Sets `branch.created` = `true`
- Sets `branch.checkedOut` = `true`
- Sets `phases.IMPLEMENT` = `PENDING`
- Sets `nextSuggestedPhase` = `IMPLEMENT`

---

## Human Checkpoint
Output clear confirmation upon branch creation:
```text
[BRANCH COMPLETE]
Work Item:      <ID>
Active Branch:  <target_branch>
Base Branch:    <base_branch>
Repository:     <target_repo>
Legacy Source:  READ_ONLY (Untouched)

Suggested next command:
devweave-modernization-implement <ID>
```

---

## Next Suggested Command
```text
devweave-modernization-implement <ID>
```

---

## STOP Rule
- Upon completing branch setup, logging to `audit.md`, and state persistence, **STOP IMMEDIATELY**. Do not proceed to `IMPLEMENT` automatically.
