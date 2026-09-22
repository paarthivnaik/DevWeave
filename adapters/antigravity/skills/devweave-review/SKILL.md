---
name: devweave-review
description: Performs multi-perspective code review for correctness, security, and performance.
---

# DevWeave Review Skill (Antigravity)

## Instructions
1. Inspect the entire git diff.
2. Evaluate correctness, edge-case coverage, and architectural compliance.
3. Check for security vulnerabilities and performance anti-patterns.
4. Log all findings in `.devweave/work-items/<id>/review.md`.
5. Require resolution of all blocking findings prior to marking PR_READY.
