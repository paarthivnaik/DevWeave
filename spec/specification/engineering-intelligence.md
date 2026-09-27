# DevWeave Engineering Intelligence Specification

> **"Less Tokens. More Work. Lower Bill."**

## 1. Executive Overview & Purpose

Engineering Intelligence (EI) is a generic, technology-aware architectural and engineering capability within DevWeave. It equips AI coding assistants and autonomous engineering agents with deep, stack-aware architectural memory, coding standards, policies, patterns, anti-patterns, and repository conventions without hard-coding specific technologies into DevWeave core.

Engineering Intelligence is generated deterministically when:
- `devweave-init` executes for standard, current, and detected legacy technologies.
- `devweave-modernization-init` executes for modernization-specific transformations and target technology intelligence.

The implementation is strictly technology-neutral: .NET, Java, Python, TypeScript, Go, Rust, PHP, Ruby, C++, cloud platforms, and databases are treated dynamically through evidence-based discovery and schema-driven contracts.

---

## 2. Core Architecture

```text
               ┌────────────────────────────────────────────────────────┐
               │              Engineering Intelligence Engine           │
               └───────────────────────────┬────────────────────────────┘
                                           │
             ┌─────────────────────────────┴────────────────────────────┐
             ▼                                                          ▼
┌───────────────────────────┐                              ┌───────────────────────────┐
│    Current / Legacy EI    │                              │     Modernization EI      │
└────────────┬──────────────┘                              └────────────┬──────────────┘
             │                                                          │
             └─────────────────────────────┬────────────────────────────┘
                                           ▼
                              ┌──────────────────────────┐
                              │ Technology Intelligence  │
                              └────────────┬─────────────┘
                                           │
                     ┌─────────────────────┴─────────────────────┐
                     ▼                                           ▼
        ┌───────────────────────────┐               ┌───────────────────────────┐
        │    Current Technology     │               │     Target Technology     │
        └───────────────────────────┘               └───────────────────────────┘
```

### 2.1 Legacy Engineering Intelligence
- **Purpose**: Understand, observe, and safely maintain existing software systems.
- Captures detected legacy runtimes, versions, existing patterns, compatibility constraints, repository conventions, architectural behaviors, legacy APIs, data access patterns, and security constraints.
- **Invariance**: Observed legacy practices are documented as `OBSERVED` facts and **MUST NOT** automatically become recommended best practices for new development.

### 2.2 Modernization Engineering Intelligence
- **Purpose**: Transform legacy system behaviors into modern target architectures while preserving required business behavior and contracts.
- Captures source-to-target technology mappings, transformation rules, architectural migration patterns, data/security mappings, verification requirements, and migration exceptions.

### 2.3 Current / Target Technology Intelligence
- Captures active standards, validated skills, organizational policies, patterns, anti-patterns, security/performance/testing guidance, and version-specific compatibility constraints for modern implementations.

---

## 3. Logical Entities & Data Model

Engineering Intelligence represents knowledge through 12 formal logical entities:

1. **Technology Intelligence**: Overall technical knowledge domain for a specific technology/version.
2. **Skill**: Executable AI capability or task procedure bound to a technology or workflow.
3. **Standard**: Prescribed architectural or implementation convention (e.g. naming, error response schema).
4. **Policy**: Mandatory organizational, security, or compliance invariant (e.g. zero secret storage, input parameterization).
5. **Pattern**: Recommended idiomatic structural or behavioral design (e.g. CQRS, repository pattern, async/await).
6. **Anti-pattern**: Disallowed practice causing bugs, performance degradation, or security holes (e.g. N+1 queries, async void).
7. **Repository Convention**: Empirically discovered local conventions (`.editorconfig`, linters, directory structures).
8. **Legacy Intelligence**: Architectural inventory and behavioral rules of the existing system.
9. **Modernization Intelligence**: Transformation mappings, parity tests, and migration rules.
10. **Exception**: Formally approved, scoped, and expirable deviation from a standard or policy.
11. **Technology Profile**: Structured snapshot of detected runtimes, frameworks, and tools with evidence citations.
12. **Engineering Intelligence Snapshot**: Immutable, work-item-scoped capture of all intelligence active during task execution.

### 3.1 Entity Schema Properties

