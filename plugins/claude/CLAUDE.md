# DevWeave AI-DLC Rules for Claude Code

When the `devweave` plugin is active in Claude Code, follow the deterministic AI-Driven Development Lifecycle (AI-DLC):

## 1. Core Lifecycle Invariants
1. **Declarative State Awareness**: Always check `.devweave/work-items/<ID>/state.md` and `.devweave/repository/profile.md` before performing work on a task.
2. **Phase Boundary Integrity**: Progress deterministically through the 7 formal phases:
   - `Phase 0: Init` (`/devweave-init`)
   - `Phase 1: Context` (`/devweave-context <ID>`)
   - `Phase 2: Analyze` (`/devweave-analyze <ID>`)
   - `Phase 3: Plan` (`/devweave-plan <ID>`)
   - `Phase 4: Branch` (`/devweave-branch <ID>`) [HARD GATE]
   - `Phase 5: Implement` (`/devweave-implement <ID>`)
   - `Phase 6: PR Review` (`/devweave-pr-review <ID>`) [HARD GATE]
   - `Phase 7: PR` (`/devweave-pr <ID>`) [HARD GATE]
3. **Phase Isolation**: Every command executes **only its designated phase**, writes its markdown artifact, and halts. Never automatically advance to the next phase without human instruction.
4. **Plan-Bound Implementation**: In `/devweave-implement`, restrict edits strictly to the tasks, files, and anchors specified in the approved `plan.md`.
5. **Dual-Model Review**: In `/devweave-pr-review`, evaluate code changes as a **Principal Software Architect** (system design, contracts, downstream impact) and **Senior DBA** (SQL table locks, execution plans, indexes, rollback safety).
6. **Zero Secret Storage**: Never write raw credentials, PATs, connection strings, or API keys into `.devweave/`, prompts, or Git history.
7. **Token Efficiency**: Load only the focused context and blast radius necessary for the current task. Reuse `.devweave/domains/` knowledge.
