---
name: devweave-modernization-init
description: "[Modernization Phase 0: Init] Initialize the V1.1 Modernization lifecycle by accepting natural-language architecture intent, inspecting target repository without questionnaires, generating technology practice profiles, and establishing modernization workspace."
---

# OpenAI Codex Modernization Initialization Command (`codex run devweave-modernization-init`)

## Purpose
Initialize a new modernization lifecycle for a legacy or target codebase by capturing natural language architecture declarations, inspecting existing target repositories for observed facts, generating combined engineering practice profiles, and persisting durable modernization workspace state.

---

## Inputs & Parameters
- `Intent`: Natural language description of the target architecture (e.g. "We are using Angular FE with Bootstrap, backend as microservices with CQRS, and MySQL database").
- `--source <path>`: (Optional) Absolute or relative path to the legacy source repository. If omitted, the agent MUST interactively ask the developer for the legacy source/codebase path.
- `--target <path>`: (Optional) Path to target repository (defaults to current working directory).

---

## Preconditions
- None (can be executed on empty, existing, or multi-repo targets).

---

## Allowed Actions
1. Parse natural language intent into structured components (`frontend`, `backend`, `database`, `implementationPolicy`).
2. **Mandatory Legacy Source Prompting**: If `--source` was not provided in the command, prompt the user:
   `"Please specify the path to your legacy source repository / knowledge base (or press Enter if modernizing code in-place within the current repository):"`
   - If a path is provided, validate its existence and record in `source-memory.json` with strict `READ_ONLY` access mode.
   - If empty/skipped, confirm and record the current directory as the legacy source location.
3. **Mandatory Description Prompting (Optional Input)**: Ask the developer if they have any additional architecture intent or specific instructions before processing (per Rule #7).
4. Inspect target repository if files exist (detect languages, frameworks, ORMs, build tools).
5. If target repository is empty or has insufficient code, record target architecture intent directly while marking unspecified details as `AI_DETERMINED` and unobserved facts as `UNKNOWN`. Never fabricate facts.
6. Synthesize technology practice profile across: Best Practices, Design Patterns, SOLID, Clean Code, Security, API, Database, Testing, Performance, and Anti-Patterns.
7. Initialize central `.devweave/modernization/` workspace configuration.

---

## Artifacts Generated
```text
.devweave/modernization/
├── workspace.json              <-- Target solution metadata & PM tool preference
├── architecture-intent.json    <-- Declared target architecture
├── technology-profile.json     <-- Technology & engineering practice profiles
├── source-memory.json          <-- Legacy source path & READ_ONLY access mode
└── state.json                  <-- Central modernization project registry
```

---

## State Updates
- Sets `projectStatus` = `INITIALIZED`
- Sets `nextSuggestedPhase` = `CONTEXT`
- Sets `status` = `WAITING_FOR_HUMAN`

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
- If legacy source path is invalid or inaccessible, record error in `state.json`, warn user, and stop without modifying files.

---

## STOP Rule
- Upon writing artifacts and reporting the summary, **STOP IMMEDIATELY**. Do not execute the next phase automatically.
