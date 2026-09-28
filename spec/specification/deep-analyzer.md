# DevWeave Deep Analyzer & Complete Knowledge Graph Specification

**Version**: 1.4.0  
**Status**: Canonical Product Specification  
**Subsystem**: Deep Structural Archaeology & Bounded Graph Context Subsystem

---

## 1. Executive Overview

The Deep Analyzer subsystem enables DevWeave to extract and maintain a **complete, high-fidelity structural Knowledge Graph** representing all code symbols, AST relationships, APIs, database entities, and test suites across the repository.

### Critical Invariant: Complete Graph ≠ Complete AI Context
```text
DEEP ANALYZER
    │
    ▼
COMPLETE STRUCTURAL KNOWLEDGE GRAPH (Stored on disk: .devweave/graph/knowledge-graph.json)
    │
    ▼
BOUNDED QUERY / TRAVERSAL ENGINE (Depth limits, node/edge limits, token budgets)
    │
    ▼
RELEVANT SUBGRAPH (<32k tokens)
    │
    ▼
TARGETED SOURCE VERIFICATION (view_file on specific lines)
    │
    ▼
COMPACT AI CONTEXT (Optimal Token & Cost Efficiency)
```

> **The complete graph is NEVER injected in its entirety into an AI prompt.**

---

## 2. Technology-Aware Analyzer Capability Matrix

Deep Analyzers are optional, technology-specific tools:
| Technology | Preferred Deep Analyzer | Extracted Detail |
| :--- | :--- | :--- |
| **.NET / C#** | Roslyn AST & Symbol APIs | Full type symbols, invocations, overrides, EF Core models |
| **TypeScript / JavaScript** | TypeScript Compiler API | Component hierarchies, service injections, Angular signals |
| **Python** | Python AST & Static Analysis | Class trees, async functions, Pydantic models, FastAPI routes |
| **Java** | JavaParser / JDT Core | Package trees, Spring beans, JPA entities, JUnit suites |
| **Go** | `go/ast` + `go/types` | Struct definitions, interfaces, receiver methods, Goroutines |

---

## 3. Human Approval Gate & Checkpoint/Resume

1. **Detection**: During `devweave-init`, `devweave-setup`, or `devweave-update`, DevWeave checks for applicable deep analyzers matching detected technologies.
2. **Missing Analyzer UX**: If a deep analyzer is missing, DevWeave explains its exact value, prerequisites, and asks for developer authorization (`[Approve] [Decline]`).
3. **Graceful Continuation**: If declined, DevWeave falls back gracefully to standard lexical/manifest analysis (`deepAnalyzerStatus: "DECLINED"`).
4. **Checkpoint/Resume**: If approved, setup saves an atomic checkpoint, installs/configures the tool, verifies its version, and resumes Knowledge Graph generation without restarting completed phases.

---

## 4. Incremental Updates via Graph Deltas

The entire Knowledge Graph is never rebuilt from scratch for every work item.
- Git diffs identify modified files and affected symbol boundaries.
- The incremental builder generates `.devweave/work-items/<ID>/graph-delta.json`.
- Merged into `.devweave/graph/knowledge-graph.json` during the PR lifecycle phase.
