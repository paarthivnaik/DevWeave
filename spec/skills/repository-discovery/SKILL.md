---
name: repository-discovery
description: Scans, identifies, and documents repository technical dimensions and architecture.
---

# Repository Discovery Skill

## Purpose
Systematically inspect the repository structure, build scripts, manifest files, and configurations to extract architectural patterns and technical properties without loading redundant source files.

## When to Use
- On initial onboarding of a repository to DevWeave.
- During the `DISCOVERY` phase of a work item when repository context is missing or stale.

## Inputs
- Repository root path
- File tree filtering patterns (excluding build artifacts and dependencies)

## Required Context
- Existing `.devweave/repository/` files (if present)
- Top-level directory listing and configuration manifests

## Procedure
1. Scan root configuration files (`package.json`, `*.csproj`, `pom.xml`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `Dockerfile`, etc.).
2. Identify primary languages, frameworks, test runners, and build commands.
3. Map architectural layers and high-level module organization.
4. Generate or update repository profile documents in `.devweave/repository/`.

## Constraints
- Do NOT read every source file; inspect only manifest and configuration files.
- Never hardcode dependencies on specific host tools or proprietary environments.

## Expected Artifacts
- `.devweave/repository/profile.md`
- `.devweave/repository/architecture.md`
- `.devweave/repository/technologies.md`
- `.devweave/repository/build.md`
- `.devweave/repository/testing.md`

## Success Criteria
- Validated build and test commands documented.
- All primary technologies and framework versions identified.

## Failure Conditions
- Missing build/test commands.
- Ambiguous or unrecognized repository structure requiring human clarification.
