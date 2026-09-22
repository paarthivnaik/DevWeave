# DevWeave Core Antigravity Rules

## 1. AI-DLC Lifecycle Enforcement
- Strictly follow state machine transitions: `INIT` -> `DISCOVERED` -> `REQUIREMENTS_READY` -> `SOLUTION_READY` -> `APPROVED` -> `PLANNED` -> `IMPLEMENTING` -> `IMPLEMENTED` -> `TESTED` -> `VERIFIED` -> `REVIEWING` -> `REVIEWED` -> `PR_READY`.
- Do not jump to coding without an approved `plan.md` and `solution.md` unless using the `EXPRESS` workflow profile.

## 2. Token & Context Efficiency
- Never ingest entire directories or large lockfiles into context.
- Prioritize approved `.devweave/knowledge/` items over redundant repository discovery scans.
- Use targeted symbol lookups and minimal diff chunks.

## 3. Security & Safety Guards
- NEVER commit or output secrets, API keys, passwords, or private connection strings.
- Direct mutation of `PRODUCTION` databases or execution of destructive filesystem commands (`rm -rf /`) is strictly blocked.
- Require explicit human sign-off for critical architectural changes, database schema drops, and production deployments.

## 4. Deterministic Verification & Quality
- All modifications must pass native repository tests, linters, and type checkers before entering review.
- Ensure every code change traces back to an active task in `plan.md` and requirement in `requirements.md`.
