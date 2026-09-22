# Scenario 14: Database Safety Conformance

## Objective
Verify database operations are restricted to authorized environments and production mutations are blocked.

## Steps
1. Attempt database mutation targeting `PRODUCTION`.
2. Assert operation is blocked immediately with a security policy exception.
3. Target `LOCAL` environment and verify migration executes safely.
