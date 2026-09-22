# DevWeave — AI-DLC Framework

> **Less Tokens. More Work. Lower Bill.**

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Conformance](https://img.shields.io/badge/Conformance-100%25_Verified-success)](conformance/)
[![Platform Symmetry](https://img.shields.io/badge/Hosts-6_Platforms_Certified-6366f1)](#-multi-host-plugins--adapters)

**DevWeave** is a **generic, declarative, host-neutral AI-Driven Development Lifecycle (AI-DLC)** specification, durable knowledge architecture, and workflow orchestration framework for AI coding assistants and autonomous engineering agents.

🌐 **Interactive Showcase & Client Portal**: Open [`site/index.html`](file:///D:/DevWeave/site/index.html) or deploy via **Cloudflare Pages / Vercel** (100% Free for Private Repos).

---

## 🚀 Key Highlights & Architectural Strengths

```mermaid
flowchart TD
    subgraph HIGHLIGHTS["DevWeave Core Highlights"]
        H1["<b>💰 Token & Cost Efficiency</b><br>84%–93% token savings, 95%–99% lower API bills via durable knowledge caching"]
        H2["<b>🌐 100% Universal & Tech-Neutral</b><br>Autonomous 5-layer detection across 12 polyglot ecosystems with zero hardcoding"]
        H3["<b>🧠 Stage-Based Model Routing</b><br>Fast scanning on lightweight models (flash_lite), deep reasoning on flagship models (pro)"]
        H4["<b>🔄 Dynamic Technology Revalidation</b><br>Auto-detects framework upgrades (e.g. .NET 8 → 9) and hot-swaps active best practices"]
        H5["<b>🛡️ Human-in-the-Loop Governance</b><br>Phase isolation, zero auto-chaining, zero self-approval, and 4 mandatory hard gates"]
        H6["<b>👥 Dual-Model Review (Architect + DBA)</b><br>Dedicated pre-PR review command (devweave-pr-review) evaluating impact, side effects & SQL"]
        H7["<b>📦 Zero Mandatory Daemons</b><br>100% declarative Git-native state (.devweave/), no background server or daemon needed"]
        H8["<b>🧩 Marketplace-Ready Plugin</b><br>20 validated Antigravity skills with explicit [Phase X] tagging and AI-DLC rules"]
    end
```

| Highlight | Description | Realized Benefit |
|---|---|---|
| **Token & Cost Efficiency** | Caches discovered codebase patterns into `.devweave/domains/` and `.devweave/products/` and scopes execution to precise blast radiuses. | **84.1%–93.4% Token Savings** ($0.0018–$0.0039 vs $0.50–$1.16 on repeat tasks). |
| **Stage-Based Model Routing** | Routes abstract capabilities (`fast-analysis`, `deep-reasoning`, `coding`, `independent-review`) to calibrated model tiers (`flash_lite`, `flash`, `pro`). | Eliminates paying flagship model prices for routine file scanning and git checks. |
| **5-Layer Autonomous Tech Detection** | Progressively parses lockfiles and manifests across Language, Framework, Persistence, Testing, and Build layers. | Works out-of-the-box on **C#, Python, TypeScript, Java, Go, Rust, PHP, Ruby, C++**, monorepos, and legacy codebases. |
| **Dual-Model Code & SQL Review** | Separate `devweave-pr-review` command executing concurrently as **Principal Software Architect** (code/impact) and **Senior DBA** (SQL/locks/indexes). | Uncovers architectural design flaws, table locks, and cascading failure risks before PR creation. |
| **Dynamic Revalidation Engine** | Flags affected domain practices as `NEEDS_REVALIDATION` when dependency or runtime version bumps occur. | Permanent skills remain stable while version-specific idioms and conventions update dynamically. |
| **HITL Phase Isolation** | Enforces that each command executes **only its single phase**, writes its artifact, and halts with a human decision prompt. | Eliminates runaway autonomous loops, hallucinations, and unreviewed code modifications. |
| **Mandatory Hard Gates** | 1. **PII/Privacy Gate** (sanitizes secrets), 2. **Branch Gate** (blocks edits on main), 3. **Review Gate** (human sign-off on review), 4. **PR Gate**. | Strict enterprise safety and zero secret storage in Git history. |
| **Declarative & Git-Native** | Stores all lifecycle state, audit logs, and metrics as Markdown, YAML frontmatter, and JSON in `.devweave/`. | 100% transparent, auditable, and reproducible with zero background server dependencies. |

---

## 📐 Canonical 7-Phase User Workflow

```mermaid
flowchart LR
    P0["<b>Phase 0: Init</b><br><code>devweave-init</code>"] --> P1["<b>Phase 1: Context</b><br><code>devweave-context &lt;ID&gt;</code>"]
    P1 --> P2["<b>Phase 2: Analyze</b><br><code>devweave-analyze &lt;ID&gt;</code>"]
    P2 --> P3["<b>Phase 3: Plan</b><br><code>devweave-plan &lt;ID&gt;</code>"]
    P3 --> P4["<b>Phase 4: Branch</b><br><code>devweave-branch &lt;ID&gt;</code><br><b>[HARD GATE]</b>"]
    P4 --> P5["<b>Phase 5: Implement</b><br><code>devweave-implement &lt;ID&gt;</code>"]
    P5 --> P6["<b>Phase 6: Review</b><br><code>devweave-pr-review &lt;ID&gt;</code><br><b>[HARD GATE]</b>"]
    P6 --> P7["<b>Phase 7: PR</b><br><code>devweave-pr &lt;ID&gt;</code><br><b>[HARD GATE]</b>"]
```

---

## ⚡ Specialized Fast Lanes

### 1. Fix Lane (Bug Triage & Accelerated Remediation)
```text
devweave-fix-triage <ID>  ──►  devweave-fix-diagnose <ID>  ──►  devweave-fix-land <ID> [HARD GATE]
 (Defect Classification)       (Root-Cause Investigation)        (Patch, Test, Verify & PR)
```

### 2. Modernization Lane (Legacy Migration & Upgrades)
```text
devweave-context <ID>  ──►  devweave-analyze <ID>  ──►  devweave-modernize <ID>  ──►  devweave-branch  ──►  devweave-implement  ──►  devweave-pr-review  ──►  devweave-pr
                                                    (migration_manifest.md)
```

### 3. Express Mode (Low-Risk Fast Track)
```text
devweave-express <ID> ──► Unified Context + Plan + Patch + Test + PR (Bypasses ceremony for typos & docs)
```

---

## 📦 Repository Structure (Monorepo)

```text
DevWeave/
├── plugins/antigravity/               # Google Antigravity Native Plugin Package
│   ├── plugin.json                    # Plugin manifest ($schema, version 1.0.0)
│   ├── rules/AGENTS.md                # AI-DLC core rules & phase boundary constraints
│   └── skills/                        # 20 validated workflow skills (with [Phase X] tags)
│       ├── devweave-init/             # [Phase 0: Init] Autonomous 5-layer repo setup
│       ├── devweave-context/          # [Phase 1: Context] Intake, PII gate, blast radius
│       ├── devweave-analyze/          # [Phase 2: Analyze] Deep archaeology & root-cause
│       ├── devweave-plan/             # [Phase 3: Plan] Atomic task breakdown & test anchors
│       ├── devweave-branch/           # [Phase 4: Branch] Isolated Git branch hard gate
│       ├── devweave-implement/        # [Phase 5: Implement] Surgical, plan-bound coding
│       ├── devweave-pr-review/        # [Phase 6: Review] Dual-model review (Architect + DBA)
│       ├── devweave-pr/               # [Phase 7: PR] Final PR package & human approval gate
│       ├── devweave-fix-triage/       # [Fix Lane - Phase 1] Error logs & severity triage
│       ├── devweave-fix-diagnose/     # [Fix Lane - Phase 2] Hypotheses & minimal fix plan
│       ├── devweave-fix-land/         # [Fix Lane - Phase 3] Patch, regression test, PR
│       ├── devweave-modernize/        # [Modernization Lane] migration_manifest.md
│       ├── devweave-express/          # [Express Lane] Single-pass fast track for low risk
│       ├── devweave-status/           # [Utility] Lifecycle state inspector
│       ├── devweave-handoff/          # [Utility] Team handoff package generator
│       ├── devweave-archive/          # [Utility] Post-merge workspace archiver
│       ├── devweave-report/           # [Utility] Executive process & metrics report
│       ├── devweave-improve/          # [Utility] Friction logs & skill improver
│       ├── devweave-document-product/ # [Knowledge] Product architecture catalog
│       └── devweave-document-domain/  # [Knowledge] Domain knowledge & scorecards
│
├── spec/                              # Formal Specification, Schemas & Policies
│   ├── specification/                 # Normative lifecycle, HITL, detection, reval specs
│   └── schemas/                       # Canonical JSON Schemas for all artifacts
│
├── conformance/                       # Master Verification & Test Runner Suites
│   ├── tests/                         # Automated test runners (run_all_tests.ps1)
│   ├── scenarios/                     # 20 end-to-end integration test scenarios
│   └── fixtures/                      # 12 polyglot repo fixtures (.NET, Python, Go, etc.)
│
└── docs/                              # Multi-Tier Documentation
    ├── getting-started.md             # End-to-end workflow walkthrough with Mermaid diagrams
    ├── v1-benchmarks.md               # Empirical benchmarks across 12 repos & token/cost stats
    ├── installation-guide.md          # 5 installation methods (Junior to Senior/DevOps)
    ├── lifecycle.md                   # Normative AI-DLC lifecycle and execution contracts
    ├── workflow-profiles.md           # 8 risk-calibrated profiles and execution lanes
    ├── architecture.md                # 5-layer detection, dynamic reval, and host adapters
    ├── antigravity.md                 # Antigravity CLI and plugin guide
    └── conformance.md                 # 20-scenario conformance verification guide
```

---

## ⚡ Quick Start & Installation Across All Adapters

DevWeave provides native plugins and host adapters for all 6 major AI coding environments:

### 1. 🔵 Google Antigravity
```powershell
# Direct install from local repository:
agy plugin install D:\DevWeave\plugins\antigravity

# Or one-liner install from GitHub:
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git temp-devweave; agy plugin install .\temp-devweave\plugins\antigravity; Remove-Item -Recurse -Force temp-devweave

# Verify:
agy plugin list   # Output: devweave (plugins/antigravity) - Status: active, Skills: 20 available
```

### 2. 🟠 Anthropic Claude Code
```bash
# Register native Claude Code plugin:
claude plugin add path/to/DevWeave/plugins/claude

# Or copy repository rules & slash commands:
mkdir -p .claude/commands && cp path/to/DevWeave/plugins/claude/CLAUDE.md ./CLAUDE.md && cp path/to/DevWeave/plugins/claude/commands/* .claude/commands/

# Verify:
claude /devweave-init
```

### 3. 🟣 GitHub Copilot (VS Code, Visual Studio, CLI)
```bash
# Option A: GitHub CLI Extension
gh extension install path/to/DevWeave/plugins/copilot

# Option B: Team Repository Setup (.github/prompts)
mkdir -p .github/prompts && cp path/to/DevWeave/plugins/copilot/copilot-instructions.md .github/copilot-instructions.md && cp path/to/DevWeave/plugins/copilot/prompts/* .github/prompts/

# Verify in Copilot Chat:
@devweave /init
```

### 4. 🔴 Google Gemini CLI
```bash
# Register Gemini CLI plugin:
gemini plugin add path/to/DevWeave/plugins/gemini

# Or copy configuration:
mkdir -p .gemini/commands && cp path/to/DevWeave/plugins/gemini/GEMINI.md .gemini/GEMINI.md && cp path/to/DevWeave/plugins/gemini/commands/* .gemini/commands/

# Verify:
gemini devweave-init
```

### 5. 🟢 OpenAI Codex & ChatGPT CLI
```bash
# Register Codex plugin:
codex plugin install path/to/DevWeave/plugins/codex

# Or copy commands:
mkdir -p .codex/commands && cp path/to/DevWeave/plugins/codex/CODEX.md .codex/CODEX.md && cp path/to/DevWeave/plugins/codex/commands/* .codex/commands/

# Verify:
codex run devweave-init
```

### 6. ⚪ Cognition Devin
```bash
# Load Devin Playbook in your workspace:
devin playbook load path/to/DevWeave/plugins/devin

# Verify:
Run /devweave-init in the Devin console
```

For complete step-by-step setup, see [Master Installation Guide](file:///D:/DevWeave/docs/installation-guide.md).

---

## 🧪 Master Conformance Verification

```powershell
.\conformance\tests\run_all_tests.ps1
```

```text
=================================================================
  [PASSED] JSON Schema Validation Suite                  (2.44s)
  [PASSED] AI-DLC State Machine Transition Suite         (0.90s)
  [PASSED] 18 Conformance Scenarios Suite (20 Scenarios) (1.53s)
  [PASSED] 12-Ecosystem Technology Neutrality Suite      (1.07s)
  [PASSED] Multi-Repository .devweave Initialization Suite (2.64s)
  [PASSED] Token & Cost Efficiency Benchmark Suite       (0.96s)
-----------------------------------------------------------------
RELEASE CANDIDATE STATUS: 100% CONFORMANCE VERIFIED (ALL SUITES PASSED)
=================================================================
```

---

## 📄 License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for details.
