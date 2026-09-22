# DevWeave V1.0 — Developer & User Guide

Welcome to **DevWeave** — the declarative, evidence-based, and technology-neutral **AI-Driven Development Lifecycle (AI-DLC)** framework.

> **Core Mission:** *Less Tokens. More Work. Lower Bill.*

DevWeave guides developers and autonomous AI coding agents from initial work item requirements through solution design, implementation, testing, independent verification, multi-perspective code review, and pull request readiness.

---

## 1. What is DevWeave?

DevWeave is **not** another raw prompt wrapper or ad-hoc chatbot. It gives AI coding models a **disciplined, structured engineering process**:

```mermaid
flowchart TD
    subgraph Traditional["❌ Traditional Unstructured AI Coding"]
        T1["Prompt: 'Build this feature'"] --> T2["Whole-Repo Dump (Token Bloat)"]
        T2 --> T3["Hallucinated Architecture & Regressions"]
        T3 --> T4["Broken Tests & Silent Bugs"]
        T4 --> T5["High Cost ($$$) & Frustration"]
    end

    subgraph DevWeave["✅ DevWeave AI-DLC Framework"]
        D1["Work Item / Ticket"] --> D2["Autonomous Detection & Focused Context"]
        D2 --> D3["Traceable Requirements & Solution Trade-offs"]
        D3 --> D4["Human Approval Governance Gate"]
        D4 --> D5["Plan-Bound Incremental Coding"]
        D5 --> D6["Deterministic Testing & Verification"]
        D6 --> D7["Multi-Perspective Review & PR Ready"]
    end
```

### Architectural Overview & Host Decoupling
DevWeave separates host interactions from core engineering lifecycle rules:

```mermaid
flowchart TD
    subgraph HostLayer["Host AI Layer (e.g., Google Antigravity / CLI / IDE)"]
        Agent["Autonomous AI Agent / Pair Programmer"]
        Skills["DevWeave Skills & Rules (`.agent/skills/`)"]
    end

    subgraph CoreLayer["DevWeave Core Engine (Declarative & Technology-Neutral)"]
        StateEngine["AI-DLC State Machine & Phase Transitions"]
        TechDetector["5-Layer Autonomous Technology Detector"]
        PracticeEngine["Tiered Best-Practice & Anti-Pattern Selector"]
        BudgetEngine["Token Budget & Blast-Radius Scoping Engine"]
    end

    subgraph StorageLayer["Repository File Storage (`.devweave/`)"]
        RepoMeta[".devweave/repository/* (Intelligence & Build/Test Rules)"]
        Knowledge[".devweave/knowledge/* (Conventions & Patterns)"]
        WorkItems[".devweave/work-items/* (Task Context, Plans & PRs)"]
        LiveState[".devweave/state/current.json (Durable Phase State)"]
    end

    Agent <--> Skills
    Skills <--> CoreLayer
    CoreLayer <--> StorageLayer
```

---

## 2. Quick Start: 3 Steps to Your First Task

```mermaid
flowchart LR
    S1["1. DevWeave Init<br><b>Inspect Repository</b><br>5-Layer Tech Detection"] --> S2["2. DevWeave-context<br><b>Ingest Work Item</b><br>MCP or Manual Input"]
    S2 --> S3["3. Run AI-DLC<br><b>Deliver Feature</b><br>Plan → Code → Verify → PR"]
```

### Step 1: Initialize Your Repository (`DevWeave init`)
Run in your project root or ask your AI assistant:
```bash
DevWeave init
```
DevWeave automatically inspects project manifests, lockfiles, build configurations, and test runners using **5-Layer Autonomous Detection** without requiring you to manually configure stack settings.

### Step 2: Ingest a Work Item (`DevWeave-context`)
Ingest tasks from Jira, Azure DevOps, GitHub Issues, Linear, or manual paste:
```bash
DevWeave-context PROJ-1042
```
*If no MCP server is configured, DevWeave prompts you to paste the title, description, and acceptance criteria.*

### Step 3: Run the Guided AI-DLC Flow
DevWeave guides the agent systematically through requirements normalization, solution trade-offs, human approval, task execution, testing, and PR creation.

---

## 3. The 9-Phase AI-DLC Lifecycle & State Transitions

DevWeave organizes work into a deterministic state machine with explicit validation gates and feedback loops:

