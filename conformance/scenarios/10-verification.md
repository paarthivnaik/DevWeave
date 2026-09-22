# Scenario 10: Deterministic Verification Conformance

## Objective
Verify all configured linters, typecheckers, and compilers are executed and gated on zero exit codes.

## Steps
1. Execute `verifier` agent.
2. Validate output `verification.md` against `schemas/verification.schema.json`.
3. Assert overall status is `PASSED` only if every check exit code is 0.
