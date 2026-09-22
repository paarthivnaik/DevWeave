# Scenario 03: Requirements Conformance

## Objective
Verify that requirements generated conform to `requirement.schema.json` and contain testable criteria.

## Steps
1. Feed user prompt to `requirements-analyst`.
2. Validate output `requirements.md` against `schemas/requirement.schema.json`.
3. Assert at least one unambiguous acceptance criterion is present.
