# DevWeave — AI-DLC Framework

> **Less Tokens. More Work. Lower Bill.**

DevWeave is a generic, declarative, host-neutral AI-Driven Development Lifecycle (AI-DLC) specification, knowledge architecture, and orchestration framework for AI coding assistants and autonomous engineering agents.

---

## Repository Structure (Monorepo)

```text
DevWeave/
├── spec/                              # Canonical AI-DLC Specification & Schemas
│   ├── specification/                 # Vision, principles, lifecycle, state machine, etc.
│   ├── schemas/                       # Machine-readable JSON Schemas
│   ├── skills/                        # Canonical, host-neutral skill definitions
│   ├── agents/                        # Canonical agent role definitions
│   ├── policies/                      # Security & approval policies
│   ├── templates/                     # Standard artifact templates
│   └── examples/                      # Valid & invalid schema test fixtures
│
├── adapters/                          # Host-specific adapters
│   └── antigravity/                   # Reference host adapter for Google Antigravity
│       ├── manifest/                  # Host capability mappings & manifests
│       ├── skills/                    # Antigravity-native skill implementations
│       ├── agents/                    # Antigravity agent YAML configurations
│       ├── rules/                     # Antigravity lifecycle & safety rules
│       ├── workflows/                 # Profile execution graphs
│       └── configuration/             # Host environment configs
│
├── conformance/                       # Test scenarios & verification suites
│   ├── scenarios/                     # 18 end-to-end conformance test scenarios
│   ├── fixtures/                      # Test input fixtures
│   └── schemas/                       # Local schema verification mirror
│
├── docs/                              # Comprehensive documentation & guides
│   ├── getting-started.md             # Onboarding & quick start
│   ├── architecture.md                # System topology & decoupled layers
│   ├── antigravity.md                 # Antigravity reference adapter guide
│   ├── lifecycle.md                   # 12-state AI-DLC lifecycle guide
│   ├── workflow-profiles.md           # Calibrated workflow routing
│   └── conformance.md                 # Compliance testing checklist
│
├── LICENSE                            # Apache License 2.0
├── VERSION                            # 1.0.0
└── CHANGELOG.md                       # Release notes & version history
```

---

## Core Principles

1. **Generic & Universal**: Neutral across all programming languages (.NET, Java, Python, TypeScript, Go, Rust, etc.), databases, clouds, AI providers, and coding hosts.
2. **Declarative First**: 100% authored in Markdown, YAML, JSON, and JSON Schema. No mandatory runtime or programming language dependency.
3. **No Mandatory Runtime**: Runs natively inside host agent turns without requiring background daemons or dedicated servers.
4. **Token Efficient**: Maximize engineering output per token through targeted discovery, persistent knowledge reuse (`.devweave/knowledge/`), and focused context assembly.
5. **Deterministic Verification**: Code changes must pass native tests, compilers, linters, and type checkers before entering multi-perspective review.

---

## Quick Install (Antigravity CLI)

In your target project directory:
```bash
# Option 1: Install from GitHub
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git temp-devweave
agy plugin install .\temp-devweave\plugins\devweave
rm -rf temp-devweave

# Option 2: Local Install (if DevWeave is already cloned)
agy plugin install path/to/DevWeave/plugins/devweave
```

Verify installation:
```bash
agy plugin list
```

---

## Getting Started

- **Installation Guide**: Refer to [`docs/installation-guide.md`](docs/installation-guide.md) for 5 step-by-step installation methods (CLI, Git, Global, Team, Submodule).
- **User & Workflow Guide**: Refer to [`docs/getting-started.md`](docs/getting-started.md) for detailed onboarding, the 9-phase AI-DLC lifecycle, and command reference.

---

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for details.
