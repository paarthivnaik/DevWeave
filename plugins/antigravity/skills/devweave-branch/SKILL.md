---
name: devweave-branch
description: "[Phase 4: Branch] Enforces isolated Git branch creation with preflight Git tool check, customizable branch name and base branch from verified base before implementation begins, logging to audit.md."
---

# DevWeave Branch Skill (`devweave-branch`)

## Purpose
Safely establish an isolated Git branch in the workspace to guarantee sandbox isolation and protect the main branch from unverified changes. Verifies Git installation and author identity preflight, and allows developers to specify custom branch names (e.g., `feature/99-User-Registration`, `fix/101-auth-timeout`) and source base branches (e.g., `master`, `develop`, `release/*`, `epic/*`) interactively, via command arguments, or using natural phrasing, logging all branch choices into `audit.md`.

---

## Inputs & Parameters
- `<ID>`: Work item ID (e.g. `TASK-001`, `99`).
- `--name <branch_name>` (Optional): Custom target branch name (e.g., `feature/99-User-Registration`, `fix/TASK-001-db-pool`).
- `--base <base_branch>` (Optional): Explicit base branch from which to branch (e.g., `master`, `main`, `develop`, `release/1.0`, `epic/checkout`).

### Natural Phrasing Support
The agent must recognize natural developer requests, such as:
- `"create feature/99-User Registration from master branch"`
- `"create branch feature/98-login from develop"`
- `"branch TASK-001 fix/auth-token from release/v2.0"`

---

## Preconditions & Preflight Git Check
1. `PLAN` is in `APPROVED` status.
2. **Preflight Git Tool & Identity Check**:
   - Check if Git is installed: `git --version`. If not found, direct the developer:
     ```text
     Git is not installed or not in PATH.
     Please run 'devweave-setup' or install Git before creating branches.
     ```
     and halt.
   - Check if Git author identity is configured:
     - `git config user.name`
     - `git config user.email`
   - If user identity is missing or unconfigured, prompt developer interactively:
     ```text
     Git author identity is not configured.
     Please provide your name and email for branch commits:
     - Name: 
     - Email:
     ```
     Configure with `git config user.name "<Name>"` and `git config user.email "<Email>"`.
3. Working tree is clean or verified safe (`git status`).

---

## Interactive Branch Configuration Checkpoint (Mandatory Blocking Gate)
If `--name` or `--base` are not provided on the command line or via natural phrasing, the agent **MUST NOT** make assumptions or silently create a default branch. The agent **MUST IMMEDIATELY STOP AND ASK** the developer for branch details, discovering and listing available repository branches:

```text
=======================================================
                  DEVWEAVE BRANCH SETUP
=======================================================
Work Item ID: <ID>
Plan Status:  APPROVED
Git Author:   <User Name> <user.email@example.com>

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
1. Confirm `plan.md` exists and `PLAN` status is `APPROVED`.
2. Run Preflight Git Tool & Identity verification.
3. Verify workspace working tree is clean (`git status`).
4. Resolve target branch name:
   - Use explicitly provided name from flags, natural phrasing, or prompt.
   - Fall back to standard default: `feature/<ID>` (or `fix/<ID>`).
5. Resolve base branch:
   - Use explicitly provided base branch from flags, natural phrasing, or prompt.
   - Fall back to current active branch or repository default (`main`/`master`).
6. Validate base branch exists (`git rev-parse --verify <base_branch>`).
7. Execute Git branch creation and checkout:
   ```bash
   git checkout -b <target_branch> <base_branch>
   ```
8. Update state metadata in `.devweave/state/current.json` (and `.devweave/work-items/<ID>/state.md` / `state.json`):
   - Sets `branch.name` = `<target_branch>`
   - Sets `branch.baseBranch` = `<base_branch>`
   - Sets `branch.created` = `true`
   - Sets `branch.checkedOut` = `true`
   - Sets `phases.BRANCH` = `COMPLETED`
   - Sets `nextSuggestedPhase` = `IMPLEMENT`
9. Append branch creation activity, user prompt, and resolved target/base branches to `.devweave/work-items/<ID>/audit.md`.

---

## Human Checkpoint
Output clear confirmation upon branch creation:
```text
[BRANCH COMPLETE]
Work Item:      <ID>
Active Branch:  <target_branch>
Base Branch:    <base_branch>
Author:         <User Name> <user.email@example.com>
Audit Log:      .devweave/work-items/<ID>/audit.md

Suggested next phase:
IMPLEMENT (Run: devweave-implement <ID>)
```

---

## Next Suggested Command
```text
devweave-implement <ID>
```

---

## STOP Rule
- Upon completing branch setup, logging to `audit.md`, and state persistence, **STOP IMMEDIATELY**. Do not proceed to `IMPLEMENT` automatically.
