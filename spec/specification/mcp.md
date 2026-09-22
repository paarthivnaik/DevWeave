# DevWeave MCP & Tool Capability Specification

Model Context Protocol (MCP) and external tools provide extensible capabilities for agents to interact with local repository tooling and external infrastructure.

---

## 1. Architectural Boundary

MCP is an **optional extension**, never a mandatory runtime dependency for DevWeave:

```text
DevWeave Capability Layer
           │
           ▼
Host / MCP Adapter Boundary
           │
           ▼
    Active MCP Servers (Optional)
   (e.g., Git, Database, AST, CI/CD)
```

---

## 2. Integration Guidelines

- **Stateless & Resilient**: MCP failures or unavailability must degrade gracefully without crashing the AI-DLC state machine.
- **Auditable Invocations**: Every MCP tool execution must be logged as an `AuditEvent` with input arguments and execution status.
- **Least-Privilege Isolation**: MCP tools operate within repository workspace boundaries.
