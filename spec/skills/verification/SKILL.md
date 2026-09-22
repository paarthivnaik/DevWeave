---
name: verification
description: Executes deterministic compilers, linters, type-checkers, and policy compliance scanners.
---

# Verification Skill

## Purpose
Enforce deterministic quality gates including build compilation, static analysis, type checking, formatting rules, and security scans.

## When to Use
- During the `VERIFY` phase and before code review.

## Inputs
- Modified repository state
- Build and verification command list

## Required Context
- `.devweave/repository/build.md`
- Active policy configurations

## Procedure
1. Run static analysis, type checking, and linters.
2. Run complete build compilation.
3. Check for security policy violations and exposed secrets.
4. Record exit codes and output logs into `verification.md`.

## Constraints
- Verification must use host-native or repository-native CLI tools without mocked pass states.

## Expected Artifacts
- `verification.md` (conforming to `verification.schema.json`)

## Success Criteria
- Zero errors reported across all configured verification checks.

## Failure Conditions
- Compiler errors, lint violations, type mismatches, or security policy failures.
