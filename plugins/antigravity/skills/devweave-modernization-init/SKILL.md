---
name: devweave-modernization-init
description: "[Modernization Phase 0: Init] Initialize the Modernization lifecycle by validating base devweave-init, capturing architecture intent, inspecting target repository without questionnaires, generating technology practice profiles, and establishing modernization workspace."
---

# Antigravity Modernization Initialization Skill (`devweave-modernization-init`)

## Purpose
Initialize a new modernization lifecycle for a legacy or target codebase by verifying base repository initialization, capturing natural language architecture declarations, inspecting existing target repositories for observed facts, generating combined engineering practice profiles, and persisting durable modernization workspace configuration.

---

## Execution Invariants
1. **Base Init Prerequisite Guard (BLOCKING)**: `devweave-modernization-init` MUST verify that base `devweave-init` has completed (`.devweave/repository/` or `.devweave/graph/knowledge-graph.json` exists). If not initialized:
   ```text
   DevWeave base initialization is required.

   Run:

   devweave-init
   ```
   **STOP IMMEDIATELY**. Do not automatically invoke `devweave-init`.
2. **Mandatory Legacy Source Gate (BLOCKING)**: If `--source <path>` is NOT explicitly provided in the command invocation, the agent **MUST NOT** proceed to inspect repositories or generate artifacts. The agent **MUST IMMEDIATELY ASK THE USER AND STOP** to wait for the user's response:
   ```text
   Please specify the path to your legacy source repository / codebase (or press Enter if modernizing code in-place within the current directory):
   ```
   Never default to the current directory without the user's explicit confirmation.
3. **Zero state.json in INIT**: `devweave-modernization-init` establishes static, declarative project configuration only. Lifecycle `state.json` is created strictly per-story inside `.devweave/modernization/stories/<ID>/state.json`.

---

## Inputs & Parameters
- `Intent`: Natural language description of the target architecture (e.g. "We are using Angular FE with Bootstrap, backend as microservices with CQRS, and MySQL database").
- `--source <path>`: (Optional) Absolute or relative path to the legacy source repository. If omitted, the agent MUST interactively ask the developer for the legacy source/codebase path.
- `--target <path>`: (Optional) Path to target repository (defaults to current working directory).

---

## Preconditions
- Base repository initialization completed (`devweave-init`).

---

## Allowed Actions
1. **Verify Base Init**: Confirm `.devweave/repository/` and `.devweave/graph/knowledge-graph.json` exist. If missing, halt with required remediation message.
2. **Parse Intent**: Parse natural language intent into structured components (`frontend`, `backend`, `database`, `implementationPolicy`).
3. **Mandatory Legacy Source Checkpoint (BLOCKING)**: If `--source` was not provided, prompt the user and wait for their input before proceeding:
   `"Please specify the path to your legacy source repository / knowledge base (or press Enter if modernizing code in-place within the current repository):"`
   - If a path is provided, validate its existence and record in `source-memory.json` with strict `READ_ONLY` access mode.
   - If empty/skipped, confirm and record the current directory as the legacy source location.
4. **Mandatory Description Prompting (Optional Input)**: Ask the developer if they have any additional architecture intent or specific instructions before processing (per Rule #7).
5. Inspect target repository if files exist (detect languages, frameworks, ORMs, build tools).
6. If target repository is empty or has insufficient code, record target architecture intent directly while marking unspecified details as `AI_DETERMINED` and unobserved facts as `UNKNOWN`. Never fabricate facts.
7. Synthesize technology practice profile across: Best Practices, Design Patterns, SOLID, Clean Code, Security, API, Database, Testing, Performance, and Anti-Patterns.
8. Initialize central `.devweave/modernization/` workspace configuration.

---

## Artifacts Generated
```text
.devweave/modernization/
├── workspace.json              <-- Target solution metadata & PM tool preference
├── architecture-intent.json    <-- Declared target architecture
├── technology-profile.json     <-- Technology & engineering practice profiles
└── source-memory.json          <-- Legacy source path & READ_ONLY access mode
```

---

## State Updates
- Project configuration established at `.devweave/modernization/`
- Sets `nextSuggestedPhase` = `CONTEXT`

---

## Human Checkpoint
- Present parsed architecture intent, detected technologies, and practice summary to the human.
- Prompt for human decision: `APPROVE` / `REQUEST_CHANGES` / `STOP`.

---

## Next Suggested Command
```text
devweave-modernization-context <ID>
```

---

## Failure Behavior
- If legacy source path is invalid or inaccessible, record error, warn user, and stop without modifying files.

---

## STOP Rule
- Upon writing artifacts and reporting the summary, **STOP IMMEDIATELY**. Do not execute the next phase automatically.
