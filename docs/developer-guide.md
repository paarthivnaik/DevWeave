# DevWeave Developer Handbook & Universal Guide

> **"Less Tokens. More Work. Lower Bill."**

Welcome to the **DevWeave Universal Developer Guide**. This comprehensive handbook explains how to install, use, and update DevWeave across any AI coding host, along with an in-depth reference for all 21 commands and skills.

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

DevWeave provides **21 specialized skills** organized into the Canonical Lifecycle, Fast Lanes, and Utility commands.

### Phase 0 to 7: Canonical Feature Lifecycle

```text
INIT ──► CONTEXT ──► ANALYZE ──► PLAN ──► BRANCH [GATE] ──► IMPLEMENT ──► REVIEW [GATE] ──► PR [GATE]
```

#### 1. `devweave-init` — Autonomous 5-Layer Stack Discovery
- **Host Syntax**: `agy run devweave-init` | `/devweave-init` | `@devweave /init` | `gemini devweave-init` | `$devweave init` | `devweave:init`
- **When to Use**: Once when opening a new repository or after major framework migrations.
- **What it Does**: Scans manifests across 5 progressive layers (Topology, Languages, Frameworks, Tooling, Versions). Synthesizes pin-to-pin architecture, physical-to-logical layer mapping, request flow traces, and multi-repo service links.
- **Zero Modification Guarantee**: Never alters application code.
- **Output Artifacts**: `.devweave/repository/profile.md`, `layers.md`, `request-flow.md`, `technologies.md`, `frameworks.md`, `dependencies.md`, `build.md`, `testing.md`, `practices.md`.

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
- **What it Does**: Decomposes the task into atomic, sequentially numbered tasks with exact file targets, line anchors, and deterministic test commands.
- **Output Artifacts**: `.devweave/tasks/<ID>/plan.md`.

#### 5. `devweave-branch <ID>` — Git Branch Isolation & Branch Gate
- **Host Syntax**: `agy run devweave-branch PROJ-123`
- **When to Use**: Before writing code to guarantee branch safety.
- **What it Does**: Validates branch naming conventions (`feature/PROJ-123-short-desc`), verifies base commit alignment, and strictly blocks implementation directly on `main` or `master`.
- **Output Artifacts**: Isolated Git working branch created.

#### 6. `devweave-implement <ID>` — Plan-Bound Surgical Coding
- **Host Syntax**: `agy run devweave-implement PROJ-123`
- **When to Use**: To execute the approved plan.
- **What it Does**: Performs targeted, localized edits strictly on the files authorized in `plan.md`. Runs automated unit tests and linter commands after each step and records execution evidence.
- **Output Artifacts**: Code modifications and test evidence in `.devweave/tasks/<ID>/evidence.md`.

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

### Specialized Fast Lanes

#### 9. Fix Lane (`devweave-fix-triage`, `devweave-fix-diagnose`, `devweave-fix-land`)
- **Purpose**: Accelerated defect remediation workflow for high-severity bugs.
- **Commands**:
  - `devweave-fix-triage <ID>`: Ingests stack traces, assigns severity (`CRITICAL`, `MAJOR`, `MINOR`), identifies affected subsystems.
  - `devweave-fix-diagnose <ID>`: Hypothesizes root cause, designs minimal regression test case.
  - `devweave-fix-land <ID>`: Applies surgical minimal patch, runs regression test, and prepares hotfix PR.

#### 10. Modernization Lane (`devweave-modernize <ID>`)
- **Purpose**: Dependency upgrades, framework migrations (e.g. .NET 8 &rarr; 9, Java 17 &rarr; 21, React Class &rarr; Hooks).
- **Output Artifacts**: `.devweave/tasks/<ID>/migration_manifest.md`.

#### 11. Express Lane (`devweave-express <ID>`)
- **Purpose**: Single-turn fast track for low-risk changes (typos, documentation, minor config tweaks). Combines Context, Plan, Patch, and Test into a single step.

#### 12. Lifecycle Management (`devweave-update`)
- **Purpose**: In-place synchronization of skills and rules across all hosts with zero token waste.

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