Each Engineering Intelligence item conforms to the standard schema:

```json
{
  "id": "EI-DOTNET-API-001",
  "name": "Standard Error Response Contract",
  "version": "1.0.0",
  "type": "STANDARD",
  "scope": "PROJECT",
  "status": "ACTIVE",
  "technology": "ASP.NET Core",
  "technologyVersion": "8.0",
  "source": "REPOSITORY_DEFINED",
  "description": "All HTTP APIs must return ProblemDetails RFC 7807 formatted error payloads.",
  "rules": [
    {
      "ruleId": "RULE-ERR-001",
      "severity": "MANDATORY",
      "statement": "Use app.UseExceptionHandler() with ProblemDetails output.",
      "action": "ENFORCE"
    }
  ],
  "evidence": [
    {
      "file": "src/WebApi/Program.cs",
      "reason": "app.UseProblemDetails() configured in middleware pipeline."
    }
  ],
  "dependencies": ["EI-DOTNET-CORE-001"],
  "created_at": "2026-09-27T10:00:00Z",
  "updated_at": "2026-09-27T10:00:00Z"
}
```

### 3.2 Status Lifecycle
- `DRAFT`: Proposed rule awaiting schema validation or human review.
- `ACTIVE`: Fully approved and active for contextual resolution.
- `NEEDS_REVALIDATION`: Triggered when underlying technology or source file changes.
- `DEPRECATED`: Superceded by newer version or retired.
- `DISABLED`: Temporarily deactivated by developer.
- `CONFLICTED`: Flagged due to contradiction with a higher-priority standard.

### 3.3 Source Attribution
- `ORGANIZATION_DEFINED`: Enterprise-wide policy (highest priority).
- `PROJECT_DEFINED`: Project-level architecture decision.
- `REPOSITORY_DEFINED`: Explicitly committed in repository configuration.
- `DEVELOPER_DEFINED`: Added via natural language command with human approval.
- `TECHNOLOGY_OFFICIAL`: Official vendor/language recommendations.
- `DEVWEAVE_RECOMMENDED`: Built-in DevWeave engineering baseline.
- `OBSERVED`: Inferred from codebase inspection (non-mandatory by default).
- `GENERATED`: Produced by AI proposal (requires human approval if mandatory).

---

## 4. Evidence-Based Technology Detection & Classification

