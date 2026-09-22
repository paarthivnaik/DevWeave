# Scenario 04: Context Assembly & Budgeting Conformance

## Objective
Verify context payload respects token budget and excludes extraneous files.

## Steps
1. Execute context assembly for an isolated component change.
2. Validate output `context.json` against `schemas/context.schema.json`.
3. Assert total estimated tokens do not exceed allocated effort budget.
