# DevWeave Release Notes — Version 1.4.0

**Release Date**: September 27, 2026  
**Status**: General Availability (GA)  
**Conformance Verification**: 100% (15 Suites Passed)

---

## 1. Major Capabilities Introduced

### Superpower 24: Domain Knowledge Intelligence Layer
- **Semantic Business Layer**: Introduces `.devweave/domain/knowledge.json` capturing concepts, business rules, processes, capabilities, terminology, domain events, constraints, and mappings to repository entities.
- **Strict Context vs. Analyze Boundary**: `devweave-context` acquires work-item tickets, attachments, OCR, and candidate claims only without repository traversal. `devweave-analyze` is the primary join point for Domain Knowledge, Knowledge Graph, Engineering Intelligence, and source verification.
- **Story-Level Domain Deltas**: Stories emit additive changes to `.devweave/work-items/<ID>/domain-delta.json`, merging deterministically at PR time with `KNOWLEDGE_CONFLICT` detection for contradictory statements.
- **Staleness & Invalidation**: Source file changes trigger targeted `NEEDS_REVALIDATION` on dependent domain facts.
- **Modernization Domain Invariance**: Legacy domain knowledge remains strictly read-only.

### Deep Analyzer & Complete Knowledge Graph Subsystem
- **Technology-Aware Structural Extraction**: Pluggable static analyzers (Roslyn for .NET, TypeScript Compiler API, Python AST, JavaParser, Go AST).
- **Critical Token Invariant**: Complete structural graph is persisted on disk (`.devweave/graph/knowledge-graph.json`) but is **NEVER loaded in its entirety into AI context**. Bounded graph traversal builds compact, relevant subgraphs (<32k tokens).
- **Capability Management**: Interactive human approval gate before analyzer installation with checkpoint and resume support.

### Conformance Test Suite 15 (`validate_domain_knowledge.ps1`)
- 24 comprehensive assertions validating schemas, boundaries, token budgets, merge conflicts, staleness propagation, and modernization invariants.

---

## 2. Updated Architecture & Specifications
- [`spec/schemas/domain-knowledge.schema.json`](file:///D:/DevWeave/spec/schemas/domain-knowledge.schema.json)
- [`spec/schemas/domain-delta.schema.json`](file:///D:/DevWeave/spec/schemas/domain-delta.schema.json)
- [`spec/schemas/analyzer-capability.schema.json`](file:///D:/DevWeave/spec/schemas/analyzer-capability.schema.json)
- [`spec/specification/domain-knowledge.md`](file:///D:/DevWeave/spec/specification/domain-knowledge.md)
- [`spec/specification/deep-analyzer.md`](file:///D:/DevWeave/spec/specification/deep-analyzer.md)
- Multi-host parity across all 6 AI assistant platforms (Antigravity, Claude, Codex, Copilot, Devin, Gemini).