```mermaid
flowchart TD
    INIT["INIT & DISCOVERY<br><i>(Scoped Blast-Radius)</i>"] --> REQ["REQUIREMENTS<br><i>(Acceptance Criteria)</i>"]
    REQ --> SOL["SOLUTION DESIGN<br><i>(Options & Best Practices)</i>"]
    
    SOL --> GATE{"APPROVAL GATE<br><i>(Human Sign-Off)</i>"}
    GATE -- "Approved" --> PLAN["PLAN<br><i>(Atomic Tasks)</i>"]
    GATE -- "Changes Requested" --> SOL
    GATE -- "Rejected" --> REQ
    
    PLAN --> IMP["IMPLEMENT<br><i>(Surgical Edits)</i>"]
    IMP --> TEST["TEST<br><i>(Automated Suites)</i>"]
    
    TEST -- "Tests Pass" --> VER["VERIFY<br><i>(Acceptance & Schema Checks)</i>"]
    TEST -- "Tests Fail (Fix Loop)" --> IMP
    
    VER -- "Verified Clean" --> REV["CODE REVIEW<br><i>(Multi-Perspective)</i>"]
    VER -- "Verification Failed" --> IMP
    
    REV --> PR["PR READY<br><i>(Traceable PR Package)</i>"]
```

---

### Lifecycle Phase Breakdown & Produced Artifacts

```mermaid
flowchart LR
    subgraph Analysis["1. Analysis & Design"]
        A1["Discovery<br><code>context.md</code>"]
        A2["Requirements<br><code>requirements.md</code>"]
        A3["Solution<br><code>solution.md</code>"]
    end

    subgraph Governance["2. Governance & Plan"]
        G1["Approval Gate<br><code>approval.json</code>"]
        G2["Planning<br><code>plan.md</code>"]
    end

    subgraph Execution["3. Execution & Verification"]
        E1["Implementation<br><i>Source Diffs</i>"]
        E2["Testing<br><code>test-results.json</code>"]
        E3["Verification<br><code>verification.md</code>"]
    end

    subgraph Delivery["4. Review & PR"]
        D1["Review<br><code>review.md</code>"]
        D2["PR Package<br><code>pr-description.md</code>"]
    end

    Analysis --> Governance --> Execution --> Delivery
```

1. **Discovery (`devweave-discovery`)**: Identifies affected components, dependencies, schema migrations, and sets an active context token budget (e.g., 32,000 tokens).
2. **Requirements (`devweave-requirements`)**: Normalizes requirements into testable acceptance criteria in `.devweave/work-items/<ID>/requirements.md`.
3. **Solution Design (`devweave-solution`)**: Evaluates architectural trade-offs, selects tiered best practices, and creates `.devweave/work-items/<ID>/solution.md`.
4. **Approval Gate (`devweave-approval`)**: Pauses execution for human authorization on high-impact architectural or schema changes.
5. **Planning (`devweave-plan`)**: Decomposes the approved solution into atomic, ordered tasks in `.devweave/work-items/<ID>/plan.md`.
6. **Implementation (`devweave-implement`)**: Executes surgical, bounded file edits strictly constrained to the approved plan.
7. **Testing (`devweave-test`)**: Runs deterministic project test runners and records outcomes in `.devweave/work-items/<ID>/test-results.json`.
8. **Verification (`devweave-verify`)**: Verifies 100% acceptance criteria fulfillment and zero schema violations in `.devweave/work-items/<ID>/verification.md`.
9. **Review & PR Ready (`devweave-review`, `devweave-pr`)**: Conducts multi-perspective code review and generates `.devweave/work-items/<ID>/pr-description.md`.

---

## 4. Autonomous 5-Layer Technology Detection Flow

When `DevWeave init` runs, it traverses repository manifests and builds evidence-backed intelligence without guessing:

