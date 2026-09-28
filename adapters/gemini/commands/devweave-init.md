---
name: devweave-init
description: "[Phase 0: Init] Initialize DevWeave in the repository by autonomously detecting technology stack across 11 dimensions, establishing separate Current vs Legacy Engineering Intelligence, OBSERVED conventions, knowledge graph, and multi-repository topology."
---

# Gemini CLI Initialization Command (`gemini devweave-init`)

## Purpose
Autonomously inspect the target workspace repository, detect its complete technology stack across 11 evidence-based dimensions, classify technologies into CURRENT vs. LEGACY, and establish concrete, pin-to-pin Engineering Intelligence (Current EI, Legacy EI, OBSERVED repository conventions, JSON knowledge graph, physical-to-logical layers, and end-to-end request flow) without modifying application code.

---

## Execution Workflow

### Step 0: Pre-Processing Transparency & Mandatory Description Checkpoint (BLOCKING)
Before executing any inspections, file modifications, or tool calls:
1. Clearly state what you are about to do (inspections across 11 dimensions, directory layout, zero code modifications).
2. Interactively ask the developer:
   ```text
   Pre-execution transparency: I'm about to:
   1. Inspect repository manifests, project files, directory layout across 11 technology dimensions
   2. Classify technologies (CURRENT vs LEGACY)
   3. Generate pin-to-pin layer map, request flow, and knowledge graph
   4. Write all artifacts to .devweave/ — zero application code modification

   Do you have any additional description, context, or specific instructions for this initialization? (Optional — confirm to proceed with defaults.)
   ```
3. **CRITICAL EXECUTION GUARD (BLOCKING)**:
   - The agent **MUST IMMEDIATELY STOP CALLING TOOLS AND YIELD THE TURN**.
   - The agent **MUST NOT** proceed to tool calls or autonomous inspection in the same turn.
   - Wait for the developer's explicit response or confirmation before proceeding to Step 1.

---

### Step 1: 11-Dimension Technology Detection & Evidence Citation
Execute targeted inspection of repository manifests, project files, lockfiles, directory layouts, and configuration across 11 dimensions:
1. **Programming Languages & Versions**: Detect languages present with evidence citations (`file`, `reason`) and confidence scores (`HIGH`, `MEDIUM`, `LOW`).
2. **Frameworks & Versions**: Detect active web, ORM, and UI frameworks.
3. **Libraries & Package Managers**: Detect package managers and direct dependencies.
4. **Databases & ORMs**: Detect data stores and ORM mappings.
5. **Cloud Infrastructure**: Detect cloud platforms from templates and SDK configurations.
6. **Messaging & Event Streaming**: Detect message brokers and queues.
7. **Testing Frameworks**: Detect native test runners and assertion frameworks.
8. **Build Systems**: Detect build toolchains and executable compilation commands.
9. **Deployment & CI/CD**: Detect continuous integration and deployment pipelines.
10. **Architecture Indicators**: Detect system architecture patterns (Clean Architecture, CQRS, Hexagonal, Monolith, Microservices).
11. **Legacy Technologies**: Identify legacy or end-of-life frameworks (.NET Framework <= 4.8, AngularJS, Python 2, Java <= 8, legacy scripts).

### Step 2: Technology Classification & Lifecycle Partitioning
Classify all detected technologies into:
- `CURRENT`: Actively supported, modern technologies aligned with target standards.
- `LEGACY`: Outdated frameworks requiring isolated maintenance or modernization.
- **Invariance**: Observed legacy practices are documented as `OBSERVED` facts and **MUST NOT** automatically become recommended best practices for modern development.

---

### Step 3: Pin-to-Pin Architecture, Request Flow & Knowledge Graph Synthesis
1. **Physical-to-Logical Layer Mapping (`layers.md`)**: Map exact directories to architectural tiers.
2. **Concrete End-to-End Request Flow (`request-flow.md`)**: Generate request execution trace and sequence diagram.
3. **JSON Knowledge Graph (`graph/knowledge-graph.json`)**: Synthesize declarative graph connecting `project`, `technology`, `standard`, `policy`, `skill`, `convention`, `layer`, `file`, `controller`, `service_class`, `repository_class`, `table`, and `event` nodes with `USES`, `HAS_STANDARD`, `HAS_SKILL`, `HAS_POLICY`, `HAS_VERSION`, `CONTAINS`, `CALLS`, `QUERIES`, `MUTATES`, `PUBLISHES` edges.

