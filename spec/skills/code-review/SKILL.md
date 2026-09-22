---
name: code-review
description: Evaluates changes from multiple perspectives including correctness, security, performance, and architecture.
---

# Code Review Skill

## Purpose
Perform qualitative, multi-perspective code inspection to ensure high maintainability, adherence to architecture patterns, security robustness, and token efficiency.

## When to Use
- During the `REVIEWING` phase prior to finalizing PR readiness.

## Inputs
- Full git diff of changes
- `requirements.md` and `solution.md`

## Required Context
- Code review checklist and conventions policy

## Procedure
1. Review diff for logical correctness and edge-case handling.
2. Inspect for security flaws (OWASP top 10, injection, insecure deserialization).
3. Evaluate algorithmic complexity and potential performance bottlenecks.
4. Assess architectural alignment and style consistency.
5. Generate `review.md`.

## Constraints
- Feedback must be actionable and cite specific line numbers.
- Avoid subjective nitpicking unless specified in repository conventions.

## Expected Artifacts
- `review.md` (conforming to `review-finding.schema.json`)

## Success Criteria
- Consensus approval with zero unresolved blocking findings.

## Failure Conditions
- Critical security vulnerabilities or logic defects detected in the diff.
