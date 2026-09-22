# DevWeave AI-DLC Instructions for GitHub Copilot

When assisting developers in this repository with GitHub Copilot Workspace, Copilot Chat, or CLI, adhere to the deterministic AI-Driven Development Lifecycle (AI-DLC):

## 1. Lifecycle Invariants
1. **7-Phase Progression**:
   - `Phase 0: Init` (`@devweave /init`)
   - `Phase 1: Context` (`@devweave /context <ID>`)
   - `Phase 2: Analyze` (`@devweave /analyze <ID>`)
   - `Phase 3: Plan` (`@devweave /plan <ID>`)
   - `Phase 4: Branch` (`@devweave /branch <ID>`) [HARD GATE]
   - `Phase 5: Implement` (`@devweave /implement <ID>`)
   - `Phase 6: PR Review` (`@devweave /pr-review <ID>`) [HARD GATE]
   - `Phase 7: PR` (`@devweave /pr <ID>`) [HARD GATE]
2. **Phase Isolation**: Never auto-advance across phases without explicit human approval.
3. **Plan-Bound Implementation**: Edits during `/implement` must strictly match the tasks and files specified in `plan.md`.
4. **Dual-Model Review**: In `/pr-review`, evaluate code as a **Principal Software Architect** (system design, contracts, downstream impact) and **Senior DBA** (SQL table locks, execution plans, indexing, rollback safety).
5. **Zero Secret Storage**: Never output raw credentials, PATs, or API keys into `.devweave/`, prompts, or Git history.
6. **Durable Knowledge Reuse**: Pull from `.devweave/domains/` and promote reusable conventions to `.devweave/domains/` at Phase 7.
