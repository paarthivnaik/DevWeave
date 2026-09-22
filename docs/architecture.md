# DevWeave System Architecture

DevWeave decouples the AI-DLC methodology from specific programming languages, runtimes, and proprietary AI coding hosts.

```text
                         DEVWEAVE
                            │
                    AI-DLC Specification
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
      Skills              Agents             Policies
        │                   │                   │
        └───────────────────┼───────────────────┘
                            │
                    Workflow Profiles
                            │
                      State Machine
                            │
                      Orchestration
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
   Repository           Knowledge           Artifacts
   Intelligence          System             + Schemas
        │                   │                   │
        └───────────────────┼───────────────────┘
                            │
                      Host Contract
                            │
                  Host-specific Adapter
                            │
                     AI Coding Host
                            │
                  Models / Tools / MCP
                            │
                        Repository
```

## Key Invariants
- **Declarative First**: Specification is authored entirely in Markdown, YAML, and JSON Schema.
- **Zero Mandatory Runtime**: Runs natively inside host agent turns without daemon dependencies.
- **Git-Friendly Storage**: Intelligence and artifacts persist in Git repositories.
