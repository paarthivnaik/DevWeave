# DevWeave AI-DLC Rules

When the `devweave` plugin is active, follow the declarative AI-DLC software engineering lifecycle:

## 1. General & V1.0 AI-DLC Rules
1. **Declarative State Awareness**: Always check `.devweave/state/current.json` before performing work on a task.
2. **Phase Boundary Integrity**: Progress through phases deterministically (`INIT` → `DISCOVERY` → `REQUIREMENTS` → `SOLUTION` → `APPROVAL` → `PLAN` → `IMPLEMENT` → `TEST` → `VERIFY` → `REVIEW` → `PR_READY`).
3. **Plan-Bound Implementation**: In the `IMPLEMENT` phase, restrict edits strictly to the tasks and files specified in the approved `plan.md`.
4. **Deterministic Verification**: Verify code against acceptance criteria, build status, and test execution before moving to `REVIEW`.
5. **Zero Secret Storage**: Never write raw credentials, PATs, or API keys into `.devweave/`, prompts, or Git history.
6. **Token Efficiency**: Load only the focused context and blast radius necessary for the current task.
7. **Mandatory Description Prompting (Optional Input)**: For every phase, it is **mandatory** to ask the developer/user if they have any additional description, context, or specific instructions. Providing input is **optional**; if the user provides none or opts to proceed, execute using standard defaults.
8. **Pre-Processing Transparency**: Before executing any phase processing, the agent must clearly state what it is about to do, which files/areas it will inspect or modify, and the exact objective of the action.
9. **Mandatory Story Audit Trail (`audit.md`)**: For every story/work item under `.devweave/work-items/<ID>/` (or `.devweave/stories/<ID>/`), maintain an append-only chronological `audit.md` logging all user prompts, custom descriptions, phase transitions, human decisions at governance gates, commands run, and modified artifacts with ISO timestamps.

## 2. V1.1 Modernization Lifecycle Rules
1. **Modernization State Awareness**: Check `.devweave/modernization/stories/<ID>/state.json` before performing modernization operations.
2. **Mandatory Hyphenated CLI Contract**: All modernization commands MUST use the hyphenated prefix `devweave-modernization-<phase>` (`init`, `context`, `analyze`, `plan`, `branch`, `implement`, `verify`, `pr`, `status`, `report`). Space-separated subcommands or colon prefixes are strictly prohibited.
3. **Human-in-the-Loop Hard Gates**: Strictly observe the 3 mandatory human checkpoints:
   - **Hard Gate #1 (Post-ANALYZE)**: Requires explicit `APPROVE` before planning.
   - **Hard Gate #2 (Post-PLAN)**: Requires explicit `APPROVE` before branch creation and implementation.
   - **Hard Gate #3 (Post-VERIFY)**: Requires explicit `APPROVE` before PR preparation.
4. **Zero Automatic Progression**: Every phase must stop immediately after persisting artifacts, state, and reporting next suggested command. Never auto-chain phases.
5. **Legacy Source Read-Only Invariance**: Legacy source repositories configured in `source-memory.json` are strictly `READ_ONLY`. Never mutate legacy code.
6. **Zero Fact Fabrication**: For new or empty target repositories, unobserved facts must remain `UNKNOWN` and unspecified decisions marked `AI_DETERMINED`.
7. **Technology Practice Intelligence**: Retrieve and enforce stack-aware practices (CQRS, SOLID, Clean Code, Security, DB indexing) matching the target technology profile.
8. **Mandatory Legacy Source Checkpoint (Blocking)**: In `devweave-modernization-init`, if `--source <path>` is not explicitly provided on the CLI, the agent **MUST NOT** proceed or generate `source-memory.json`. The agent **MUST IMMEDIATELY STOP AND ASK** the developer for the legacy repository path before inspecting or writing any files. Never default to the current directory without user confirmation.
9. **Zero State in INIT**: `devweave-modernization-init` writes ONLY static declarative project configuration (`workspace.json`, `architecture-intent.json`, `technology-profile.json`, `source-memory.json`). Lifecycle state tracking (`state.json`) is maintained strictly per-story under `.devweave/modernization/stories/<ID>/state.json`.
10. **Modernization Story Audit Trail (`audit.md`)**: For every modernization story under `.devweave/modernization/stories/<ID>/`, maintain an append-only chronological `audit.md` capturing all developer prompts, custom instructions, interactive branch configurations, phase transitions, hard gate approvals/rejections, feedback, executed commands, and created/modified artifacts with timestamps.
