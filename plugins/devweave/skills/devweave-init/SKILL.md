---
name: devweave-init
description: Initialize DevWeave in the repository where the Skill is executed by autonomously detecting technology stack across 5 layers and establishing repository knowledge.
---

# DevWeave Initialization Skill (`devweave-init`)

## Purpose
Autonomously inspect the target workspace repository, detect its complete technology stack across 5 evidence-based layers, and establish reusable repository intelligence and lifecycle state without modifying application code.

---

## Execution Workflow

### Step 1: Progressive 5-Layer Technology Detection
Execute targeted inspection of repository manifests, project files, lockfiles, and configuration:

1. **Layer 1 — Repository Structure**:
   - Inspect workspace root for project topology (monorepo, single service, microservices, frontend/backend separation, database migrations, CI/CD workflows).
2. **Layer 2 — Programming Languages**:
   - Detect all languages present with confidence scores (`HIGH`, `MEDIUM`, `LOW`) based on manifest files (`package.json`, `*.csproj`, `*.sln`, `pom.xml`, `build.gradle`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `requirements.txt`, `composer.json`, `Gemfile`, `CMakeLists.txt`). Support polyglot repositories.
3. **Layer 3 — Frameworks & Engines**:
   - Detect active web, ORM, and UI frameworks (e.g., ASP.NET Core, Angular, React, Spring Boot, Laravel, Rails, FastAPI, Django, Express, NestJS).
4. **Layer 4 — Libraries & Tooling**:
   - Detect ORMs (EF Core, Prisma, Hibernate, SQLAlchemy), build tools (dotnet, npm, maven, gradle, cargo, cmake), and test runners (xUnit, pytest, Jest, JUnit, PHPUnit, Karma).
5. **Layer 5 — Versions & Capabilities**:
   - Extract exact runtime versions and dependency targets from lockfiles or project definitions. Record `unknown` if version cannot be determined from evidence; never guess.

---

### Step 2: Project Management & Capability Detection
- Check whether an external project-management MCP server (Jira, Azure DevOps, GitHub, GitLab, Linear) is configured in the environment.
- If detected, record available capabilities (`readWorkItems`, `updateWorkItems`, `transitionStatus`).
- If not configured, record `projectManagement.enabled = false` and use local manual input fallback.
- **Security Rule**: Never write Personal Access Tokens (PATs), API keys, or raw secrets into any artifact.

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
│   ├── architecture.md     # Component layout, entry points, and module boundaries
│   └── practices.md        # Applicable best practices and anti-patterns
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
DevWeave initialization completed.

Repository: <repository-name>
Topology: <monorepo / single-service / multi-project>
Languages: <detected languages with versions & confidence>
Frameworks: <detected web/ORM/UI frameworks>
Build Tools: <detected build commands>
Testing Runners: <detected test frameworks & commands>
Project Management MCP: <Configured (Provider Name) / Not Configured (Local Fallback)>
Artifacts: Created 10/10 intelligence artifacts under .devweave/

Next recommended action:
Start your first work item using: DevWeave-context <WorkItemId>
```
