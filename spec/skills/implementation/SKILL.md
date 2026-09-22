---
name: implementation
description: Executes precise, idiomatic source code edits according to approved plans.
---

# Implementation Skill

## Purpose
Apply code modifications incrementally to the codebase according to the ordered task plan.

## When to Use
- During the `IMPLEMENTING` phase.

## Inputs
- `plan.md` (current active task)
- Target file content
- Style guide and convention rules

## Required Context
- Active task specification and file diff context

## Procedure
1. Load target file lines or structure.
2. Formulate minimal, precise code edits.
3. Apply changes preserving existing formatting, comments, and docstrings.
4. Run task-level verification check.
5. Update task status in plan.

## Constraints
- Do not perform unprompted refactoring outside the active task scope.
- Maintain documentation integrity and existing comments.

## Expected Artifacts
- Modified source code files
- Incremental diffs

## Success Criteria
- Code matches specified solution and compiles without syntax or type errors.

## Failure Conditions
- Syntax errors, broken references, or unresolvable compilation failures.
