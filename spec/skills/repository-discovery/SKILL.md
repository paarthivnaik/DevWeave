---
name: repository-discovery
description: Scans, identifies, and documents repository technical dimensions, pin-to-pin architecture, layers, request flows, and multi-repo topology.
---

# Repository Discovery Skill

> **"Less Tokens. More Work. Lower Bill."**

## Purpose
Systematically inspect the repository structure, build scripts, manifest files, and configurations to extract architectural patterns, physical-to-logical layer mappings, request flows, and technical properties without loading redundant source files. Operates generically on any software repository.

## When to Use
- On initial onboarding of a repository to DevWeave (`INIT` phase).
- During the `DISCOVERY` phase of a work item when repository context is missing or stale.

## Inputs
- Repository root path
- Workspace structure (single-service, monorepo, or linked multi-repo workspace)
- File tree filtering patterns (excluding build artifacts and dependencies)

## Required Context
- Existing `.devweave/repository/` files (if present)
- Top-level directory listing and configuration manifests

## Procedure
1. Scan root configuration files (`package.json`, `*.csproj`, `pom.xml`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `Dockerfile`, etc.).
2. Identify primary languages, frameworks, test runners, and build commands across 5 progressive layers.
3. Map architectural layers and physical-to-logical directory organization (`layers.md`).
4. Trace end-to-end request flows and execution boundaries (`request-flow.md`).
5. Catalog external APIs, database connections, and event queues (`integrations.md`).
6. Map multi-service monorepo or multi-repo topology (`monorepo-map.md` if applicable).
7. Generate or update repository intelligence documents in `.devweave/repository/`.

## Constraints
- Do NOT read every source file; inspect only manifest, configuration, and entrypoint files.
- Never hardcode dependencies on specific host tools or proprietary environments.
- Zero modification to application source code during discovery.

## Expected Artifacts
- `.devweave/repository/profile.md`
- `.devweave/repository/architecture.md`
- `.devweave/repository/layers.md`
- `.devweave/repository/request-flow.md`
- `.devweave/repository/integrations.md`
- `.devweave/repository/technologies.md`
- `.devweave/repository/frameworks.md`
- `.devweave/repository/dependencies.md`
- `.devweave/repository/build.md`
- `.devweave/repository/testing.md`
- `.devweave/repository/practices.md`
- `.devweave/knowledge/conventions.md`
- `.devweave/state/current.json`

## Success Criteria
- Validated build and test commands documented.
- All primary technologies, framework versions, and physical-to-logical layers identified.
- Concrete request flow execution trace mapped.

## Failure Conditions
- Missing build/test commands without fallback identification.
- Ambiguous or unrecognized repository structure requiring human clarification.
