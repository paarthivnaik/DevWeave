# DevWeave Developer Handbook & Universal Guide

> **"Less Tokens. More Work. Lower Bill."**

Welcome to the **DevWeave Universal Developer Guide**. This comprehensive handbook explains how to install, use, and update DevWeave across any AI coding host, along with an in-depth reference for all 31 commands and skills.

---

## 📑 Table of Contents
1. [Core Philosophy & Architecture](#1-core-philosophy--architecture)
2. [1-Click Installation (All 6 Hosts)](#2-1-click-installation-all-6-hosts)
   - [Google Antigravity](#google-antigravity)
   - [Anthropic Claude Code](#anthropic-claude-code)
   - [GitHub Copilot](#github-copilot)
   - [Google Gemini CLI](#google-gemini-cli)
   - [OpenAI Codex / ChatGPT CLI](#openai-codex)
   - [Cognition Devin](#cognition-devin)
3. [Plugin Updates & Daily Auto-Sync](#3-plugin-updates--daily-auto-sync)
4. [Complete Command & Skill Reference](#4-complete-command--skill-reference)
5. [Step-by-Step Tutorial: Your First 5 Minutes](#5-step-by-step-tutorial-your-first-5-minutes)
6. [Troubleshooting & Offline Mode](#6-troubleshooting--offline-mode)

---

## 1. Core Philosophy & Architecture

Standard AI coding tools suffer from **context window bloat**: they repeatedly read whole codebases into context, re-discover frameworks every turn, and waste expensive tokens.

DevWeave introduces **Declarative AI-DLC (AI-Driven Development Lifecycle)**:
- **Discovered Once**: Your codebase architecture, physical-to-logical layers, and dependencies are detected once during `INIT` and stored in structured markdown files (`.devweave/repository/`).
- **Plan-Bound Implementation**: Edits in `IMPLEMENT` are strictly restricted to the files specified in the approved `plan.md`.
- **Durable Knowledge**: Proven patterns are saved to `.devweave/knowledge/` so future sessions achieve **0-token rediscovery**.
- **Result**: **84%–93% token savings** and **95%–99% lower API bills**.

---

## 2. 1-Click Installation (All 6 Hosts)

DevWeave requires no background services, daemons, or server infrastructure. It installs directly from GitHub in one command:

### Google Antigravity
Installs the native Antigravity plugin package containing 21 validated skills:

- **Windows (PowerShell)**:
  ```powershell
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; agy plugin install $env:TEMP\devweave\plugins\antigravity; Remove-Item -Recurse -Force $env:TEMP\devweave
  ```
- **macOS / Linux (Bash)**:
  ```bash
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && agy plugin install /tmp/devweave/plugins/antigravity && rm -rf /tmp/devweave
  ```
- **Verification**:
  ```bash
  agy plugin list
  ```

---

### Anthropic Claude Code
Installs custom slash commands and AI-DLC behavioral rules into your project or global directory:

- **Windows (PowerShell)**:
  ```powershell
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .claude\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\claude\CLAUDE.md .\CLAUDE.md; Copy-Item $env:TEMP\devweave\plugins\claude\commands\* .claude\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
  ```
- **macOS / Linux (Bash)**:
  ```bash
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .claude/commands && cp /tmp/devweave/plugins/claude/CLAUDE.md ./CLAUDE.md && cp /tmp/devweave/plugins/claude/commands/* .claude/commands/ && rm -rf /tmp/devweave
  ```
- **Verification**:
  ```bash
  claude /devweave-init
  ```

---

### GitHub Copilot
Installs workspace instructions and prompt files into `.github/`:

- **Windows (PowerShell)**:
  ```powershell
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .github\prompts | Out-Null; Copy-Item $env:TEMP\devweave\plugins\copilot\copilot-instructions.md .github\copilot-instructions.md; Copy-Item $env:TEMP\devweave\plugins\copilot\prompts\* .github\prompts\; Remove-Item -Recurse -Force $env:TEMP\devweave
  ```
- **macOS / Linux (Bash)**:
  ```bash
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .github/prompts && cp /tmp/devweave/plugins/copilot/copilot-instructions.md .github/copilot-instructions.md && cp /tmp/devweave/plugins/copilot/prompts/* .github/prompts/ && rm -rf /tmp/devweave
  ```
- **Verification**: Type `@devweave /init` in Copilot Chat (VS Code or Visual Studio).

---

### Google Gemini CLI
Installs Gemini CLI command workflows and rules:

- **Windows (PowerShell)**:
  ```powershell
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .gemini\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\gemini\GEMINI.md .gemini\GEMINI.md; Copy-Item $env:TEMP\devweave\plugins\gemini\commands\* .gemini\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
  ```
- **macOS / Linux (Bash)**:
  ```bash
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .gemini/commands && cp /tmp/devweave/plugins/gemini/GEMINI.md .gemini/GEMINI.md && cp /tmp/devweave/plugins/gemini/commands/* .gemini/commands/ && rm -rf /tmp/devweave
  ```
- **Verification**:
  ```bash
  gemini devweave-init
  ```

---

### OpenAI Codex
Installs system prompts and command playbooks:

- **Windows (PowerShell)**:
  ```powershell
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .codex\commands | Out-Null; Copy-Item $env:TEMP\devweave\plugins\codex\CODEX.md .codex\CODEX.md; Copy-Item $env:TEMP\devweave\plugins\codex\commands\* .codex\commands\; Remove-Item -Recurse -Force $env:TEMP\devweave
  ```
- **macOS / Linux (Bash)**:
  ```bash
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .codex/commands && cp /tmp/devweave/plugins/codex/CODEX.md .codex/CODEX.md && cp /tmp/devweave/plugins/codex/commands/* .codex/commands/ && rm -rf /tmp/devweave
  ```
- **Verification**:
  ```bash
  $devweave init
  ```

---

### Cognition Devin
Installs playbook definitions and tool configuration into your Devin workspace:

- **Windows (PowerShell)**:
  ```powershell
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; New-Item -ItemType Directory -Force -Path .devin\playbooks | Out-Null; Copy-Item $env:TEMP\devweave\plugins\devin\DEVIN.md .devin\DEVIN.md; Copy-Item $env:TEMP\devweave\plugins\devin\commands\* .devin\playbooks\; Remove-Item -Recurse -Force $env:TEMP\devweave
  ```
- **macOS / Linux (Bash)**:
  ```bash
  git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && mkdir -p .devin/playbooks && cp /tmp/devweave/plugins/devin/DEVIN.md .devin/DEVIN.md && cp /tmp/devweave/plugins/devin/commands/* .devin/playbooks/ && rm -rf /tmp/devweave
  ```
- **Verification**: Run `devweave:init` in your Devin session.

---

## 3. Plugin Updates & Daily Auto-Sync

DevWeave includes an automated update mechanism so developers never need manual uninstall/reinstall cycles:

### 1. Automatic Daily Sync (24-Hour TTL)
- On your **first session of each calendar day**, DevWeave silently checks remote GitHub `HEAD` and syncs any new features, skills, or rules in-place.
- For all subsequent sessions that day, it executes with **0ms latency** using the local cache (`~/.devweave/update-cache.json`).
- Consumes **0 LLM tokens**.

### 2. Manual On-Demand Update Command
To update immediately at any time, run the update command in your AI assistant:

| Host | Command |
| :--- | :--- |
| **Google Antigravity** | `agy run devweave-update` |
| **Anthropic Claude Code** | `/devweave-update` |
| **GitHub Copilot** | `@devweave /update` |
| **Google Gemini CLI** | `gemini devweave-update` |
| **OpenAI Codex** | `$devweave update` |
| **Cognition Devin** | `devweave:update` |

---

## 4. Complete Command & Skill Reference

DevWeave provides **31 specialized skills and commands** organized into the Canonical Lifecycle, V1.1 Modernization Lifecycle, Fast Lanes, and Utility commands.

### Two Universal Interaction Rules
Across all skills and commands, DevWeave strictly abides by:
1. **Mandatory Description Prompting (Optional Input)**: Prompts the developer for optional instructions or constraints before proceeding.
2. **Pre-Processing Transparency ("State Intent Before Action")**: Announces all inspection targets, file changes, and objectives prior to execution.

---

### Phase 0 to 7: Canonical Feature Lifecycle (8 Commands)

```text
INIT ──► CONTEXT ──► ANALYZE ──► PLAN ──► BRANCH [GATE] ──► IMPLEMENT ──► REVIEW [GATE] ──► PR [GATE]
```

#### 1. `devweave-init` — Autonomous 5-Layer Stack Discovery
- **Host Syntax**: `agy run devweave-init` | `/devweave-init` | `@devweave /init` | `gemini devweave-init` | `$devweave init` | `devweave:init`
- **When to Use**: Once when opening a new repository or after major framework migrations.
- **What it Does**: Scans manifests across 5 progressive layers (Topology, Languages, Frameworks, Tooling, Versions). Synthesizes pin-to-pin architecture, physical-to-logical layer mapping, request flow traces, and multi-repo service links.
- **Zero Modification Guarantee**: Never alters application code.
- **Output Artifacts**: `.devweave/repository/profile.md`, `layers.md`, `request-flow.md`, `technologies.md`, `frameworks.md`, `dependencies.md`, `build.md`, `testing.md`, `practices.md`, `graph/knowledge-graph.json`.

#### 2. `devweave-context <ID>` — Work Item Intake & PII Gate
- **Host Syntax**: `agy run devweave-context PROJ-123` | `/devweave-context PROJ-123`
- **When to Use**: At the start of every ticket, bug, or user story.
- **What it Does**: Ingests issue details from Jira, GitHub, Azure DevOps, Linear, or manual input. Runs a mandatory PII/secret sanitizer, calculates the precise codebase blast radius (`focus_paths`), and enforces a token budget (e.g. 32k tokens).
- **Output Artifacts**: `.devweave/tasks/<ID>/context.md`.

#### 3. `devweave-analyze <ID>` — Architectural Impact & Deep Archaeology
- **Host Syntax**: `agy run devweave-analyze PROJ-123`
- **When to Use**: After context is built, before designing the technical solution.
- **What it Does**: Inspects relevant components within the blast radius, identifies database schema touchpoints, checks interface contracts, and evaluates breaking change risks.
- **Output Artifacts**: `.devweave/tasks/<ID>/analysis.md`.

#### 4. `devweave-plan <ID>` — Atomic Implementation Task Breakdown
- **Host Syntax**: `agy run devweave-plan PROJ-123`
- **When to Use**: To produce an approved engineering plan before writing code.
- **What it Does**: Decomposes the task into atomic, sequentially numbered tasks with exact file targets, line anchors, test specs, and deterministic test commands.
- **Output Artifacts**: `.devweave/tasks/<ID>/plan.md`.

#### 5. `devweave-branch <ID>` — Git Branch Isolation & Branch Gate
- **Host Syntax**: `agy run devweave-branch PROJ-123`
- **When to Use**: Before writing code to guarantee branch safety.
- **What it Does**: Validates branch naming conventions (`feature/PROJ-123-short-desc`), verifies base commit alignment, and strictly blocks implementation directly on `main` or `master`.
- **Output Artifacts**: Isolated Git working branch created.

#### 6. `devweave-implement <ID>` — Plan-Bound Surgical Coding & Test Intelligence
- **Host Syntax**: `agy run devweave-implement PROJ-123`
- **When to Use**: To execute the approved plan.
- **What it Does**: Performs targeted, localized edits strictly on the files authorized in `plan.md`. Employs **Test Intelligence**: production code and test edits form an atomic changeset. Automatically classifies test failures into `IMPLEMENTATION_DEFECT` (fix production code), `EXPECTED_BEHAVIOR_CHANGE` (update test with audit trail), or `UNRELATED_REGRESSION`. Strictly forbids weakening assertions or deleting tests.
- **Output Artifacts**: Code modifications and test evidence in `.devweave/tasks/<ID>/evidence.md` and `test-results.json`.

#### 7. `devweave-pr-review <ID>` — Dual-Model Consensus Review
- **Host Syntax**: `agy run devweave-pr-review PROJ-123`
- **When to Use**: Mandatory before creating a pull request.
- **What it Does**: Concurrently executes 5 review lenses:
  1. **Principal Architect Lens**: Design coherence, SOLID principles, anti-patterns.
  2. **Senior DBA Lens**: SQL indexing, transaction boundaries, lock escalation, migration safety.
  3. **Security Lens**: OWASP vulnerabilities, input sanitization, secret leakage.
  4. **Downstream Impact Lens**: API contracts, breaking changes to dependent services.
  5. **Cascading Resilience Lens**: Circuit breakers, timeouts, error propagation.
- **Output Artifacts**: `.devweave/tasks/<ID>/review.md`. Requires Human sign-off.

#### 8. `devweave-pr <ID>` — PR Packaging & Durable Knowledge Promotion
- **Host Syntax**: `agy run devweave-pr PROJ-123`
- **When to Use**: Final step to assemble the pull request and update domain knowledge.
- **What it Does**: Compiles clean PR description with full traceability (Ticket &rarr; Plan &rarr; Tests &rarr; Review). Promotes reusable conventions to `.devweave/knowledge/conventions.md`.
- **Output Artifacts**: Pull request created on GitHub/GitLab/Azure DevOps.

---

### V1.1 Modernization Lifecycle (10 Commands)

```text
M-INIT ──► M-CONTEXT ──► M-ANALYZE [GATE #1] ──► M-PLAN [GATE #2] ──► M-BRANCH ──► M-IMPLEMENT ──► M-VERIFY [GATE #3] ──► M-PR
```

#### 9. `devweave-modernization-init` — Target Profile & Architecture Intent Initialization
- **Host Syntax**: `agy run devweave-modernization-init` | `devweave-modernization-init --source <path>`
- **What it Does**: Accepts natural language architectural intent, interactively prompts for the legacy source repository / knowledge base path (if `--source` is not passed), scans target repository without questionnaires, detects target profile and technology practices (CQRS, signals, indexing), locks legacy source as `READ_ONLY`, and initializes modernization workspace `.devweave/modernization/<ID>/`.
- **Output Artifacts**: `architecture-intent.json`, `technology-profile.json`, `source-memory.json`, `state.json`.

#### 10. `devweave-modernization-context <ID>` — Work Item Intake & Legacy Slice Extraction
- **Host Syntax**: `agy run devweave-modernization-context <ID>`
- **What it Does**: Ingests migration scope via PM tool selector (Jira, Azure DevOps, GitHub, Linear, or Manual User Story paste), runs PII privacy check, extracts bounded legacy source slice from read-only source memory, and retrieves relevant graph neighborhood.
- **Output Artifacts**: `context.md`, `migration-unit.json`.

#### 11. `devweave-modernization-analyze <ID>` — Behavioral Mapping & [HARD GATE #1]
- **Host Syntax**: `agy run devweave-modernization-analyze <ID>`
- **What it Does**: Analyzes legacy behaviors, business rules, API schemas, and data structures against target architecture. Generates `mappings.json` and enforces **Hard Gate #1** (explicit human approval required before planning).
- **Output Artifacts**: `analysis.md`, `mappings.json`.

#### 12. `devweave-modernization-plan <ID>` — Implementation Blueprint & [HARD GATE #2]
- **Host Syntax**: `agy run devweave-modernization-plan <ID>`
- **What it Does**: Decomposes mappings into file-anchored implementation tasks, unit/integration/E2E test specifications, and database migration scripts. Enforces **Hard Gate #2** (explicit human approval required before branch/implementation).
- **Output Artifacts**: `plan.md`, `test-plan.json`.

#### 13. `devweave-modernization-branch <ID>` — Modernization Sandbox Branching
- **Host Syntax**: `agy run devweave-modernization-branch <ID>`
- **What it Does**: Creates isolated branch `devweave/modernization/<ID>`. Enforces strict **READ_ONLY** invariance on legacy source repositories.
- **Output Artifacts**: Git branch created, `state.json` updated.

#### 14. `devweave-modernization-implement <ID>` — Modernization Implementation & Test Suite
- **Host Syntax**: `agy run devweave-modernization-implement <ID>`
- **What it Does**: Executes surgical, plan-bound modernization code changes, runs automated test runners, adheres to target technology practices, and prevents scope drift.
- **Output Artifacts**: Target code modifications, `evidence.md`, `test-results.json`.

#### 15. `devweave-modernization-verify <ID>` — Dual Verification & [HARD GATE #3]
- **Host Syntax**: `agy run devweave-modernization-verify <ID>`
- **What it Does**: Executes dual-layer verification (functional test suite + architectural/behavioral parity scorecard). Validates DB migrations and security, enforcing **Hard Gate #3** (explicit human approval required before PR).
- **Output Artifacts**: `verification.md`, `scorecard.json`.

#### 16. `devweave-modernization-pr <ID>` — Modernization PR & Graph Promotion
- **Host Syntax**: `agy run devweave-modernization-pr <ID>`
- **What it Does**: Assembles comprehensive modernization PR package, promotes `MIGRATED_TO` edges to knowledge graph, and outputs `pr-description.md` and `report.md`.
- **Output Artifacts**: PR opened, `pr-description.md`, `report.md`.

#### 17. `devweave-modernization-status <ID>` — Durable Modernization Inspector
- **Host Syntax**: `agy run devweave-modernization-status <ID>`
- **What it Does**: Inspects and reports durable phase status, completed checkpoints, active gate requirements, and next suggested command.

#### 18. `devweave-modernization-report <ID>` — Modernization Lifecycle Report
- **Host Syntax**: `agy run devweave-modernization-report <ID>`
- **What it Does**: Synthesizes end-to-end modernization lifecycle audit report capturing architecture decisions, migration mappings, and verification scorecards.

---

### Specialized Fast Lanes & Utilities (13 Commands)

#### 19. `devweave-fix-triage <ID>` — Crash Log & Severity Triage
- **Host Syntax**: `agy run devweave-fix-triage <ID>`

#### 20. `devweave-fix-diagnose <ID>` — Root-Cause Hypothesis & Repro Design
- **Host Syntax**: `agy run devweave-fix-diagnose <ID>`

#### 21. `devweave-fix-land <ID>` — Minimal Fix Patch & Retest [HARD GATE]
- **Host Syntax**: `agy run devweave-fix-land <ID>`

#### 22. `devweave-modernize <ID>` — V1.0 Single-Dependency Modernization
- **Host Syntax**: `agy run devweave-modernize <ID>`

#### 23. `devweave-express <ID>` — Low-Risk 1-Step Fast Track
- **Host Syntax**: `agy run devweave-express <ID>`

#### 24. `devweave-update` — In-Place Multi-Host Updater & 24h Sync
- **Host Syntax**: `agy run devweave-update`

#### 25. `devweave-status` — Work-Item State Inspector
- **Host Syntax**: `agy run devweave-status`

#### 26. `devweave-handoff` — Developer Transition & Context Handoff
- **Host Syntax**: `agy run devweave-handoff`

#### 27. `devweave-archive` — Post-Merge Workspace Archiver
- **Host Syntax**: `agy run devweave-archive`

#### 28. `devweave-report` — Executive Metrics & Savings Reporter
- **Host Syntax**: `agy run devweave-report`

#### 29. `devweave-improve` — Agent Self-Correction & Friction Recorder
- **Host Syntax**: `agy run devweave-improve`

#### 30. `devweave-document-product` — Product Architecture Catalog
- **Host Syntax**: `agy run devweave-document-product`

#### 31. `devweave-document-domain` — Domain Knowledge & Rules Catalog
- **Host Syntax**: `agy run devweave-document-domain`

---

## 5. Step-by-Step Tutorial: Your First 5 Minutes

Here is the exact flow for tackling your first issue with DevWeave:

### Step 1: Initialize Your Codebase
Open your AI assistant in your project root and run:
```bash
agy run devweave-init
```
*(DevWeave detects your languages, frameworks, ORMs, test runners, physical layers, and request flow, saving them to `.devweave/repository/`)*.

### Step 2: Ingest a Work Item
```bash
agy run devweave-context AUTH-101
```
*(DevWeave loads the ticket requirements, checks for secrets, and identifies affected files)*.

### Step 3: Generate the Plan
```bash
agy run devweave-plan AUTH-101
```
*(DevWeave creates an atomic, step-by-step task breakdown in `.devweave/tasks/AUTH-101/plan.md`)*.

### Step 4: Create a Branch & Implement
```bash
agy run devweave-branch AUTH-101
agy run devweave-implement AUTH-101
```
*(DevWeave creates the feature branch, modifies only the plan-specified files, and runs your test suite to capture proof)*.

### Step 5: Dual-Model Review & PR
```bash
agy run devweave-pr-review AUTH-101
agy run devweave-pr AUTH-101
```
*(DevWeave performs dual Architect + DBA review, prompts you for final approval, and creates the pull request)*.

---

## 6. Troubleshooting & Offline Mode

- **Air-Gapped / Offline Environments**: DevWeave update checks timeout gracefully after 2 seconds without hanging. Existing cached skills continue to work seamlessly.
- **Private Git Mirrors**: To point auto-updates to an internal enterprise GitLab or GitHub Enterprise server, edit `~/.devweave/update-cache.json` and set `"source_repo": "https://git.internal.corp/devweave.git"`.
- **Force Re-Indexing**: To force a fresh scan of your repository structure after major rewrites, run `agy run devweave-init --refresh`.
