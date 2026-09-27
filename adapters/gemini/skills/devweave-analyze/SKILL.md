---
name: devweave-analyze
description: "[Phase 2: Analyze] Deep codebase archaeology, 11-dimension impact analysis, Domain Knowledge integration, bounded Knowledge Graph traversal, edge-case failure evaluation, and artifact compilation."
---

# DevWeave Analysis Skill (`devweave-analyze`)

## Purpose
Execute a comprehensive technical and architectural impact analysis for the specified work item across 11 system dimensions, joining `context.md` with **Domain Knowledge** (`.devweave/domain/knowledge.json`), bounded **Knowledge Graph** traversal (`.devweave/graph/knowledge-graph.json`), and **Engineering Intelligence** (`.devweave/intelligence/current.json`) with targeted source verification, compiling `analysis.md` and user-only `audit.md`.

---

## Inputs & Parameters
- `<ID>`: Work item ID (e.g. `TASK-001`, `98`, `FEAT-42`).

---

## Preconditions & Guards
1. **Base Init Prerequisite Guard**:
   Check if repository is initialized (`.devweave/repository/` or `.devweave/graph/knowledge-graph.json` exists).
   If not initialized:
   ```text
   DevWeave has not been initialized for this repository.

   Run:

   devweave-init

   before continuing.
   ```
   **STOP IMMEDIATELY**.
2. **Phase Boundary Guard**: Ensure `CONTEXT` is `COMPLETED` and approved. If context changed, previous analysis is `STALE` and must be regenerated.
3. **Branch & Resume Validation**:
   Inspect state for expected branch association. If expected branch differs from active Git branch, ask before proceeding:
   ```text
   Story <ID> is associated with: <expected_branch>
   Current branch: <current_branch>

   Choose:
   1. Switch to <expected_branch>
   2. Provide another branch
   3. Stop
   ```

---

## Allowed Actions & Execution Pipeline

```text
context.md (Read from disk)
    ↓
Candidate Domain Resolution (Identify domain concepts & business rules)
    ↓
Domain Knowledge Retrieval (.devweave/domain/knowledge.json)
    ↓
Bounded Knowledge Graph Traversal (Depth limits, token budget <32k tokens)
    ↓
Engineering Intelligence Resolution (.devweave/intelligence/current.json <1,500 tokens)
    ↓
Targeted Repository Source Verification (view_file on referenced symbols/paths)
    ↓
11-Dimension Impact & Edge Case Analysis
    ↓
analysis.md + state.json + audit.md
```

### 1. Mandatory Disk-First Artifact Ingestion
Before analyzing, the agent **MUST EXPLICITLY READ DISK ARTIFACTS (`view_file`)** from `.devweave/work-items/<ID>/` (`context.md`, `work-item.json`, `evidence.json`, `state.json`) and `.devweave/repository/` (`profile.md`, `layers.md`). Never rely on in-memory conversation history.

### 2. Mandatory Description Checkpoint (Optional Input)
Ask the developer if they have any additional analysis context, focus areas, or specific performance/security constraints (per Rule #7).

### 3. Domain Knowledge & Bounded Graph Traversal
- Resolve candidate domains matching the work item (e.g. `domain:billing`, `domain:prescriptions`).
- Retrieve relevant concepts, business rules, and constraints from `.devweave/domain/knowledge.json`.
- Execute **Bounded Graph Traversal** seeded by relevant domain entities:
  - Enforce strict depth limits (Depth 1-2) and node caps.
  - **NEVER inject the complete Knowledge Graph into the AI context**.
  - Extract relevant subgraph and symbol references.

### 4. Targeted Source Verification
- Traverse from graph nodes to actual source files (`view_file` on target classes, controllers, tables, and tests).
- Reconcile evidence: verify candidate claims from `evidence.json`. Unverified statements remain `UNVERIFIED` (Zero Fact Fabrication).
- If source files referenced by domain entities have changed, mark dependent entities `NEEDS_REVALIDATION`.

### 5. Deep 11-Dimension Impact Analysis
Inspect codebase across:
1. **Repository**: Projects, modules, packages, shared libraries, boundary definitions.
2. **Code**: Definitions, callers, callees, inheritance, interfaces, shared utilities.
3. **API**: Endpoints, routes, contracts, middleware, authentication, consumers.
4. **UI**: Pages, components, routes, state management, services, user flows.
5. **Data**: Databases, schemas, tables, columns, indexes, views, stored procedures, queries, migrations.
6. **Messaging**: Events, queues/topics, producers, consumers, background workers.
7. **Tests**: Unit, integration, API, UI, regression test fixtures.
8. **Configuration**: App settings, feature flags, environment configs, external dependencies.
9. **Security**: Authentication, authorization, input validation, data exposure boundaries.
10. **Operations**: Logging, monitoring, metrics, caching, scheduled jobs.
11. **Deployment**: Containerization, CI/CD pipelines, environment behavior.

### 6. Edge Cases & Failure Analysis
Evaluate boundary conditions, null/empty inputs, concurrency, duplicates, retries, timeouts, transactions, rollback feasibility, and degraded observability.

### 7. Assemble Deliverable
Write findings to `.devweave/work-items/<ID>/analysis.md` capturing domain context, graph findings, engineering rules, verified evidence, impact matrix, and risk mitigation.

### 8. User-Only Story Audit Trail (`audit.md`)
Append exclusively developer prompt, custom input, and decisions to `.devweave/work-items/<ID>/audit.md` with `Author: <User Name> <email@example.com>`.

---

## Artifacts Generated
```text
.devweave/work-items/<ID>/
├── analysis.md                 <-- Comprehensive 11-dimension impact analysis & domain context
├── state.json                  <-- Phase tracker (currentPhase: ANALYZE, status: WAITING_FOR_HUMAN)
└── audit.md                    <-- Append-only human activity audit log
```

---

## Human Checkpoint & Stop Rule
- Output summary and present human checkpoint:
  ```text
  ANALYZE COMPLETE
  Work Item: <ID>
  Artifact: .devweave/work-items/<ID>/analysis.md

  Human decision: [Approve] [Request Changes] [Stop]
  Suggested next phase: PLAN (Run: devweave-plan <ID>)
  ```
- **STOP IMMEDIATELY**. Never automatically execute `devweave-plan`.
