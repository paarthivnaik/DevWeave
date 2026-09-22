---
name: devweave-init
description: Initializes DevWeave intelligence, discovers repo profile, and sets up .devweave directory.
---

# DevWeave Initialization Skill

## Instructions
1. Inspect the workspace root for package manifests (`package.json`, `*.csproj`, `pom.xml`, `go.mod`, `Cargo.toml`, `pyproject.toml`, etc.).
2. Determine primary languages, frameworks, build commands, and test runners.
3. Create the `.devweave/` directory structure:
   - `.devweave/repository/`
   - `.devweave/knowledge/`
   - `.devweave/work-items/`
   - `.devweave/state/`
4. Generate the baseline repository profile files:
   - `profile.md`
   - `architecture.md`
   - `technologies.md`
   - `build.md`
   - `testing.md`
5. Report discovery summary to the user.
