---
name: solution-design
description: Architects technical solutions, interface contracts, and evaluates design trade-offs.
---

# Solution Design Skill

## Purpose
Formulate a robust, idiomatic technical solution that satisfies requirements while adhering to repository architectural patterns.

## When to Use
- During the `SOLUTION` phase of non-trivial work items.

## Inputs
- `requirements.md`
- `context.json`
- Architecture guidelines

## Required Context
- Existing pattern conventions and domain rules

## Procedure
1. Evaluate architectural options and trade-offs.
2. Formulate target component changes and interface modifications.
3. Assess backward compatibility and data model impacts.
4. Record key decisions (ADRs) if fundamental patterns are altered.
5. Generate `solution.md`.

## Constraints
- Must not introduce unapproved external dependencies without explicit rationale.
- Must preserve established project idioms and naming conventions.

## Expected Artifacts
- `solution.md` (conforming to `solution.schema.json`)
- Optional: `decision.md` (conforming to `decision.schema.json`)

## Success Criteria
- Clear, unambiguous design ready for approval and planning.

## Failure Conditions
- Unresolved architectural conflicts or breaking interface changes without migration path.
