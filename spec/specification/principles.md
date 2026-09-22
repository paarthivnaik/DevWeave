# DevWeave Non-Negotiable V1.0 Principles

The following principles are mandatory across all DevWeave specifications, schemas, agents, skills, and host adapters.

---

## 1. Generic & Universal

DevWeave is fundamentally:
- **Language-neutral**: Agnostic to programming languages.
- **Framework-neutral**: Agnostic to web, UI, backend, or mobile frameworks.
- **Database-neutral**: Agnostic to relational, document, graph, or KV datastores.
- **Cloud-neutral**: Agnostic to cloud providers, container orchestration, or on-prem environments.
- **Repository-neutral**: Works across monoliths, microservices, monorepos, multi-repos, and polyglot systems (.NET, Java, Python, TypeScript, JavaScript, Go, Rust, PHP, Ruby, C/C++, legacy systems).
- **AI-host-neutral**: Agnostic to specific AI IDEs, CLI tools, or orchestrators.
- **AI-provider-neutral**: Agnostic to AI model providers.
- **Model-neutral**: Works with any capability-matched LLM.

> Repository technologies (.NET, Python, Go, Node, etc.) are technologies that DevWeave *discovers and manages*. They are **not dependencies of DevWeave itself**.

---

## 2. Declarative First

The canonical DevWeave specification must **not require** any programming language runtime (Node.js, Python, .NET, Java, Go, Rust, etc.) for its core operation.

The canonical implementation relies strictly on:
- **Markdown** (`.md`) for human/agent-readable specifications, artifacts, and documentation.
- **YAML** (`.yaml` / `.yml`) for agent configurations, workflow profiles, and skill manifests.
- **JSON** (`.json`) for structured metadata and state snapshots.
- **JSON Schema** (`.schema.json`) for schema definition and validation.
- **Host-native skills, agents, rules, and configuration**.

Programming languages are strictly confined to *optional external extensions* (e.g., specialized AST analyzers, custom MCP servers, external deterministic validators) and are never mandatory dependencies.

---

## 3. No Mandatory Runtime

DevWeave V1.0 must not require a permanently running background daemon, server, or custom application runtime. Orchestration happens inside host execution lifecycles and standard agent turns.

---

## 4. No Mandatory Database

Repository knowledge, work items, and metadata are stored in standard, Git-friendly files (`.devweave/` or standard repository directories). A dedicated database server is not required.

---

## 5. No Mandatory Vector Database

V1.0 begins with structured, deterministic Markdown/YAML/JSON knowledge graphs and hierarchical indices. Semantic or vector databases may be added as optional enhancements only when concrete evidence warrants them.

---

## 6. No Mandatory AI Provider

DevWeave utilizes **capability-based model selection** (e.g. `flash_lite`, `flash`, `pro`, `reasoning`) rather than hardcoding vendor-specific endpoints or proprietary APIs.

---

## 7. No Mandatory AI Host

Google Antigravity serves as the primary development environment and first reference host adapter. Future adapters (e.g. Claude Code, OpenAI Codex/Operator, GitHub Copilot, Gemini CLI) will implement the standard DevWeave Host Contract without modifying the core AI-DLC methodology.
