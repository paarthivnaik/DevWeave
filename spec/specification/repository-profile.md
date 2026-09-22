# DevWeave Repository Profile Specification

The Repository Profile is the canonical directory structure and set of structured markdown files where discovered repository intelligence is persisted for long-term agent reuse.

---

## 1. Directory Structure

Repository profiles are stored in the standard `.devweave/repository/` (or legacy `.aidlc/repository/`) path within the target repository root:

```text
.devweave/
└── repository/
    ├── profile.md          # Executive summary, repo classification, key contacts
    ├── architecture.md     # High-level architecture, module boundaries, design patterns
    ├── technologies.md     # Primary languages, frameworks, runtimes, and versions
    ├── dependencies.md     # Key libraries, dependency managers, external service integrations
    ├── build.md            # Exact build commands, environment variables, compiler configurations
    ├── testing.md          # Unit/integration test commands, coverage requirements, mocking rules
    ├── database.md         # Schema definitions, ORM details, migration execution commands
    ├── deployment.md       # Containerization, deployment environments, CI/CD pipeline triggers
    └── security.md         # Security rules, authentication/authorization patterns, sanitization policies
```

---

## 2. File Specifications

### `profile.md`
Summary of repository name, domain purpose, tech stack summary, repository type (monorepo/polyrepo), active maintainers, and default branch policies.

### `architecture.md`
Component diagrams, module relationships, layering principles (e.g. Domain-Driven Design, Clean Architecture), and state management conventions.

### `technologies.md`
Tabular breakdown of language versions, core libraries, package registries, and compiler toolchains.

### `build.md` & `testing.md`
Deterministic executable command lines (e.g., `npm run build`, `dotnet build`, `pytest`, `cargo test`) with expected exit codes, prerequisite environment variables, and typical execution runtimes.