---

### Step 4: Establish Engineering Intelligence Directory & Artifacts
Create or update standardized `.devweave/` intelligence structure:
```text
.devweave/
├── intelligence/
│   ├── current.json         # Active standards, policies, skills, patterns, anti-patterns
│   ├── legacy.json          # Legacy inventory & constraints (OBSERVED only, not best practice)
│   ├── conventions.json     # Repository conventions (.editorconfig, linters, naming) - OBSERVED
│   └── history/             # Immutable archive of prior rule versions
├── repository/
│   ├── profile.md           # 5-Layer classification & repository overview
│   ├── technologies.md      # Primary & secondary runtimes with evidence citations
│   ├── frameworks.md        # Detected frameworks, ORMs, and UI libraries
│   ├── dependencies.md      # Package manager & dependency lockfile status
│   ├── build.md             # Deterministic build commands and build targets
│   ├── testing.md           # Test runners, single-test commands, coverage flags
│   ├── architecture.md      # Comprehensive system topology & component layout
│   ├── layers.md            # Pin-to-pin physical-to-logical layer mapping
│   ├── request-flow.md      # End-to-end request/execution trace & sequence diagram
│   ├── integrations.md      # External APIs, database connections, and event queues
│   └── practices.md         # Stack-aware coding conventions and anti-patterns
├── graph/
│   └── knowledge-graph.json # Declarative JSON Knowledge Graph (Nodes & Edges)
├── knowledge/
│   └── conventions.md       # Discovered repo conventions & lint rules
└── state/
    └── current.json         # AI-DLC lifecycle state, token usage, and gate status
```

---

### Step 5: Natural-Language Rule Creation and Versioned Updates
When developers provide natural language rules (e.g. `gemini devweave-init --rule "<prompt>"` or in conversation):
1. **Analyze Intent**: Parse natural language prompt into rule type, scope, technology, severity, statement, and rationale.
2. **Generate Structured Proposal (DRAFT)**: Produce validated `EI-*` proposal.
3. **Diff & Conflict Detection**: Verify no collision with higher-priority organizational standards.
4. **Mandatory Human Approval Gate**: Present proposed rule and diff to developer for explicit approval (`APPROVE` / `REJECT`). An LLM proposal must **NEVER** silently activate a mandatory policy.
5. **Historical Retention**: Archive old version to `.devweave/intelligence/history/` and increment version (`v1` &rarr; `v2`). Historical versions are **never silently overwritten**.
6. **Activation**: Persist rule as `ACTIVE` in `.devweave/intelligence/current.json`.

---

### Step 6: Safety & Token Efficiency Invariants
1. **Zero Application Modification**: `devweave-init` must NOT modify application source code, business logic, configuration files, or database schemas.
2. **Token Efficiency**: Inspect only manifests and structure; do NOT read whole repository codebases into context.
3. **Evidence-Based Only**: Never claim a technology exists unless concrete repository evidence supports it.
4. **Zero Fact Fabrication**: For unobserved or unspecified attributes, mark as `UNKNOWN` or `AI_DETERMINED`.

---

### Step 7: Report Initialization Summary
Present the structured initialization summary to the developer:
```text
DevWeave Engineering Intelligence initialization completed.

Repository: <repository-name>
Topology: <monorepo / single-service / multi-service>
Current Technologies: <detected modern technologies with versions & evidence>
Legacy Technologies: <detected legacy technologies, or 'None detected'>
Engineering Intelligence: Emitted current.json, legacy.json, conventions.json under .devweave/intelligence/
Knowledge Graph: Mapped pin-to-pin with technology & standard nodes (graph/knowledge-graph.json)
Architecture & Flow: layers.md, request-flow.md generated

DevWeave is ready for your instruction.
Run: gemini devweave-context <WorkItemId>
```
