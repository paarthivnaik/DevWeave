---
name: devweave-modernization-context
description: "[Modernization Phase 1: Context] Ingest modernization scope, build bounded migration slice from legacy source, retrieve relevant knowledge graph neighborhood, and construct focused context.md."
---

# Gemini CLI Modernization Context Command (`gemini devweave-modernization-context`)

## Purpose
Construct a bounded, token-efficient migration context for the specified modernization work item by discovering relevant legacy source slices, retrieving related knowledge graph entities, loading targeted technology practices, and compiling `context.md` without loading entire legacy repositories into AI memory.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- Modernization workspace exists (`.devweave/modernization/<ID>/state.json`).
- `phases.INIT` is `COMPLETED`.

---

## Allowed Actions
1. Load `architecture-intent.json`, `technology-profile.json`, and `source-memory.json`.
2. Inspect specified migration slice in legacy source (controllers, views, models, database tables, business rules).
3. Query knowledge graph for direct dependencies and bounded 1-hop / 2-hop neighbor relationships.
4. Extract only applicable technology practices matching the slice (e.g., Angular component guidelines for UI slices, CQRS/EF Core guidelines for backend slices).
5. Compile concise `context.md` with explicit token budgeting (< 12,000 tokens).

---

## Artifacts Generated
```text
.devweave/modernization/<ID>/
├── context.md
└── migration-unit.json
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
