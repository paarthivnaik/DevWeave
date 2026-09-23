---
name: modernization-init
description: "[Modernization Phase 0: Init] Initialize the V1.1 Modernization lifecycle by accepting natural-language architecture intent, inspecting target repository without questionnaires, generating technology practice profiles, and establishing modernization workspace."
---

# GitHub Copilot Modernization Initialization Command (`@devweave /modernization-init`)

## Purpose
Initialize a new modernization lifecycle for a legacy or target codebase by capturing natural language architecture declarations, inspecting existing target repositories for observed facts, generating combined engineering practice profiles, and persisting durable modernization workspace state.

---

## Inputs & Parameters
- `Intent`: Natural language description of the target architecture (e.g. "We are using Angular FE with Bootstrap, backend as microservices with CQRS, and MySQL database").
- `--source <path>`: (Optional) Absolute or relative path to the legacy source repository.
- `--target <path>`: (Optional) Path to target repository (defaults to current working directory).

---

## Preconditions
- None (can be executed on empty, existing, or multi-repo targets).

---

## Allowed Actions
1. Parse natural language intent into structured components (`frontend`, `backend`, `database`, `implementationPolicy`).
2. Inspect target repository if files exist (detect languages, frameworks, ORMs, build tools).
3. If target repository is empty or has insufficient code, record target architecture intent directly while marking unspecified details as `AI_DETERMINED` and unobserved facts as `UNKNOWN`. Never fabricate facts.
4. If legacy source path is specified, validate path and enforce `READ_ONLY` access mode in `source-memory.json`.
5. Synthesize technology practice profile across: Best Practices, Design Patterns, SOLID, Clean Code, Security, API, Database, Testing, Performance, and Anti-Patterns.
6. Initialize `.devweave/modernization/<ID>/` workspace.

---

## Artifacts Generated
```text
.devweave/modernization/<ID>/
├── workspace.json
├── architecture-intent.json
├── technology-profile.json
├── source-memory.json
└── state.json
```

---

## State Updates
- Sets `currentPhase` = `INIT`
- Sets `phases.INIT` = `COMPLETED`
- Sets `phases.CONTEXT` = `PENDING`
- Sets `nextSuggestedPhase` = `CONTEXT`
- Sets `status` = `WAITING_FOR_HUMAN`

---

## Human Checkpoint
- Present parsed architecture intent, detected technologies, and practice summary to the human.
- Prompt for human decision: `APPROVE` / `REQUEST_CHANGES` / `STOP`.

---

## Next Suggested Command
```text
modernization-context <ID>
```

---

## Failure Behavior
- If legacy source path is invalid or inaccessible, record error in `state.json`, warn user, and stop without modifying files.

---

## STOP Rule
- Upon writing artifacts and reporting the summary, **STOP IMMEDIATELY**. Do not execute the next phase automatically.
