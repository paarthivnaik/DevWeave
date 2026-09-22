---
name: planning
description: Breaks down approved solutions into atomic, ordered, and verifiable implementation steps.
---

# Planning Skill

## Purpose
Convert an approved technical solution into a sequenced execution graph of discrete, verifiable tasks.

## When to Use
- During the `PLAN` phase before writing implementation code.

## Inputs
- `solution.md`
- `requirements.md`

## Required Context
- Target file paths and dependencies
- Build and test commands

## Procedure
1. Identify atomic implementation units (models, services, UI components, tests).
2. Establish dependency ordering between tasks.
3. Define exact target files and specific verification criteria for each task.
4. Compile `plan.md`.

## Constraints
- Each task must be independently verifiable where possible.
- Avoid overly monolithic tasks that span multiple disparate modules.

## Expected Artifacts
- `plan.md` (conforming to `plan.schema.json` and `task.schema.json`)

## Success Criteria
- Sequenced plan covers 100% of solution requirements with explicit validation checks.

## Failure Conditions
- Circular task dependencies or missing target file paths.
