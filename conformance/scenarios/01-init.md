# Scenario 01: Repository Initialization Conformance

## Objective
Verify that the host adapter can initialize a repository into DevWeave without modifying application code.

## Steps
1. Execute `devweave-init` on target repository.
2. Assert `.devweave/repository/` directory is created.
3. Assert `profile.md`, `architecture.md`, `technologies.md`, `build.md`, and `testing.md` exist and are non-empty.
4. Verify build and test commands match actual repository toolchains.
