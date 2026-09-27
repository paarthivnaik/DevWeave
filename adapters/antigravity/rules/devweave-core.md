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

## 5. Engineering Intelligence Subsystem
- Discovered technologies are classified as `CURRENT` or `LEGACY` based on concrete file evidence; unobserved facts remain `UNKNOWN`.
- Legacy practices are documented as `OBSERVED` invariants and are strictly forbidden from becoming recommended best practices.
- Modernization operations orchestrate tripartite intelligence (Legacy EI + Modernization EI + Target Technology EI) with transformation relationships (`MIGRATED_TO`, `TRANSFORMED_TO`, `SPLIT_INTO`, `RETIRED`).
- Execute `EngineeringIntelligenceResolver` before code generation to inject relevant rules under a 1,500 token budget.
- LLM-generated mandatory rules require human approval before activation; rules are versioned (`v1` -> `v2`) with immutable history in `.devweave/intelligence/history/`.
- Precedence hierarchy resolves conflicts (`ORGANIZATION` > `PROJECT` > `REPOSITORY` > `DEVELOPER` > `OFFICIAL` > `RECOMMENDED` > `OBSERVED`); expired exceptions are automatically invalidated.
- Flag downstream artifacts as `NEEDS_REVALIDATION` when bound rules change; never silently rewrite approved artifacts.

## 6. Pre-Processing Transparency & Mandatory Description Checkpoint (Blocking)
- For every phase (including `devweave-init` and `devweave-modernization-init`), prior to executing any inspections, file modifications, or tool calls, the agent MUST state pre-processing transparency and ask the developer if they have any additional description, context, or specific instructions.
- The agent MUST IMMEDIATELY STOP CALLING TOOLS AND YIELD THE TURN. The agent MUST NOT call any tools or proceed in the same turn.
- Only after the developer responds (either providing custom instructions or confirming to proceed with defaults) may the agent begin phase execution.
