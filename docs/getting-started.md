# DevWeave V1.0 — Developer & User Guide

Welcome to **DevWeave** — the declarative, evidence-based, and technology-neutral **AI-Driven Development Lifecycle (AI-DLC)** framework.

> **Core Mission:** *Less Tokens. More Work. Lower Bill.*

DevWeave guides developers and autonomous AI coding agents from initial work item requirements through analysis, planning, branch governance, implementation, deterministic testing, independent verification, and pull request readiness.

---

## 1. What is DevWeave?

DevWeave gives AI coding assistants a **disciplined, structured engineering process**:

```mermaid
flowchart TD
    subgraph Traditional["❌ Traditional Unstructured AI Coding"]
        T1["Prompt: 'Build this feature'"] --> T2["Whole-Repo Dump (Token Bloat)"]
        T2 --> T3["Hallucinated Architecture & Regressions"]
        T3 --> T4["Broken Tests & Silent Bugs"]
        T4 --> T5["High Cost ($$$) & Frustration"]
    end

    subgraph DevWeave["✅ DevWeave AI-DLC Framework"]
        D1["Work Item / Ticket"] --> D2["Autonomous Detection & Scoped Context"]
        D2 --> D3["Deep Analysis & Solution Trade-offs"]
        D3 --> D4["File-Anchored Plan & Branch Governance"]
        D4 --> D5["Plan-Bound Incremental Implementation"]
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
        Skills["DevWeave Skills & Rules (`.agent/skills/` or `plugins/devweave/`)"]
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

## 2. Installation & Setup in Antigravity (`agy`)

> 📖 **Looking for step-by-step instructions for all skill levels?** See the complete [**Installation Guide**](installation-guide.md) with 5 installation options, team check-in procedures, and troubleshooting.

You can install DevWeave in your target project using the Antigravity CLI (`agy`) or via Git clone.

### Option A: Install via Antigravity CLI (`agy`) — (Recommended)
In your target project directory (e.g., `D:\DatingAPP`):
```powershell
# From local DevWeave directory:
agy plugin install D:\DevWeave\plugins\devweave

# Or direct from GitHub:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git temp-devweave
agy plugin install .\temp-devweave\plugins\devweave
Remove-Item -Recurse -Force temp-devweave
```

Verify installation:
```powershell
agy plugin list
```

---

## 3. Official Antigravity Command & Skill Surface

DevWeave provides a deterministic CLI command surface mapped directly to Antigravity skills with **mandatory human checkpoints** and **phase isolation**:

```mermaid
flowchart LR
    INIT["0. DevWeave init<br><i>(Repo Onboarding)</i>"] --> P1["1. CONTEXT<br><code>DevWeave-context &lt;ID&gt;</code>"]
    P1 --> P2["2. ANALYZE<br><code>DevWeave-analyze &lt;ID&gt;</code>"]
    P2 --> P3["3. PLAN<br><code>DevWeave-plan &lt;ID&gt;</code>"]
    P3 --> P4["4. BRANCH<br><code>DevWeave-branch &lt;ID&gt;</code><br><b>(HARD GATE)</b>"]
    P4 --> P5["5. IMPLEMENT<br><code>DevWeave-implement &lt;ID&gt;</code>"]
    P5 --> P6["6. PR<br><code>DevWeave-pr &lt;ID&gt;</code><br><b>(HARD GATE)</b>"]
