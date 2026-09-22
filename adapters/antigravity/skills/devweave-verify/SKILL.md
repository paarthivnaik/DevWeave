---
name: devweave-verify
description: Executes deterministic compilers, linters, typecheckers, and policy compliance scanners.
---

# DevWeave Verify Skill (Antigravity)

## Instructions
1. Run static analysis and lint commands (`npm run lint`, `dotnet format --verify-no-changes`, `flake8`, `golangci-lint`).
2. Run complete build compilation.
3. Perform security and secrets scanning.
4. Record all results in `.devweave/work-items/<id>/verification.md`.
5. Gate state transition based on zero failures.
