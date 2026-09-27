---
name: devweave-modernization-init
description: "[Modernization Phase 0: Init] Autonomously initialize the Modernization lifecycle in the target workspace, linking legacy source and knowledge graph, capturing architecture intent, inspecting target solutions without questionnaires, generating Modernization & Target Technology Engineering Intelligence, and establishing modernization workspace."
---

# Cognition Devin Modernization Initialization Command (`devin run /devweave-modernization-init`)

## Purpose
Initialize a new modernization lifecycle for a legacy or target codebase by autonomously initializing target repository metadata inline (or utilizing existing), loading or linking Legacy Engineering Intelligence, capturing natural language architecture declarations, inspecting existing target solutions for observed facts without questionnaires, generating tripartite Engineering Intelligence (Legacy EI + Modernization EI + Target Technology EI) with transformation relationships (`MIGRATED_TO`, `TRANSFORMED_TO`, `SPLIT_INTO`), and persisting durable modernization workspace configuration.

---

## Execution Invariants
1. **Autonomous Target Workspace Initialization (Inline)**: `devweave-modernization-init` is fully self-contained and does NOT require running `devin run /devweave-init` beforehand. If base target repository metadata (`.devweave/repository/` or `.devweave/graph/knowledge-graph.json`) is not yet present in the current target workspace, `devweave-modernization-init` autonomously inspects the target directory inline (detecting target solutions, projects, package manifests, and initializing base knowledge graph and topology). If already initialized, it utilizes the existing target metadata directly.
2. **Mandatory Legacy Source Gate (BLOCKING)**: If `--source <path>` is NOT explicitly provided in the command invocation, the agent **MUST NOT** proceed to inspect repositories or generate artifacts. The agent **MUST IMMEDIATELY ASK THE USER AND STOP** to wait for the user's response:
   ```text
   Please specify the path to your legacy source repository / codebase (or press Enter if modernizing code in-place within the current directory):
   ```
   Never default to the current directory without the user's explicit confirmation.
   - When `--source <path>` is provided, check if the legacy repository contains `.devweave/graph/knowledge-graph.json` or `.devweave/intelligence/legacy.json`. If present, link it directly in `source-memory.json` (`"knowledgeGraphAvailable": true`, `"knowledgeGraphPath": "<path>/.devweave/graph/knowledge-graph.json"`). If not present, inspect the legacy directory structure directly.
3. **Tripartite Engineering Intelligence Architecture**:
   Modernization orchestrates three separate intelligence domains:
   - **Legacy Engineering Intelligence**: How the legacy system currently works (read-only invariant).
   - **Modernization Engineering Intelligence**: Transformation rules and behavioral preservation mappings.
   - **Target Technology Intelligence**: Modern architectural patterns and standards for target stack.
4. **Zero state.json in INIT**: `devweave-modernization-init` establishes static, declarative project configuration only. Lifecycle `state.json` is created strictly per-story inside `.devweave/modernization/stories/<ID>/state.json`.
5. **Mandatory Description Checkpoint (BLOCKING)**: Prior to executing target solution inspections, project scanning, or writing configuration files, state pre-processing transparency and ask the developer if they have any additional architecture intent, context, or specific instructions:
   ```text
   Pre-execution transparency: I'm about to:
   1. Inspect target workspace projects and solution structure
   2. Load legacy knowledge graph and source memory
   3. Synthesize Modernization and Target Technology Engineering Intelligence
   4. Write declarative configuration to .devweave/modernization/

   Do you have any additional description, context, or specific instructions for this initialization? (Optional — confirm to proceed with defaults.)
   ```
   The agent **MUST IMMEDIATELY STOP CALLING TOOLS AND YIELD THE TURN**. The agent **MUST NOT** proceed with inspection tools in the same turn. Wait for developer confirmation or custom instructions before proceeding.

---

## Inputs & Parameters
- `Intent`: Natural language description of the target architecture (e.g. "We are using Angular FE with Bootstrap, backend as microservices with CQRS, and MySQL database").
- `--source <path>`: (Optional) Absolute or relative path to the legacy source repository. If omitted, the agent MUST interactively ask the developer for the legacy source/codebase path.
- `--target <path>`: (Optional) Path to target repository (defaults to current working directory).

---

## Preconditions
- None (can be executed on empty, newly created, or existing multi-project target repositories).

