---
name: devweave-branch
description: "[Phase 4: Branch] Enforces isolated Git branch creation with customizable branch name and base branch from verified base before implementation begins."
---

# GitHub Copilot DevWeave Branch Command (`@devweave /branch`)

## Purpose
Safely establish an isolated Git branch in the workspace to guarantee sandbox isolation and protect the main branch from unverified changes. Allows developers to specify custom branch names (e.g., `feature/99-User-Registration`, `fix/101-auth-timeout`) and source base branches (e.g., `master`, `develop`, `release/*`, `epic/*`) interactively, via command arguments, or using natural phrasing.

---

## Inputs & Parameters
- `<ID>`: Work item ID (e.g. `TASK-001`, `99`).
- `--name <branch_name>` (Optional): Custom target branch name (e.g., `feature/99-User-Registration`, `fix/TASK-001-db-pool`).
- `--base <base_branch>` (Optional): Explicit base branch from which to branch (e.g., `master`, `main`, `develop`, `release/1.0`, `epic/checkout`).

### Natural Phrasing Support
Recognizes natural instructions such as:
- `"create feature/99-User Registration from master branch"`
- `"create branch feature/98-login from develop"`
- `"branch TASK-001 fix/auth-token from release/v2.0"`

---

## Preconditions
- `PLAN` is in `APPROVED` status.
- Working tree is clean or verified safe.

---

## Interactive Branch Configuration Checkpoint
If `--name` or `--base` are not provided on the command line or via natural phrasing, prompt the developer:

```text
=======================================================
                  DEVWEAVE BRANCH SETUP
=======================================================
Work Item ID: <ID>
Plan Status:  APPROVED

Please specify or confirm your branch configuration:
1. Target Branch Name: [Default: feature/<ID> (or fix/<ID>) | e.g., feature/99-User-Registration]
2. Base Branch:        [Default: <current_active_branch> | e.g., master, develop, epic/xxx]

Provide your branch name and base branch (or confirm defaults):
Example: "create feature/99-User-Registration from master"
=======================================================
```

---

## Allowed Actions
1. Confirm `plan.md` exists and `PLAN` status is `APPROVED`.
2. Verify workspace working tree is clean (`git status`).
3. Resolve target branch name (from flags, natural phrasing, prompt, or default `feature/<ID>`).
4. Resolve base branch (from flags, natural phrasing, prompt, or default active branch / `main` / `master`).
5. Validate base branch exists (`git rev-parse --verify <base_branch>`).
6. Execute Git branch creation and checkout:
   ```bash
   git checkout -b <target_branch> <base_branch>
   ```
7. Update state metadata in `.devweave/state/current.json` (and `.devweave/work-items/<ID>/state.md` / `state.json`):
   - Sets `branch.name` = `<target_branch>`
   - Sets `branch.baseBranch` = `<base_branch>`
   - Sets `branch.created` = `true`
   - Sets `branch.checkedOut` = `true`
   - Sets `phases.BRANCH` = `COMPLETED`
   - Sets `nextSuggestedPhase` = `IMPLEMENT`

---

## Human Checkpoint
Output clear confirmation upon branch creation:
```text
[BRANCH COMPLETE]
Work Item:      <ID>
Active Branch:  <target_branch>
Base Branch:    <base_branch>

Suggested next phase:
IMPLEMENT (Run: @devweave /implement <ID>)
```

---

## Next Suggested Command
```text
@devweave /implement <ID>
```

---

## STOP Rule
- Upon completing branch setup and state persistence, **STOP IMMEDIATELY**.