Detection operates across 11 key technical dimensions:
1. **Programming Languages & Versions** (C#, Java, Python, TypeScript, Go, Rust, PHP, Ruby, etc.)
2. **Frameworks & Versions** (ASP.NET Core, Spring Boot, FastAPI, Angular, React, Express, etc.)
3. **Libraries & Package Managers** (NuGet, Maven, Gradle, npm, pnpm, Cargo, Pip, Poetry)
4. **Databases & ORMs** (PostgreSQL, MySQL, SQL Server, MongoDB, EF Core, Hibernate, Prisma)
5. **Cloud Providers** (Azure, AWS, GCP)
6. **Messaging & Event Streaming** (RabbitMQ, Kafka, Azure Service Bus, Redis)
7. **Testing Frameworks** (xUnit, NUnit, JUnit, pytest, Jest, Playwright, Cypress)
8. **Build Systems** (dotnet build, mvn, gradle, npm, cargo, cmake)
9. **Deployment Technologies** (Docker, Kubernetes, Helm, Terraform, Bicep)
10. **Architecture Indicators** (Clean Architecture, CQRS, Hexagonal, Monolith, Microservices)
11. **Legacy Technologies** (.NET Framework <= 4.8, AngularJS, Python 2, Java <= 8, WCF, ASMX, Struts)

### 4.1 Lifecycle Classification Contract
Technologies are classified into:
- `CURRENT`: Modern, actively supported technologies adhering to target standards.
- `LEGACY`: Outdated, deprecated, or end-of-life frameworks requiring isolated maintenance or modernization.

---

## 5. `devweave-init` Lifecycle Extension

During Phase 0 (`devweave-init`), DevWeave establishes:
1. **Repository Validation**: Verifies directory integrity.
2. **5-Layer Technology Detection**: Discovers runtimes and versions with evidence citations.
3. **Technology Profile**: Emits `.devweave/modernization/technology-profile.json` or `.devweave/repository/technologies.md`.
4. **Current vs. Legacy EI Partitioning**:
   - Current technologies generate `.devweave/intelligence/current.json`.
   - Legacy technologies generate `.devweave/intelligence/legacy.json` capturing legacy patterns as `OBSERVED` invariants.
5. **Repository Conventions Discovery**: Scans `.editorconfig`, linters, and CI configurations to create `.devweave/intelligence/conventions.json`.
6. **Knowledge Graph Registration**: Registers technology nodes, standard nodes, and policy edges into `.devweave/graph/knowledge-graph.json`.
7. **State Recording**: Updates `.devweave/state/current.json`.

---

## 6. Shared LLM-Based Generation (`TechnologyIntelligenceGenerator`)

To generate new intelligence without hallucination or premature policy activation:

```text
Evidence & Codebase Manifests
              │
              ▼
   LLM Generation Prompt
              │
              ▼
  Structured JSON Proposal (DRAFT)
              │
              ▼
   Deterministic Schema Validation
              │
              ▼
   Conflict & Precedence Detection
              │
              ▼
 [Mandatory Human Approval Gate]
              │
              ▼
     State: ACTIVE (Persisted)
```

**Rule**: An LLM proposal must **NEVER** silently activate a mandatory policy without explicit developer sign-off at a governance gate.

---

## 7. `devweave-modernization-init` Extension

Modernization maintains three distinct intelligence domains:
1. **Legacy Engineering Intelligence**: How the legacy codebase currently functions (read-only invariant).
2. **Modernization Engineering Intelligence**: Transformation mappings, preserving required behavior:
   - `MIGRATED_TO`
   - `REPLACED_BY`
   - `TRANSFORMED_TO`
   - `SPLIT_INTO`
   - `MERGED_INTO`
   - `PRESERVED_AS`
   - `RETIRED`
   - `DEFERRED`
   - `UNKNOWN`
3. **Target Technology Intelligence**: Architectural best practices for the chosen target stack.

---

## 8. Contextual Resolver (`EngineeringIntelligenceResolver`) & Token Efficiency

To prevent token bloat (keeping prompts under a 1,500 token budget for intelligence), the resolver executes a 6-stage structured filter:

```text
   All Available Rules & Standards
                 │
                 ▼ [Filter 1: Technology Match]
        Technology-Specific Rules
                 │
                 ▼ [Filter 2: Version Compatibility]
        Version-Compatible Rules
                 │
                 ▼ [Filter 3: Workflow Mode (Normal vs Modernization)]
        Workflow-Relevant Rules
                 │
                 ▼ [Filter 4: Lifecycle Phase (Context, Plan, Implement, Review)]
        Phase-Applicable Rules
                 │
                 ▼ [Filter 5: Changed Areas (API, DB, UI, Security)]
        Area-Scoped Rules
                 │
                 ▼ [Filter 6: Active Exceptions Check]
     Resolved Rules (< 1,500 tokens)
```

### 8.1 Usage & Telemetry Metrics
Every invocation records:
- `rulesAvailable`: Total catalog rules.
- `rulesMatched`: Rules matching stack and phase.
- `rulesProvidedToModel`: Surgical subset injected into prompt.
- `skillsUsed`: Specific AI skills triggered.
- `policiesApplied`: Mandatory governance constraints evaluated.
- `standardsApplied`: Coding style/design conventions applied.

---

## 9. Knowledge Graph Integration

Engineering Intelligence directly extends `.devweave/graph/knowledge-graph.json` with typed nodes and directed edges:

### 9.1 Node Types
- `technology`
- `standard`
- `policy`
- `skill`
- `convention`
- `exception`

### 9.2 Edge Types
- `PROJECT --USES--> TECHNOLOGY`
- `PROJECT --HAS_STANDARD--> STANDARD`
- `TECHNOLOGY --HAS_SKILL--> SKILL`
- `TECHNOLOGY --HAS_POLICY--> POLICY`
- `TECHNOLOGY --HAS_VERSION--> VERSION`
- `LEGACY_TECHNOLOGY --MIGRATES_TO--> TARGET_TECHNOLOGY`
- `SKILL --APPLIES_TO--> TECHNOLOGY`
- `RULE --APPLIES_TO--> FILE`
- `RULE --APPLIES_TO--> MODULE`
- `WORK_ITEM --USES_INTELLIGENCE--> RULE`

---

## 10. Natural-Language Rule Creation and Versioned Updates

Developers can create or modify Engineering Intelligence rules via natural language prompts:
> *"All API controllers must enforce API versioning and require correlation ID headers."*

### 10.1 Processing Workflow:
1. **Analyze Natural Language Intent**: Map to rule type, scope, technology, severity, statement, and rationale.
2. **Generate Structured Proposal**: Create version `v1` (or incremental version `v2`).
3. **Diff & Conflict Detection**: Compare against existing standards to detect overlap or contradictory policies.
4. **Human Governance Checkpoint**: Prompt developer with proposed change and diff.
5. **Historical Retention**: Archive previous versions in `.devweave/intelligence/history/`. Historical versions are **never silently overwritten**.
6. **Activation**: Persist new version as `ACTIVE`.

---

## 11. Multi-Scope Conflict Detection & Expirable Exceptions

### 11.1 Precedence Hierarchy
When multiple guidance sources address the same topic, DevWeave resolves precedence deterministically:
1. `ORGANIZATION_DEFINED` (Highest)
2. `PROJECT_DEFINED`
3. `REPOSITORY_DEFINED`
4. `DEVELOPER_DEFINED`
5. `TECHNOLOGY_OFFICIAL`
6. `DEVWEAVE_RECOMMENDED`
7. `OBSERVED` (Lowest)

If a lower-priority rule contradicts a higher-priority `MANDATORY` rule without an approved exception, DevWeave flags `status = CONFLICTED` and blocks progression.

### 11.2 Formal Exception Model
Exceptions provide governed, temporary relief:
```json
{
  "exceptionId": "EXC-2026-001",
  "ruleId": "RULE-ERR-001",
  "scope": "MODULE:LegacyGateway",
  "reason": "Legacy upstream third-party service does not support RFC 7807.",
  "decision": "APPROVED",
  "approvedBy": "Principal Architect <architect@example.com>",
  "status": "ACTIVE",
  "expiresAt": "2026-12-31T23:59:59Z"
}
```
**Invariance**: Expired exceptions (`expiresAt < now`) are automatically treated as invalid, re-activating the mandatory standard.

---

## 12. Versioning, 24-Hour TTL & Incremental Refresh

- Every Engineering Intelligence artifact includes an explicit `version` (`1.0.0`, `1.1.0`, etc.) and `hash` fingerprint.
- **TTL Cache**: Reuses DevWeave's 24-hour TTL check. If cache age is `< 24h`, re-scanning is skipped.
- **Incremental Refresh**: When a project file changes, DevWeave compares the file's hash against the stored fingerprint. Only the affected technology slice is refreshed; untouched technologies remain intact.
- **Downstream Staleness Guard**: If an Engineering Intelligence rule changes after an approved `plan.md` or `analysis.md` was generated, DevWeave marks the downstream artifact as `NEEDS_REVALIDATION` and alerts the developer. It **NEVER silently overwrites** human-approved artifacts.

---

## 13. Lifecycle Phase Consumption Matrix

| Phase | Normal AI-DLC Action | Modernization Action |
| :--- | :--- | :--- |
| **Context** | Resolve applicable stack standards & active exceptions | Ingest Legacy EI + Target architecture intent |
| **Analyze** | Record applicable policies, impact boundaries, and rules | Map legacy behaviors to target standards; identify migration gaps |
| **Plan** | Embed engineering constraints into task blueprints | Define transformation tasks obeying target technology practices |
| **Branch** | Verify branch isolation | Verify branch isolation & read-only legacy protection |
| **Implement** | Inject resolved rules (< 1,500 tokens) to coding model | Transform legacy behavior into target stack without behavioral loss |
| **Verify** | Deterministic unit/integration test execution | Dual verification: Functional parity + Architectural adherence |
| **Review** | Dual-model audit against applicable Engineering Intelligence | Dual-model audit verifying migration mappings & anti-patterns |
| **PR** | Snapshot active intelligence version in PR package | Record migration mappings & update durable knowledge graph |

---
