---
name: devweave-init
description: "[Phase 0: Init] Initialize DevWeave in the repository by autonomously detecting technology stack across 5 layers and generating pin-to-pin architecture, layers, request flow, and multi-repository topology intelligence."
---

# Cognition Devin Initialization Playbook (`devweave:init`)

> **"Less Tokens. More Work. Lower Bill."**

## Purpose
Autonomously inspect the target workspace repository, detect its complete technology stack across 5 evidence-based layers, and establish concrete, pin-to-pin repository intelligence (physical-to-logical layers, end-to-end request flow, transaction boundaries, and multi-repo topology) without modifying application code. Operates generically on any software repository.

---

## Execution Workflow

### Step 1: Progressive 5-Layer Technology & Topology Detection
Execute targeted inspection of repository manifests, project files, directory layouts, and configuration:

1. **Layer 1 — Repository Structure & Multi-Repo Topology**:
   - Inspect workspace root for project topology (single service, monorepo with `services/*` / `packages/*`, or multi-repo linked workspace).
2. **Layer 2 — Programming Languages**:
   - Detect all languages present with confidence scores (`HIGH`, `MEDIUM`, `LOW`) based on manifest files (`package.json`, `*.csproj`, `*.sln`, `pom.xml`, `build.gradle`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `requirements.txt`, `composer.json`, `Gemfile`, `CMakeLists.txt`). Support polyglot repositories.
3. **Layer 3 — Frameworks & Engines**:
   - Detect active web, ORM, and UI frameworks (e.g., ASP.NET Core, Angular, React, Spring Boot, Laravel, Rails, FastAPI, Express, NestJS, Tokio).
4. **Layer 4 — Libraries & Tooling**:
   - Detect ORMs (EF Core, Prisma, Hibernate, SQLAlchemy), build tools (dotnet, npm, maven, gradle, cargo, cmake), and test runners (xUnit, pytest, Jest, JUnit, PHPUnit, Karma, CTest).
5. **Layer 5 — Versions & Capabilities**:
   - Extract exact runtime versions and dependency targets from lockfiles or project definitions. Record `unknown` if version cannot be determined from evidence; never guess.

---

### Step 2: Pin-to-Pin Architecture & Request Flow Synthesis
Analyze project entrypoints, router definitions, middleware chains, service classes, and data access layers to map:

1. **Physical-to-Logical Layer Mapping (`layers.md`)**:
   - Map exact codebase directories to architectural tiers:
     - *Entrypoint / Bootstrap* (e.g. `src/server.ts`, `Program.cs`)
     - *HTTP Middleware / Guards* (e.g. `src/middleware/`, `Filters/`)
     - *Controllers / Routers* (e.g. `src/controllers/`, `Endpoints/`)
     - *Domain Services / Use Cases* (e.g. `src/services/`, `Domain/`)
     - *Data Access / Repositories* (e.g. `src/repositories/`, `Data/`)
     - *Database Models & Migrations* (e.g. `prisma/schema.prisma`, `Migrations/`)
2. **Concrete End-to-End Request Flow (`request-flow.md`)**:
   - Generate an execution trace (with Mermaid sequence diagram) detailing how a typical request flows:
     `Client Request` &rarr; `Middleware (Auth/Tracing)` &rarr; `Controller (DTO Validation)` &rarr; `Service (Business Logic)` &rarr; `Repository (Parameterized Query)` &rarr; `Database/Cache` &rarr; `Response DTO`.
3. **Multi-Service Monorepo Map (`monorepo-map.md`)** *(if multi-service)*:
   - Map inter-service communications (REST, gRPC, Kafka/RabbitMQ events, shared types).

---

### Step 3: Establish Repository Knowledge & Intelligence Files
Create or update the standardized `.devweave/` intelligence directory in the target workspace root:

```text
.devweave/
├── repository/
│   ├── profile.md          # 5-Layer classification & repository overview
│   ├── technologies.md     # Primary & secondary runtimes with evidence citations
│   ├── frameworks.md       # Detected frameworks, ORMs, and UI libraries
│   ├── dependencies.md     # Package manager & dependency lockfile status
│   ├── build.md            # Deterministic build commands and build targets
│   ├── testing.md          # Test runners, single-test commands, coverage flags
│   ├── architecture.md     # Comprehensive system topology & component layout
│   ├── layers.md           # Pin-to-pin physical-to-logical layer mapping
│   ├── request-flow.md     # End-to-end request/execution trace & sequence diagram
│   ├── integrations.md     # External APIs, database connections, and event queues
│   └── practices.md        # Stack-aware coding conventions and anti-patterns
├── knowledge/
│   └── conventions.md      # Repository coding conventions, style guides & lint rules
└── state/
    └── current.json        # AI-DLC lifecycle state, token usage, and gate status
```

---

### Step 4: Safety & Token Efficiency Invariants
1. **Zero Application Modification**: `devweave-init` must NOT modify application source code, business logic, configuration files, or database schemas.
2. **Token Efficiency**: Inspect only manifests and structure; do NOT read whole repository codebases into context.
3. **Evidence-Based Only**: Never claim a technology exists unless concrete repository evidence supports it.

---

### Step 5: Report Initialization Summary
Present the structured initialization summary to the developer:

```text
Cognition Devin initialization completed.

Repository: <repository-name>
Topology: <monorepo / single-service / multi-service>
Languages: <detected languages with versions & confidence>
Frameworks: <detected web/ORM/UI frameworks>
Build Tools: <detected build commands>
Testing Runners: <detected test frameworks & commands>
Architecture & Layers: Mapped pin-to-pin (layers.md, request-flow.md)
Artifacts: Created intelligence artifacts under .devweave/

Devin is waiting for your instruction.
Run: devweave:context <WorkItemId>
```