```

### Command & Skill Surface Reference

| CLI Command | Antigravity Skill | AI-DLC Phase | Purpose | Primary Artifact |
| :--- | :--- | :--- | :--- | :--- |
| `DevWeave init` | `devweave-init` | `INIT` | 5-Layer autonomous repo onboarding | `.devweave/repository/*` |
| `DevWeave-context <ID>` | `devweave-context` | `CONTEXT` | Ingest ticket & scope blast radius | `.devweave/work-items/<ID>/context.md` |
| `DevWeave-analyze <ID>` | `devweave-analyze` | `ANALYZE` | Code investigation & approach design | `.devweave/work-items/<ID>/analysis.md` |
| `DevWeave-plan <ID>` | `devweave-plan` | `PLAN` | File-anchored task decomposition | `.devweave/work-items/<ID>/plan.md` |
| `DevWeave-branch <ID>` | `devweave-branch` | `BRANCH` | **Hard Gate**: Isolated branch creation | Git branch record |
| `DevWeave-implement <ID>` | `devweave-implement` | `IMPLEMENT` | Plan-bound code changes & tests | Source diffs, `test-results.json` |
| `DevWeave-pr <ID>` | `devweave-pr` | `PR` | **Hard Gate**: Review & PR assembly | `verification.md`, `pr-description.md` |
| `DevWeave-status <ID>` | `devweave-status` | Cross-Phase | Inspect real-time phase progression | `.devweave/state/current.json` |
| `DevWeave-handoff <ID>` | `devweave-handoff` | Cross-Phase | Generate handoff package for team | `.devweave/work-items/<ID>/handoff.md` |
| `DevWeave-archive <ID>` | `devweave-archive` | Post-Merge | Archive workspace to `.devweave/archive/` | Archived artifacts & audit log |

---

## 4. Specialized Workflow Lanes

DevWeave provides three specialized lanes sharing the same underlying state machine:

### 1. General / Feature Lane (6 Phases)
```bash
DevWeave-context PROJ-1042
DevWeave-analyze PROJ-1042
DevWeave-plan PROJ-1042
DevWeave-branch PROJ-1042
DevWeave-implement PROJ-1042
DevWeave-pr PROJ-1042
```

### 2. Fix Lane — Defect Remediation (3 Phases)
```bash
DevWeave-fix-triage BUG-201
DevWeave-fix-diagnose BUG-201
DevWeave-fix-land BUG-201
```

### 3. Modernization Lane — Stepwise Framework Upgrades
```bash
DevWeave-modernize-context MOD-301
DevWeave-modernize-analyze MOD-301
DevWeave-modernize-plan MOD-301      # Generates migration_manifest.md with 100% parity contract
DevWeave-modernize-branch MOD-301
DevWeave-modernize-implement MOD-301 # Lockstep status updates (🔴 → 🟡 → 🟢)
DevWeave-modernize-pr MOD-301
```

---

## 5. Non-Negotiable Human-in-the-Loop Governance

DevWeave enforces four strict engineering invariants:

1. **Phase Isolation**: Every command executes **only its own phase**, outputs its artifact, and halts.
2. **Mandatory Human Checkpoints**: Every phase ends with an explicit decision:
   ```text
   PHASE COMPLETE: PLAN
   Artifact: .devweave/work-items/PROJ-1042/plan.md
   
   Human Decision: [Approve Plan] [Request Changes] [Stop]
   Suggested Next Phase: BRANCH (Run: DevWeave-branch PROJ-1042)
   
   DevWeave is waiting for your instruction.
   ```
3. **Zero Automatic Chaining**: The AI never self-approves or triggers the next command automatically.
4. **Durable State Persistence**: All state transitions and human decisions are saved to `.devweave/work-items/<ID>/state.md`.

---

## 6. Autonomous 5-Layer Technology Detection Flow

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

## 7. Dynamic Technology Revalidation

When target technology changes (e.g., migrating from .NET Core 3.1 $\to$ .NET 9):
- **Skills are never recreated**: Skills remain stable and permanent.
- **Knowledge is refreshed**: Affected knowledge items are flagged as `NEEDS_REVALIDATION` in `ANALYZE`.
- **Practices update dynamically**: Version-specific idiomatic patterns (e.g., EF Core 9, Angular Standalone Components) are loaded automatically.

---

## 8. Durable State & Resuming Work

Every task maintains durable state in `.devweave/state/current.json` and `.devweave/work-items/<ID>/state.md`.

```mermaid
sequenceDiagram
    autonumber
    actor Developer
    participant DevWeave
    participant Filesystem as .devweave/state/
    
    Developer->>DevWeave: DevWeave-context PROJ-101
    DevWeave->>Filesystem: Complete CONTEXT, ANALYZE, PLAN, BRANCH
    DevWeave->>Filesystem: Record Phase: IMPLEMENT (In Progress)
    Note over Developer,DevWeave: Developer session closes / Agent disconnects
    
    Developer->>DevWeave: DevWeave-status PROJ-101
    DevWeave->>Filesystem: Read current.json & load existing artifacts
    Note over DevWeave: Reuses completed PLAN & BRANCH (Zero token re-spend)
    DevWeave->>Developer: Resumed cleanly at IMPLEMENT phase
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

## 10. Customizing Conventions for Your Team

To customize how DevWeave generates code and reviews PRs for your repository:
- Edit [`.devweave/knowledge/conventions.md`](file:///D:/DevWeave/spec/specification/best-practices.md) for naming conventions, folder patterns, and architectural rules.
- Edit [`.devweave/repository/practices.md`](file:///D:/DevWeave/spec/specification/best-practices.md) for custom team practices or prohibited patterns.

DevWeave always gives **local repository conventions highest priority**, ensuring AI agents adhere strictly to your team's existing codebase style.