---

## Allowed Actions
1. **Autonomous Target Inspection & Inline Init**: Inspect the target repository directory. If base repository metadata (`.devweave/repository/` or `.devweave/graph/knowledge-graph.json`) does not exist, initialize target topology and base knowledge graph inline from detected target solutions, manifests, or empty target state.
2. **Parse Intent**: Parse natural language intent into structured components (`frontend`, `backend`, `database`, `implementationPolicy`).
3. **Mandatory Legacy Source Checkpoint (BLOCKING)**: If `--source` was not provided, prompt the user and wait for their input before proceeding:
   `"Please specify the path to your legacy source repository / knowledge base (or press Enter if modernizing code in-place within the current repository):"`
   - If a path is provided, validate its existence and record in `source-memory.json` with strict `READ_ONLY` access mode.
   - If legacy repository has `.devweave/graph/knowledge-graph.json`, link it in `source-memory.json` (`"knowledgeGraphAvailable": true`, `"knowledgeGraphPath": "<path>/.devweave/graph/knowledge-graph.json"`).
   - If empty/skipped, confirm and record the current directory as the legacy source location.
4. **Load Legacy Engineering Intelligence**: Load `.devweave/intelligence/legacy.json` or legacy knowledge graph from the linked legacy source path, or inspect legacy repository structure.
5. **Mandatory Description Checkpoint (BLOCKING)**: State pre-processing transparency and ask the developer for additional architecture intent, constraints, or instructions. The agent **MUST IMMEDIATELY STOP CALLING TOOLS AND YIELD THE TURN**. Do NOT execute inspection tools in the same turn. Proceed only after the developer responds or confirms defaults.
6. **Inspect Target Solutions & Projects**: Detect target languages, frameworks, ORMs, build tools, solution files, and project boundaries across the target workspace.
7. **Zero Fact Fabrication**: If target repository is empty or has insufficient code, record target architecture intent directly while marking unspecified details as `AI_DETERMINED` and unobserved facts as `UNKNOWN`. Never fabricate facts.
8. **Synthesize Modernization Engineering Intelligence (`modernization-intelligence.json`)**:
   Establish component transformation mappings supporting:
   - `MIGRATED_TO`: 1-to-1 replacement
   - `REPLACED_BY`: Replaced by standard framework construct
   - `TRANSFORMED_TO`: Refactored to new paradigm
   - `SPLIT_INTO`: Decomposed into multiple microservices/classes
   - `MERGED_INTO`: Consolidated into shared abstraction
   - `PRESERVED_AS`: Maintained with minimal wrapping
   - `RETIRED`: Obsolete legacy feature omitted
   - `DEFERRED`: Postponed to subsequent phase
   - `UNKNOWN`: Pending detailed discovery
9. **Synthesize Technology Practice Profile (`technology-profile.json`)**:
   Generate practices across: Best Practices, Design Patterns, SOLID, Clean Code, Security, API, Database, Testing, Performance, and Anti-Patterns.
10. **Register in Knowledge Graph**: Add `LEGACY_TECHNOLOGY --MIGRATES_TO--> TARGET_TECHNOLOGY` directed edges.

---

## Artifacts Generated
```text
.devweave/modernization/
├── workspace.json                  <-- Target solution metadata & PM tool preference
├── architecture-intent.json        <-- Declared target architecture
├── technology-profile.json         <-- Technology & engineering practice profiles
├── modernization-intelligence.json <-- Legacy-to-target transformation rules & mappings
└── source-memory.json              <-- Legacy source path & READ_ONLY access mode
```

---

## State Updates
- Project configuration established at `.devweave/modernization/`
- Sets `nextSuggestedPhase` = `CONTEXT`

---

## Human Checkpoint
- Present parsed architecture intent, detected technologies, modernization mappings, and practice summary to the human.
- Prompt for human decision: `APPROVE` / `REQUEST_CHANGES` / `STOP`.

---

## Next Suggested Command
```text
devin run /devweave-modernization-context <ID>
```

---

## Failure Behavior
- If legacy source path is invalid or inaccessible, record error, warn user, and stop without modifying files.

---

## STOP Rule
- Upon writing artifacts and reporting the summary, **STOP IMMEDIATELY**. Do not execute the next phase automatically.
