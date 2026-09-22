# Scenario 11: Multi-Perspective Code Review Conformance

## Objective
Verify code review captures correctness, security, and performance perspectives with actionable line-referenced findings.

## Steps
1. Execute reviewer agents on git diff.
2. Validate review findings against `schemas/review-finding.schema.json`.
3. Assert findings indicate specific file, line, and required action.
