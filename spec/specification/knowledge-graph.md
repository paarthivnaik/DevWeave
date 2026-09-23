# DevWeave JSON Knowledge Graph & Graph Delta Specification

> **"Less Tokens. More Work. Lower Bill."**

## 1. Executive Overview
The DevWeave Knowledge Graph (`.devweave/graph/knowledge-graph.json`) is a declarative, Git-native, zero-daemon architectural graph of the target codebase. It models software components as typed Nodes and architectural interactions as directed Edges.

---

## 2. Node & Edge Ontology

```text
┌────────────────────────────────────────────────────────────────────────┐
│                              NODE TYPES                                │
├────────────────────────────────────────────────────────────────────────┤
│ • layer            (Logical architectural tier: UI, Domain, Data)      │
│ • file             (Physical source file path)                         │
│ • controller       (HTTP / gRPC router endpoint handler)               │
│ • service_class    (Domain business logic use-case)                    │
│ • repository_class (Data access / ORM query abstraction)               │
│ • table            (Database schema table / collection)                │
│ • event            (Message broker queue / topic)                      │
│ • rule             (Architectural or domain compliance invariant)      │
├────────────────────────────────────────────────────────────────────────┤
│                              EDGE TYPES                                │
├────────────────────────────────────────────────────────────────────────┤
│ • CONTAINS         (Layer contains File contains Symbol)               │
│ • IMPORTS          (File imports File)                                 │
│ • CALLS            (Controller calls Service calls Repository)         │
│ • ROUTES_TO        (Endpoint routes to Controller)                     │
│ • QUERIES          (Repository queries Table)                          │
│ • MUTATES          (Service/Repository writes to Table)                │
│ • PUBLISHES        (Service publishes Event)                           │
│ • SUBSCRIBES       (Service consumes Event)                            │
│ • GOVERNED_BY      (Node conforms to Rule)                             │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Graph Delta Lifecycle Protocol

1. **Phase 0 (`INIT`)**: Generates root baseline `.devweave/graph/knowledge-graph.json`.
2. **Phase 1 (`CONTEXT`)**: Executes 1-hop / 2-hop neighborhood query to produce exact `focus_paths` within 32k context budget.
3. **Phase 5 (`IMPLEMENT`)**: Computes task-isolated delta `.devweave/tasks/<ID>/graph-delta.json`.
4. **Phase 6 (`REVIEW`)**: Dual-model review audits `graph-delta.json` for architectural layer violations.
5. **Phase 7 (`PR`)**: Atomically merges `graph-delta.json` into master `.devweave/graph/knowledge-graph.json` and stages in Git PR.
