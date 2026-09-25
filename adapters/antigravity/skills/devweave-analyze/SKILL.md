---
name: devweave-analyze
description: "[Phase 2: Analyze] Deep codebase archaeology, 11-dimension impact analysis, edge-case failure evaluation, branch resume verification, and artifact compilation."
---

# DevWeave Analysis Skill (`devweave-analyze`)

## Purpose
Execute a comprehensive technical and architectural impact analysis for the specified work item across 11 system dimensions and edge cases, validating active Git branch alignment, leveraging the JSON knowledge graph without context bloat, and compiling `analysis.md` and user-only `audit.md`.

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

## Allowed Actions

### 1. Mandatory Disk-First Artifact Ingestion
Before analyzing, the agent **MUST EXPLICITLY READ DISK ARTIFACTS (`view_file`)** from `.devweave/work-items/<ID>/` (`context.md`, `work-item.json`, `state.json`) and `.devweave/repository/` (`profile.md`, `layers.md`). Never rely on in-memory conversation history.

### 2. Mandatory Description Prompting (Optional Input)
Ask the developer if they have any additional analysis context, focus areas, or specific performance/security constraints (per Rule #7).

### 3. Pre-Processing Transparency
State clearly which modules, service boundaries, database objects, and API endpoints will be inspected.

### 3. Deep 11-Dimension Impact Analysis
Inspect codebase using targeted knowledge graph lookups and source reading across:
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

### 4. Edge Cases & Failure Analysis
Evaluate boundary conditions, null/empty inputs, concurrency, duplicates, retries, timeouts, transactions, rollback feasibility, and degraded observability.

### 5. Assemble Deliverable
Write findings to `.devweave/work-items/<ID>/analysis.md` capturing architecture impact, change boundaries, test specifications, and risk mitigation.

### 6. User-Only Story Audit Trail (`audit.md`)
Append exclusively developer prompt, custom input, and decisions to `.devweave/work-items/<ID>/audit.md` with `Author: <User Name> <email@example.com>`.

---

## Artifacts Generated
```text
.devweave/work-items/<ID>/
├── analysis.md                 <-- Comprehensive 11-dimension impact analysis
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
