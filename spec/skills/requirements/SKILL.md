---
name: requirements
description: Translates user intent into unambiguous, testable engineering requirements and acceptance criteria.
---

# Requirements Engineering Skill

## Purpose
Synthesize user prompts, issue descriptions, or task tickets into structured functional and non-functional requirements with concrete acceptance criteria.

## When to Use
- During the `REQUIREMENTS` phase of feature, bug, security, or refactor work items.

## Inputs
- Work item request / user prompt
- Discovered repository capabilities and domain knowledge

## Required Context
- Relevant `.devweave/knowledge/domain/` rules
- Existing requirements baseline (if modifying existing features)

## Procedure
1. Parse user intent and isolate primary goals.
2. Identify functional requirements and edge cases.
3. Formulate non-functional constraints (performance, security, backward compatibility).
4. Define testable, objective acceptance criteria.
5. Compile `requirements.md` artifact.

## Constraints
- Requirements must be technology-agnostic where possible.
- Avoid vague statements (e.g. "must be fast"); define quantifiable metrics.

## Expected Artifacts
- `requirements.md` (conforming to `requirement.schema.json`)

## Success Criteria
- Acceptance criteria are 100% testable and unambiguous.
- Out-of-scope boundaries are clearly articulated.

## Failure Conditions
- Ambiguous user specifications that require interactive user clarification.