```mermaid
flowchart TD
    Evidence["📁 Repository Evidence<br><i>(pom.xml, .csproj, package.json, Cargo.toml, pyproject.toml, etc.)</i>"] --> L1

    subgraph Layers["Progressive 5-Layer Detection"]
        L1["<b>Layer 1: Repository Structure</b><br>Monorepo, Single App, Microservices, DB Migrations"] --> L2
        L2["<b>Layer 2: Programming Languages</b><br>Primary & Secondary Languages + Confidence Scores"] --> L3
        L3["<b>Layer 3: Frameworks & Engines</b><br>ASP.NET Core, FastAPI, Spring Boot, Angular, React, etc."] --> L4
        L4["<b>Layer 4: Libraries & Tooling</b><br>xUnit, pytest, Jest, Cargo, Maven, EF Core, etc."] --> L5
        L5["<b>Layer 5: Exact Versions</b><br>Discovered from lockfiles and project targets"]
    end

    L5 --> Artifacts

    subgraph Artifacts["Generated Intelligence (.devweave/repository/)"]
        P1["profile.md (Overview)"]
        P2["technologies.md (Runtimes)"]
        P3["frameworks.md (Frameworks)"]
        P4["dependencies.md (Packages)"]
        P5["build.md (Build Commands)"]
        P6["testing.md (Test Commands)"]
        P7["architecture.md (Layout)"]
        P8["practices.md (Best Practices)"]
    end
```

### Best-Practice Tiering
Practices loaded into context are tiered to prevent ambiguity:
- **`MANDATORY`**: Security, data safety, and compliance requirements. Violations block PR progression.
- **`RECOMMENDED`**: Strong idiomatic guidance. Departure requires recorded technical rationale.
- **`ADVISORY`**: Optional optimizations and code clarity improvements.
- **`ANTI_PATTERN`**: Harmful habits (e.g., sync-over-async, raw SQL in UI, unindexed joins) explicitly blocked during review.

---

## 5. Work Item Ingestion & Blast-Radius Scoping

DevWeave ensures **84%–93% token savings** by converting raw inputs into structured contexts and scoping LLM access:

```mermaid
flowchart TD
    subgraph Ingestion["Work Item Ingestion Flow"]
        MCP["MCP Provider<br><i>(Jira / ADO / GitHub / Linear)</i>"] --> Norm["Generic Work Item Normalization"]
        Manual["Manual / Pasted Input<br><i>(Zero-MCP Fallback)</i>"] --> Norm
        Norm --> Ctx["Focused Context (.devweave/work-items/<ID>/context.md)"]
    end

    subgraph Scoping["Blast-Radius Context Scoping"]
        Ctx --> ScopeCheck{"Component Scoping"}
        ScopeCheck -->|"Affected Files Only"| AgentContext["Agent Context Budget (e.g. 8k tokens)"]
        ScopeCheck -. "Skip Unaffected 95% of Repo" .-> Excluded["Excluded Codebase Files"]
    end
```

### Ingestion Commands
- **Via MCP**: `DevWeave-context PROJ-1234`
- **Manual Fallback**: `DevWeave-context` (prompts for title, description, criteria)
- **Context Refresh**: `DevWeave-context --refresh PROJ-1234` (safely resets lifecycle if ticket changed)

---

## 6. Workflow Profiles (Matching Rigor to Task Complexity)

DevWeave dynamically routes work items to the most efficient lifecycle profile:

```mermaid
flowchart TD
    Task["Work Item Input"] --> Router{"Classify Complexity"}

    Router -- "Minor Bug / Typo / Docs" --> EXP["<b>EXPRESS Profile</b><br>Discovery → Plan → Implement → Test → PR<br><i>Model: flash / flash_lite</i>"]
    Router -- "New Feature / API" --> FEAT["<b>FEATURE Profile</b><br>Full 9-Phase AI-DLC + Human Approval Gate<br><i>Model: flash + pro</i>"]
    Router -- "Framework / DB Migration" --> MOD["<b>MODERNIZATION Profile</b><br>Discovery → Solution → Approval → Stepwise Plan<br><i>Model: pro</i>"]
    Router -- "Security / CVE Fix" --> SEC["<b>SECURITY Profile</b><br>Strict Discovery → Security Review → Verify → Approval<br><i>Model: pro</i>"]
```

---

## 7. Durable State & Interrupted Workflows

Every task maintains durable state in `.devweave/state/current.json` and `.devweave/work-items/<ID>/state.md`.

