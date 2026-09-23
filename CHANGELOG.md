# Changelog

All notable changes to DevWeave will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.2] - 2026-09-23
### Added
- **2-Tier Hierarchical Workspace Architecture**: Separates central project configuration (`.devweave/modernization/` with `workspace.json`, `architecture-intent.json`, `technology-profile.json`, `source-memory.json`) from story-level deliverables (`.devweave/modernization/stories/<ID>/`), eliminating duplicated project questionnaires and configs.
- **Interactive Branch & Base Branch Selection**: Added `--name <branch>` and `--base <branch>` parameters along with interactive prompting and natural language phrasing (`"create feature/99-User-Registration from master"`) to `devweave-branch` and `devweave-modernization-branch`.
- **User-Only Story Audit Trail (`audit.md`)**: Enforced append-only audit trail capturing exclusively human developer activities with author attribution (`Author: <User Name> <email@example.com>`), filtering out internal framework machinery.
- **Blocking Legacy Source Path Checkpoint**: In `devweave-modernization-init`, if `--source <path>` is omitted on CLI, the agent blocks execution and interactively asks for the legacy repository path before inspecting or writing any files.
- **PM Tool Intake & Auto-Connect Persistence**: First-time PM tool selection (`jira`, `ado`, `github`, `linear`, `manual`) persists to `workspace.json` and auto-connects without re-prompting on subsequent invocations.
- **Multi-Host Parity**: Synchronized all features across all 6 AI coding host platforms (Antigravity, Claude Code, Gemini CLI, GitHub Copilot, OpenAI Codex, Cognition Devin).

## [1.1.0] - 2026-09-23
### Added
- **V1.1 Modernization Lifecycle**: 8-phase deterministic workflow (`INIT`, `CONTEXT`, `ANALYZE`, `PLAN`, `BRANCH`, `IMPLEMENT`, `VERIFY`, `PR`) with 3 Human-in-the-Loop Hard Governance Gates.
- **10 Antigravity Modernization Skills**: `devweave-modernization-init`, `devweave-modernization-context`, `devweave-modernization-analyze`, `devweave-modernization-plan`, `devweave-modernization-branch`, `devweave-modernization-implement`, `devweave-modernization-verify`, `devweave-modernization-pr`, `devweave-modernization-status`, `devweave-modernization-report`.
- **Modernization Schemas**: `modernization-state.schema.json`, `architecture-intent.schema.json`, `technology-profile.schema.json`, `source-memory.schema.json`, `migration-unit.schema.json`, `mappings.schema.json`.
- **Shared Test Intelligence (V1.0 & V1.1)**: Atomic code & test updates during `IMPLEMENT`, E2E framework auto-detection (Playwright, Cypress, Selenium), failure classification (`IMPLEMENTATION_DEFECT`, `EXPECTED_BEHAVIOR_CHANGE`, `UNRELATED_REGRESSION`) preventing test weakening.
- **Test Intelligence Schemas**: `test-impact.schema.json`, `test-plan.schema.json`, `test-traceability.schema.json`.
- **Governance & UX Rules**: Mandatory developer description prompting (optional input) and pre-processing transparency across all lifecycle phases.
- **Conformance Test Suites**: Added 4 new test suites (`validate_modernization_cli.ps1`, `validate_modernization_state.ps1`, `validate_modernization_e2e.ps1`, `validate_test_intelligence.ps1`), expanding master test runner to 10/10 passing suites.

## [1.0.0] - 2026-09-22
### Added
- Unified DevWeave monorepo structure
- Canonical AI-DLC lifecycle specification (`spec/`)
- 13 machine-readable JSON Schemas and test fixtures (`spec/schemas/`)
- 11 canonical skill definitions (`spec/skills/`) and 9 agent archetypes (`spec/agents/`)
- Reference host adapter for Google Antigravity (`adapters/antigravity/`)
- 18 end-to-end conformance test scenarios (`conformance/scenarios/`)
- System architecture and user guides (`docs/`)
