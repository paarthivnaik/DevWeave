# DevWeave Autonomous Technology Detection Specification

> **"Less Tokens. More Work. Lower Bill."**

Autonomous Technology Detection enables DevWeave to inspect any unfamiliar repository and infer its technology stack, dependencies, versions, physical-to-logical layers, request flow, and architectural topology without requiring manual user declaration. Operates generically across any codebase.

---

## 1. 5-Layer Progressive Detection Model

Detection operates progressively from coarse workspace structure down to fine-grained toolchain versions:

```text
┌─────────────────────────────────────────────────────────┐
│ Layer 1: Repository Structure & Multi-Repo Topology     │
│ (Monorepo, single service, multi-repo, DB migrations)   │
├─────────────────────────────────────────────────────────┤
│ Layer 2: Programming Languages                          │
│ (C#, TypeScript, Java, Python, Go, Rust, PHP, Ruby, etc.)│
├─────────────────────────────────────────────────────────┤
│ Layer 3: Frameworks & Engines                           │
│ (ASP.NET Core, Angular, Spring Boot, FastAPI, Rails)    │
├─────────────────────────────────────────────────────────┤
│ Layer 4: Libraries & Toolchains                         │
│ (EF Core, LINQ, RxJS, xUnit, pytest, Jest, Maven, Cargo)│
├─────────────────────────────────────────────────────────┤
│ Layer 5: Toolchain Versions                             │
│ (Evidence-extracted versions: .NET 8/9, Java 21, etc.)  │
└─────────────────────────────────────────────────────────┘
```

---

## 2. Evidence-Based Extraction Rules

1. **Manifest Parsing First**: Scan root and package manifests (`*.csproj`, `pom.xml`, `pyproject.toml`, `package.json`, `Cargo.toml`, `go.mod`, `composer.json`, `Gemfile`, `CMakeLists.txt`).
2. **Deterministic Confidence Rating**:
   - `HIGH`: Extracted directly from package manifests, SDK configuration files, or compiler lockfiles.
   - `MEDIUM`: Inferred from naming conventions, import statements, or folder layouts.
   - `LOW`: Deduced from isolated script patterns.
3. **Pin-to-Pin Architecture Synthesis**:
   - Map physical source directories to logical architectural tiers (`layers.md`).
   - Trace end-to-end request journeys from entrypoint down to data store (`request-flow.md`).
   - Record external integrations, APIs, and message brokers (`integrations.md`).
4. **No Assumptions**: If a version cannot be confirmed with evidence, record as `value: unknown, confidence: low`. Never invent a version or toolchain.

---

## 3. Discovered Repository Artifacts

Autonomous discovery populates the following structured intelligence files under `.devweave/repository/`:
- `profile.md`: Executive overview, repo topology, primary stack.
- `technologies.md`: Language versions and evidence citations.
- `frameworks.md`: Detected frameworks, versions, and role in repo.
- `dependencies.md`: Core package dependencies and lockfiles.
- `build.md`: Exact build commands and prerequisite toolchains.
- `testing.md`: Native test runner commands and assertion frameworks.
- `architecture.md`: Comprehensive system topology and component layout.
- `layers.md`: Pin-to-pin physical-to-logical layer mapping.
- `request-flow.md`: End-to-end request trace and Mermaid sequence diagram.
- `integrations.md`: External APIs, database connections, and event queues.
- `practices.md`: Applicable engineering best practices bound to the detected stack.
