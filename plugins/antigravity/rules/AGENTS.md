# DevWeave AI-DLC Rules

When the `devweave` plugin is active, follow the declarative AI-DLC software engineering lifecycle:

1. **Declarative State Awareness**: Always check `.devweave/state/current.json` before performing work on a task.
2. **Phase Boundary Integrity**: Progress through phases deterministically (`INIT` → `DISCOVERY` → `REQUIREMENTS` → `SOLUTION` → `APPROVAL` → `PLAN` → `IMPLEMENT` → `TEST` → `VERIFY` → `REVIEW` → `PR_READY`).
3. **Plan-Bound Implementation**: In the `IMPLEMENT` phase, restrict edits strictly to the tasks and files specified in the approved `plan.md`.
4. **Deterministic Verification**: Verify code against acceptance criteria, build status, and test execution before moving to `REVIEW`.
5. **Zero Secret Storage**: Never write raw credentials, PATs, or API keys into `.devweave/`, prompts, or Git history.
6. **Token Efficiency**: Load only the focused context and blast radius necessary for the current task.
