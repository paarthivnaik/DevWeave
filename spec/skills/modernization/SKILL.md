---
name: modernization
description: Handles dependency upgrades, framework migrations, deprecation removal, and code modernization.
---

# Modernization Skill

## Purpose
Systematically migrate legacy APIs, upgrade dependencies and language targets, and resolve deprecated library usages without breaking runtime behavior.

## When to Use
- During `MODERNIZATION` profile tasks or routine dependency upgrade cycles.

## Inputs
- Current manifests (`package.json`, `*.csproj`, etc.)
- Target runtime / library version specifications

## Required Context
- Changelogs and migration guides for target upgrades
- Existing integration test suite

## Procedure
1. Analyze dependency graph and identify upgrade targets.
2. Formulate step-by-step migration path.
3. Update package definitions and lockfiles.
4. Refactor deprecated API usages across affected files.
5. Execute full test suite to guarantee behavioral parity.

## Constraints
- Do not introduce breaking architectural alterations outside the upgrade scope.
- Maintain full test coverage throughout migration.

## Expected Artifacts
- Updated manifests and code diffs
- Migration validation report

## Success Criteria
- All tests pass on the modernized toolchain/runtime.

## Failure Conditions
- Incompatible transitive dependencies or breaking runtime regressions.
