# DevWeave Canonical Terminology

This document establishes the official glossary and taxonomy for DevWeave across all specifications, schemas, agents, skills, and host adapters.

---

### 1. DevWeave
The generic, declarative AI-Driven Development Lifecycle (AI-DLC) specification, knowledge architecture, and orchestration framework for AI coding assistants and autonomous engineering agents.

### 2. AI-DLC (AI-Driven Development Lifecycle)
A structured, multi-phase lifecycle designed for human-AI collaborative software engineering, consisting of Discovery, Requirements, Solution, Approval, Planning, Implementation, Testing, Verification, Review, and PR readiness.

### 3. Work Item
A discrete unit of software engineering work (e.g., bug fix, feature, refactoring, security remediation, modernization) managed through the AI-DLC state machine and tracked with structured artifacts.

### 4. Skill
A modular, declarative capability package containing instructions, prompts, schemas, scripts, references, and validation rules that enables an agent or host to perform specific engineering tasks.

### 5. Agent
An autonomous or semi-autonomous AI role archetype with defined responsibilities, capability requirements, permitted tools, input/output contracts, and persona behaviors (e.g., Architect, Planner, Implementer, Tester, Verifier, Reviewer).

### 6. Host Adapter
The integration bridge mapping DevWeave's declarative specification into a specific AI coding environment or host platform (e.g., Google Antigravity, Claude Code, OpenAI Codex, GitHub Copilot).

### 7. Workflow Profile
A deterministic execution route through the AI-DLC state machine tailored to the risk, scope, and nature of the work item (e.g., `EXPRESS`, `BUG`, `FEATURE`, `REFACTOR`, `MODERNIZATION`, `SECURITY`, `DATABASE`, `HIGH_RISK`).

### 8. Effort
A calibrated measure of task complexity and computational investment, used to guide context window sizing, model selection, reasoning depth, and subagent parallelization (e.g., `TRIVIAL`, `LOW`, `MEDIUM`, `HIGH`, `MAXIMUM`).

### 9. Capability
An abstract tier of model intelligence and reasoning capacity required for a task (e.g., `flash_lite`, `flash`, `pro`, `reasoning`), decoupling the AI-DLC from specific proprietary model names.

### 10. Knowledge
The durable, structured, Git-friendly repository intelligence artifacts (`.devweave/knowledge/`) capturing architectural patterns, tech stack dependencies, build/test commands, conventions, schemas, and historical lessons.

### 11. Context
The minimal, high-signal prompt payload assembled dynamically from repository knowledge, work item artifacts, and active state to execute a specific step without redundant discovery or context bloat.

### 12. Artifact
A structured, versioned file produced at a specific AI-DLC state (e.g., `discovery.md`, `requirements.md`, `solution.md`, `plan.md`, `verification.md`, `review.md`) providing auditable progress and gating criteria.

### 13. Verification
The deterministic execution and validation of automated checks, linters, static analysis, build commands, and test suites to confirm code correctness and system stability.

### 14. Review
The multi-perspective qualitative evaluation of code changes against engineering standards, security policies, performance requirements, architectural patterns, and maintainability rules.

### 15. Approval
An explicit gate (human-in-the-loop or policy-automated) where specifications, solutions, plans, or critical code modifications are formally sanctioned before proceeding to the next lifecycle state.

### 16. MCP (Model Context Protocol)
An open protocol enabling AI models to interact with local repository tools, database inspectors, AST engines, and external enterprise services in a standardized format.
