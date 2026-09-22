# Scenario 09: Test Execution Conformance

## Objective
Verify automated tests are executed using repo-native tools and results parsed into `test-result.schema.json`.

## Steps
1. Execute repository test runner via `tester` agent.
2. Verify `test-results.json` conforms to `schemas/test-result.schema.json`.
3. Assert pass/fail counts accurately reflect test output.
