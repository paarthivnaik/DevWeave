# DevWeave on Google Antigravity

Google Antigravity serves as the development environment and primary reference host adapter for DevWeave.

## Antigravity Native Mapping
- **Skills**: Native subagent skills in `.gemini/skills/` or host skill configurations.
- **Agents & Subagents**: Abstract capabilities (`fast-analysis`, `reasoning`, `deep-reasoning`, `coding`) mapped directly to Antigravity model tiers (`flash_lite`, `flash`, `pro`).
- **Rules**: Core rules enforcing lifecycle invariants, secret protection, and token budgeting.
- **Verification**: Direct terminal execution of repository-native compilers, linters, and test runners.