```mermaid
sequenceDiagram
    autonumber
    actor Developer
    participant DevWeave
    participant Filesystem as .devweave/state/
    
    Developer->>DevWeave: Start work on PROJ-101
    DevWeave->>Filesystem: Complete DISCOVERY, REQ, SOLUTION, PLAN
    DevWeave->>Filesystem: Record Phase: IMPLEMENT (In Progress)
    Note over Developer,DevWeave: Developer session closes / Agent disconnects
    
    Developer->>DevWeave: Resume work (DevWeave-status)
    DevWeave->>Filesystem: Read current.json & load existing artifacts
    Note over DevWeave: Reuses completed PLAN & SOLUTION (Zero token re-spend)
    DevWeave->>Developer: Resumed at IMPLEMENT phase
```

---

## 8. Multi-Perspective Code Review Architecture

Before generating the pull request package, DevWeave evaluates changes across four independent review lenses:

```mermaid
flowchart TD
    Diff["Implementation Diffs & Verification Evidence"] --> R1 & R2 & R3 & R4

    subgraph Perspectives["Multi-Perspective Review Lenses"]
        R1["<b>1. Correctness</b><br>Acceptance criteria verified & logic sound"]
        R2["<b>2. Security</b><br>Zero secrets, input validated, safe queries"]
        R3["<b>3. Performance</b><br>No N+1 queries, async concurrency preserved"]
        R4["<b>4. Maintainability</b><br>Conforms to repository conventions & style"]
    end

    R1 & R2 & R3 & R4 --> Synthesis["Review Findings Synthesis (review.md)"]
    Synthesis --> PRPkg["Traceable PR Package (pr-description.md)"]
```

---

## 9. Security & Governance Boundaries

DevWeave enforces hard security boundaries to protect production environments:

```mermaid
flowchart LR
    AgentOp["AI Agent Operation"] --> Guard{"Security Policy Guard"}
    
    Guard -- "Production DB Mutation (DROP/TRUNCATE)" --> Blocked["❌ Blocked (Requires Migration Script)"]
    Guard -- "Plaintext Secrets / API Keys" --> Redacted["❌ Blocked (Secrets Redaction Pattern)"]
    Guard -- "Destructive Shell (rm -rf, git push -f)" --> Gated["⚠️ Gated (Explicit Approval Required)"]
    Guard -- "Standard Local File Edits & Tests" --> Allowed["✅ Allowed Execution"]
```

---

## 10. Developer Command & Skill Reference

| Command / Trigger | Antigravity Skill | Purpose & Role | Output Artifact |
| :--- | :--- | :--- | :--- |
| `DevWeave init` | `devweave-init` | 5-Layer autonomous repo onboarding | `.devweave/repository/*` |
| `DevWeave-context <ID>` | `devweave-discovery` | Ingest ticket & initialize context budget | `.devweave/work-items/<ID>/context.md` |
| `DevWeave-requirements` | `devweave-requirements` | Normalize acceptance criteria | `requirements.md` |
| `DevWeave-solution` | `devweave-solution` | Architectural design & trade-offs | `solution.md` |
| `DevWeave-approve <ID>` | `devweave-approval` | Authorize progression past approval gate | `approval.json` |
| `DevWeave-plan` | `devweave-plan` | Decompose into atomic tasks | `plan.md` |
| `DevWeave-implement` | `devweave-implement` | Surgical, plan-bound code execution | Modified source files |
| `DevWeave-test` | `devweave-test` | Run test runners & capture results | `test-results.json` |
| `DevWeave-verify` | `devweave-verify` | Validate criteria & build integrity | `verification.md` |
| `DevWeave-review` | `devweave-review` | Multi-perspective code review | `review.md` |
| `DevWeave-pr` | `devweave-pr` | Assemble pull request package | `pr-description.md` |
| `DevWeave-status` | — | Inspect current AI-DLC state & open gates | `current.json` |
| `DevWeave-knowledge capture`| `devweave-knowledge` | Save reusable domain rules & conventions | `.devweave/knowledge/*.md` |

---

## 11. Customizing Conventions for Your Team

To customize how DevWeave generates code and reviews PRs for your repository:
- Edit [`.devweave/knowledge/conventions.md`](file:///D:/DevWeave/spec/specification/best-practices.md) for naming conventions, folder patterns, and architectural rules.
- Edit [`.devweave/repository/practices.md`](file:///D:/DevWeave/spec/specification/best-practices.md) for custom team practices or prohibited patterns.

DevWeave always gives **local repository conventions highest priority**, ensuring AI agents adhere strictly to your team's existing codebase style.
