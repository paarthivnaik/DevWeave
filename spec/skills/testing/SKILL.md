---
name: testing
description: Authors and executes automated unit, integration, and regression test suites.
---

# Testing Skill

## Purpose
Validate modified software behavior against acceptance criteria through automated test execution and regression prevention.

## When to Use
- During the `TEST` phase and following incremental task implementations.

## Inputs
- `requirements.md` (acceptance criteria)
- Modified source files
- Test framework command lines

## Required Context
- Existing test suites, fixtures, and assertion idioms

## Procedure
1. Identify required test scenarios based on acceptance criteria and edge cases.
2. Author new unit/integration tests following repository conventions.
3. Execute test commands using the repository's native test runner.
4. Parse test results and capture execution metrics.
5. Generate `test-results.json`.

## Constraints
- Tests must be deterministic and avoid flaky timing dependencies.
- Never disable or delete existing valid tests to make a suite pass.

## Expected Artifacts
- Test source files
- `test-results.json` (conforming to `test-result.schema.json`)

## Success Criteria
- 100% of newly authored and existing regression tests pass.

## Failure Conditions
- Test failures, unhandled exceptions, or regression breaks.
