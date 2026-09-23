---
name: devweave-modernization-context
description: "[Modernization Phase 1: Context] Ingest modernization scope, build bounded migration slice from legacy source, retrieve relevant knowledge graph neighborhood, and construct focused context.md."
---

# OpenAI Codex Modernization Context Command (`codex run devweave-modernization-context`)

## Purpose
Construct a bounded, token-efficient migration context for the specified modernization work item by discovering relevant legacy source slices, retrieving related knowledge graph entities, loading targeted technology practices, and compiling `context.md` without loading entire legacy repositories into AI memory.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- Central modernization project initialized (`.devweave/modernization/architecture-intent.json` or `.devweave/modernization/workspace.json`).

---

## Allowed Actions
1. **PII / Privacy Hard Gate**: Prompt developer to confirm the work item / user story contains no unredacted credentials or sensitive customer data.
2. **PM Tool Selection, Persistence & Work Item Intake**:
   - **Check Persisted PM Source**: Read `pmSource` from `.devweave/modernization/workspace.json` or `.devweave/workspace.json`.
   - **First-Time Run (or if `--reconfigure` / `--pm-source <source>` is provided)**:
     - Prompt developer to select the Project Management source:
       ```text
       [Modernization Context Intake: <ID>]
       Select Work Item / User Story Source:
         [1] Atlassian Jira (Jira MCP / API)
         [2] Azure DevOps Boards (ADO MCP / API)
         [3] GitHub Issues & Projects (GitHub MCP / GraphQL)
         [4] Linear (Linear MCP)
         [5] Manual Paste / Offline User Story Input

       Selection: [1 | 2 | 3 | 4 | 5]
       ```
     - Persist selected `pmSource` into central `.devweave/modernization/workspace.json`.
   - **Subsequent Runs**:
     - If `pmSource` is configured for an MCP tool (`jira`, `ado`, `github`, `linear`) and the MCP server is active, automatically connect and fetch ticket/story `<ID>` without prompting.
     - If MCP connection is unavailable or `pmSource` is `manual`, prompt developer with a structured Markdown template to paste their user story, migration requirements, and legacy screen/module targets.
   - **Mid-Stream Setup**: The developer can configure or switch MCP tools at any time via `--pm-source <source>` or by configuring MCP servers in the environment.
3. **Mandatory Description Prompting (Optional Input)**: Ask the developer if they have any additional migration scope descriptions, context, or specific instructions before processing (per Rule #7).
4. **Pre-Processing Transparency**: Clearly state the legacy slice paths, repositories, and knowledge graph entities that will be inspected.
5. **Context Assembly & Legacy Slicing**:
   - Inherit central `.devweave/modernization/architecture-intent.json`, `technology-profile.json`, and `source-memory.json` (pointing to legacy source in `READ_ONLY` mode).
   - Inspect specified migration slice in legacy source (controllers, views, models, database tables, business rules).
   - Query knowledge graph for direct dependencies and bounded 1-hop / 2-hop neighbor relationships.
   - Extract only applicable technology practices matching the slice (e.g., Angular component guidelines for UI slices, CQRS/EF Core guidelines for backend slices).
   - Initialize story directory `.devweave/modernization/stories/<ID>/` and compile concise `context.md`, `migration-unit.json`, and `state.json` with explicit token budgeting (< 12,000 tokens).

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── state.json                  <-- Story phase tracker & hard gates
├── context.md                  <-- Bounded legacy slice context
└── migration-unit.json         <-- Target legacy components
```

---

## State Updates
- Sets `currentPhase` = `CONTEXT`
- Sets `phases.CONTEXT` = `COMPLETED`
- Sets `phases.ANALYZE` = `PENDING`
- Sets `nextSuggestedPhase` = `ANALYZE`

---

## Human Checkpoint
- Present bounded migration slice and context scope.
- Confirm accuracy with human.

---

## Next Suggested Command
```text
devweave-modernization-analyze <ID>
```

---

## Failure Behavior
- If migration slice contains unresolved dependencies or missing legacy references, record open questions in `context.md` and alert user.

---

## STOP Rule
- Upon writing `context.md` and updating state, **STOP IMMEDIATELY**.
