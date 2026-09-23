# DevWeave Architecture & Internal Mechanics: How It Works

> **"Less Tokens. More Work. Lower Bill."**

This document provides a deep, pin-to-pin architectural explanation of how DevWeave transforms AI coding assistants from chaotic, expensive chat agents into disciplined, deterministic, cost-efficient software engineers.

---

## 📑 Table of Contents
1. [The Problem: The Chaos of Unstructured AI Coding](#1-the-problem-the-chaos-of-unstructured-ai-coding)
2. [The Solution: Declarative AI-DLC Architecture](#2-the-solution-declarative-ai-dlc-architecture)
3. [Universal Interaction Rules](#3-universal-interaction-rules)
4. [The Declarative State Machine (`.devweave/state/current.json`)](#4-the-declarative-state-machine)
5. [Phase-by-Phase Internal Mechanics](#5-phase-by-phase-internal-mechanics)
6. [Test Intelligence Engine](#6-test-intelligence-engine)
7. [V1.1 Modernization Architecture & Mechanics](#7-v11-modernization-architecture--mechanics)
8. [Stage-Based Model Routing Engine](#8-stage-based-model-routing-engine)
9. [Dynamic Technology Revalidation Engine](#9-dynamic-technology-revalidation-engine)
10. [Durable Knowledge Caching (Why 0-Token Rediscovery Works)](#10-durable-knowledge-caching)
11. [Automated Daily Sync Engine (24-Hour TTL)](#11-automated-daily-sync-engine)
12. [Empirical Performance & Cost Benchmarks](#12-empirical-performance--cost-benchmarks)

---

## 1. The Problem: The Chaos of Unstructured AI Coding

When an engineer prompts a standard AI coding assistant without a structured lifecycle, the agent operates in an unstructured loop:

```mermaid
flowchart TD
    subgraph CHAOS["Unstructured AI Coding Assistant"]
        U1["Reads whole repo into context<br><i>(Explodes 100k+ tokens)</i>"] --> U2["Re-discovers tech stack every turn<br><i>(Repeats identical work)</i>"]
        U2 --> U3["Modifies un-scoped files<br><i>(Side effects & regressions)</i>"]
        U3 --> U4["Self-reviews own code<br><i>(Hallucinates passing status)</i>"]
        U4 --> U5["Fails silently on table locks & contracts<br><i>(Production outages)</i>"]
    end
```

### The 4 Major Failure Modes of Unstructured AI:
1. **Context Window Waste**: Re-reading file trees and lockfiles on every prompt burns 80,000+ tokens per task.
2. **Context Drift & Hallucination**: Without an immutable plan, agents drift into modifying unrelated files.
3. **Self-Review Bias**: An agent that generates a bug rarely catches its own logical blindspots.
4. **Runaway Autonomous Loops**: Agents loop infinitely when trying to fix compiler or test failures, consuming hundreds of dollars in API credits.

---

## 2. The Solution: Declarative AI-DLC Architecture

DevWeave introduces **Declarative AI-DLC (AI-Driven Development Lifecycle)**. It treats software development as a deterministic state machine enforced through declarative artifacts:

```mermaid
flowchart LR
    P0["<b>Phase 0: Init</b><br>5-Layer Discovery"] --> P1["<b>Phase 1: Context</b><br>PII Gate & Blast Radius"]
    P1 --> P2["<b>Phase 2: Analyze</b><br>Architecture & Contracts"]
    P2 --> P3["<b>Phase 3: Plan</b><br>Atomic Tasks"]
    P3 --> P4["<b>Phase 4: Branch</b><br>Git Isolation [GATE]"]
    P4 --> P5["<b>Phase 5: Implement</b><br>Plan-Bound Coding"]
    P5 --> P6["<b>Phase 6: Review</b><br>Dual-Model Consensus [GATE]"]
    P6 --> P7["<b>Phase 7: PR</b><br>Knowledge Promotion [GATE]"]
```

---

## 3. Universal Interaction Rules

DevWeave operates under two invariant principles for every interaction:

1. **Mandatory Description Prompting (Optional Input)**:
   - Before executing any phase, DevWeave must prompt the user: *"Do you have any additional description, architectural constraints, or specific instructions for this phase?"*
   - Providing input is optional; if the user provides none, DevWeave continues with standard defaults.
2. **Pre-Processing Transparency ("State Intent Before Action")**:
   - Before inspecting or modifying files, running builds, or executing tests, DevWeave explicitly declares its planned actions, target files, and objectives.

---

## 4. The Declarative State Machine

All DevWeave state is stored transparently in your Git repository under `.devweave/state/current.json` (for standard tasks) and `.devweave/modernization/<ID>/state.json` (for modernization tasks). There are **zero background servers or runtime daemons**.

```json
{
  "$schema": "https://devweave.org/schemas/v1/state.json",
  "task_id": "AUTH-101",
  "profile": "FEATURE",
  "current_phase": "IMPLEMENT",
  "status": "IN_PROGRESS",
  "gates": {
    "pii_privacy_gate": "PASSED",
    "branch_gate": "PASSED",
    "test_verification_gate": "PENDING",
    "human_review_gate": "PENDING"
  },
  "token_usage": {
    "accumulated_tokens": 14250,
    "context_budget": 32000
  },
  "updated_at": "2026-09-23T12:00:00Z"
}
```

### State Machine Transition Rules:
- A phase cannot begin until the preceding phase's required artifact exists and passes validation.
- An agent is strictly prohibited from skipping gates (e.g. going from `IMPLEMENT` directly to `PR_READY` without `devweave-pr-review`).
- When a verification or review fails, the state transitions deterministically to `FAILURE`, invoking the fix loop.

---

## 5. Phase-by-Phase Internal Mechanics

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                 DEVWEAVE INTERNAL PIPELINE                                      │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
  [Phase 0: INIT]          ──► Scans 5 layers ──► Generates layers.md & request-flow.md
  [Phase 1: CONTEXT]       ──► Ingests ticket ──► Sanitizes PII ──► Enforces 32k Token Budget
  [Phase 2: ANALYZE]       ──► Maps blast radius ──► Checks DB schema & API interface contracts
  [Phase 3: PLAN]          ──► Decomposes atomic tasks ──► Anchors exact file lines & test commands
  [Phase 4: BRANCH GATE]   ──► Validates git branch ──► Blocks direct writes to main/master
  [Phase 5: IMPLEMENT]     ──► Executes plan-bound edits ──► Runs Test Intelligence ──► Captures proof
  [Phase 6: REVIEW GATE]   ──► Dual-Model consensus (Architect + DBA + Security) ──► Human sign-off
  [Phase 7: PR READY]      ──► Assembles PR ──► Promotes durable knowledge to .devweave/knowledge/
```

### Phase 0: 5-Layer Autonomous Discovery & Knowledge Graph Synthesis
- **Layer 1 — Topology**: Detects single-service, monorepo (`packages/*`, `apps/*`), or multi-repo linked topologies.
- **Layer 2 — Languages**: Detects polyglot ecosystems (C#, TypeScript, Python, Go, Rust, Java, etc.) with evidence citations.
- **Layer 3 — Frameworks & Engines**: Detects active frameworks (ASP.NET Core, Angular, Spring Boot, FastAPI, Rails).
- **Layer 4 — Tooling & ORMs**: Maps build tools (`dotnet`, `mvn`, `npm`, `cargo`) and test runners (`xUnit`, `pytest`, `Jest`).
- **Layer 5 — Pin-to-Pin Mapping & Graph**: Generates:
  - `layers.md`: Maps physical folders (`src/controllers/`, `Domain/`, `Data/`) to logical tiers.
  - `request-flow.md`: Generates end-to-end request journeys with Mermaid sequence diagrams.
  - `integrations.md`: Maps external databases, event queues (Kafka, RabbitMQ), and APIs.
  - `graph/knowledge-graph.json`: Synthesizes declarative JSON Knowledge Graph of all nodes and directed relationships.

### Phase 1: Intake, PII Gate & 1-Hop Graph Neighborhood Scoping
- Ingests issue details from Jira, Azure DevOps, GitHub, Linear, or manual CLI input.
- **PII / Secret Sanitizer**: Strips API keys, passwords, connection strings, and personal information before LLM ingestion.
- **1-Hop / 2-Hop Graph Traversal**: Queries `.devweave/graph/knowledge-graph.json` to calculate exact callers (incoming edges) and callees (outgoing dependencies), scoping active context strictly to `focus_paths` under the **32,000 token budget**.

### Phase 2 & 3: Archaeology & Atomic Planning
- Analyzes existing code patterns, dependencies, and schema models.
- Generates `plan.md` containing numbered, atomic tasks. Each task specifies:
  - Exact target file path.
  - Line number anchor.
  - Deterministic test / verification command.

### Phase 4 & 5: Branch Gate, Implementation & Graph Delta Generation
- **Branch Gate**: Refuses to edit code until an isolated feature branch (e.g. `feature/AUTH-101-token-refresh`) is active.
- **Plan-Bound Rule**: Edits are restricted strictly to the files declared in `plan.md`.
- **Test Evidence**: Runs local tests after each change and records stdout/stderr to `.devweave/tasks/<ID>/evidence.md`.
- **Graph Delta Extraction**: Computes task-isolated architectural mutations in `.devweave/tasks/<ID>/graph-delta.json`.

### Phase 6: Dual-Model Consensus Review & Graph Linter
Before any PR can be opened, DevWeave runs a rigorous multi-perspective review auditing both code diffs and `graph-delta.json`:
1. **Principal Software Architect Lens**: Validates design patterns, SOLID adherence, and graph layer integrity (e.g. Controller cannot bypass Service to mutate DB table).
2. **Senior DBA Lens**: Audits SQL queries for table locks, missing indexes, N+1 query hazards, and rollback scripts.
3. **Security Lens**: Scans for OWASP Top 10 vulnerabilities and unescaped input.
4. **Downstream Impact Lens**: Verifies that microservice APIs and event contracts remain backward-compatible.
5. **Cascading Resilience Lens**: Ensures timeouts and error boundaries prevent systemic outages.

### Phase 7: PR Assembly, Graph Merge & Compounding Knowledge Promotion
- Atomically applies `graph-delta.json` into the root `.devweave/graph/knowledge-graph.json`, staging the updated graph in the PR.
- Compiles the final PR body with full audit trails (Requirement &rarr; Solution &rarr; Code &rarr; Tests &rarr; Review).
- Promotes discovered architectural idioms into `.devweave/knowledge/conventions.md`, enabling **0-token rediscovery** for future sessions.

---

## 6. Test Intelligence Engine

The **Test Intelligence Engine** enforces strict quality and test governance during `IMPLEMENT` and `VERIFY`:

1. **Atomic Changesets**: Production code modifications and test modifications are authored and committed together in a single atomic changeset.
2. **Deterministic Failure Classification**:
   - `IMPLEMENTATION_DEFECT`: Failure in newly written code &rarr; fix production code.
   - `EXPECTED_BEHAVIOR_CHANGE`: Requirements deliberately evolved &rarr; update test assertion with explicit justification.
   - `UNRELATED_REGRESSION`: Pre-existing or collateral failure outside scope &rarr; preserve failure, block PR progression.
3. **Zero Test Weakening**: Deleting test cases, disabling assertions, removing `@Test` annotations, or catching exceptions silently is strictly prohibited.
4. **E2E Framework Discovery**: Resolves existing project test frameworks (Playwright, Cypress, Jest, xUnit) without blindly injecting new test libraries.

---

## 7. V1.1 Modernization Architecture & Mechanics

The Modernization engine enables safe, automated migration of legacy systems:

1. **Zero Questionnaire Initialization**: Accepts architectural intent in natural language and autonomously inspects the target repository structure (`architecture-intent.json`, `technology-profile.json`).
2. **Legacy Source Read-Only Invariance**: Legacy source repositories are referenced strictly as `READ_ONLY` in `source-memory.json`.
3. **3 Mandatory Human Hard Gates**:
   - **Hard Gate #1 (Post-ANALYZE)**: Explicit human `APPROVE` on `mappings.json`.
   - **Hard Gate #2 (Post-PLAN)**: Explicit human `APPROVE` on `plan.md` and test specifications.
   - **Hard Gate #3 (Post-VERIFY)**: Explicit human `APPROVE` on `verification.md` and parity scorecard.
4. **Knowledge Graph Migration Tracking**: Automatically generates `MIGRATED_TO` edges connecting legacy components to target modernized components.

---

## 8. Stage-Based Model Routing Engine

DevWeave optimizes cost and latency by routing tasks to calibrated model capabilities:

| Stage / Task | Capability Required | Calibrated Model Tier | Reason |
| :--- | :--- | :--- | :--- |
| **Manifest Scanning & Discovery** | `fast-analysis` | `flash_lite` / `flash` | Simple JSON/XML parsing; 10x faster and 98% cheaper. |
| **Lint & Syntax Checking** | `syntax-check` | `flash_lite` | Deterministic verification requires zero deep reasoning. |
| **Solution Design & Planning** | `deep-reasoning` | `pro` | Complex multi-system trade-off evaluation. |
| **Plan-Bound Implementation** | `coding` | `pro` / `flash` | Precision editing following strict specifications. |
| **Dual-Model Code & SQL Review** | `independent-review` | `pro` | Deep audit for locks, concurrency, and security vulnerabilities. |

---

## 9. Dynamic Technology Revalidation Engine

When a dependency is upgraded (e.g., `.NET 8` &rarr; `.NET 9`, `Java 17` &rarr; `Java 21`, `React 18` &rarr; `19`), DevWeave avoids stale instructions:

```text
[Dependency Lockfile Bump Detected] 
         │
         ▼
[Flags Affected Knowledge as NEEDS_REVALIDATION]
         │
         ▼
[Hot-Swaps Coding Conventions & Idioms]
         │
         ▼
[Stable Rules Preserved / Stale Best Practices Purged]
```

---

## 10. Durable Knowledge Caching (Why 0-Token Rediscovery Works)

Standard AI agents waste 80,000+ tokens re-analyzing repositories on every prompt. DevWeave persists intelligence across turns:

```text
.devweave/
├── repository/       <── Scanned ONCE during INIT (Never re-scanned)
├── knowledge/        <── Conventions & domain rules updated across PR merges
└── domains/          <── Domain catalogs & business rule scorecards
```

On subsequent tasks in the same repository:
- **Rediscovery Tokens**: **0 tokens**
- **Token Savings**: **93.3%**
- **Cost Reduction**: **99.7%**

---

## 11. Automated Daily Sync Engine (24-Hour TTL)

To eliminate manual plugin maintenance:
1. **Daily First Session**: When a developer opens their IDE in the morning, DevWeave checks remote GitHub `HEAD` via a 2-second non-blocking socket check.
2. **In-Place Sync**: If updates exist, it pulls latest skills and rules into the host plugin directory in-place.
3. **Rest of Day**: For the next 24 hours, all commands execute with **0ms latency and 0 network requests**.
4. **Token Cost**: **0 tokens consumed**.

---

## 12. Empirical Performance & Cost Benchmarks

From the automated benchmark suite (`conformance/tests/token_benchmark.ps1`):

```text
========================================================================================
Profile                  Unstructured AI          DevWeave AI-DLC       Token / Cost Savings
========================================================================================
Quick Bug Fix (EXPRESS)  141,200 tokens ($0.50)    9,250 tokens ($0.001)  93.4% / 99.6% Lower
Feature Implementation   788,800 tokens ($2.79)  125,700 tokens ($0.145)  84.1% / 94.8% Lower
Knowledge Reuse Task     327,500 tokens ($1.16)   21,800 tokens ($0.003)  93.3% / 99.7% Lower
Complex Monorepo Scoping 1,856,500 tokens ($6.54) 171,600 tokens ($0.258)  90.8% / 96.0% Lower
========================================================================================
```
