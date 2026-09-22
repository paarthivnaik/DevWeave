# DevWeave Database Capability Specification

The Database Capability provides safe, deterministic, and environment-aware database inspection, migration authoring, and schema verification.

---

## 1. Database-Neutral Architecture

DevWeave is vendor-agnostic and does not hardcode dependencies on PostgreSQL, MySQL, SQL Server, Oracle, SQLite, MongoDB, DynamoDB, or Redis:

```text
DevWeave Database Capability (Declarative Specification)
                   │
                   ▼
    Host / MCP Database Adapter
                   │
                   ▼
  Database CLI / Driver (Local/Dev)
                   │
                   ▼
         Authorized Database
```

---

## 2. Environment Boundaries & Permissions

| Environment | Access Policy | Default Permissions | Mutation Allowed? |
| :--- | :--- | :--- | :--- |
| `LOCAL` | Permitted with config | Read / Write / Migrate / Reset | Yes |
| `DEVELOPMENT` | Permitted with config | Read / Write / Migrate | Yes |
| `TEST` | Permitted with config | Read / Write / Reset | Yes |
| `STAGING` | Restricted | Read-Only | Requires Explicit Approval |
| `PRODUCTION` | **BLOCKED BY DEFAULT** | Strict Read-Only (if enabled) | **BLOCKED** |

---

## 3. Database Security Rules

1. **Zero Secret Leaks**: Database credentials, passwords, connection strings, and certificates must NEVER be stored in AI-DLC artifacts, markdown logs, or committed to Git.
2. **Environment Variable & Host Credential Storage**: Database connections must reference host environment variables or credential managers.
3. **No Unbounded Table Dumps**: Agents must inspect table schemas (`INFORMATION_SCHEMA`, DDL) and query bounded samples rather than dumping full table rows.

---

## 4. Canonical Database Lifecycle Flow

```text
Work Item / Change Request
            │
            ▼
    Detect DB Impact
            │
            ▼
Verify DB Capability & Environment Boundary
            │
            ▼
Connect to Authorized Local/Dev DB & Inspect Schema
            │
            ▼
  Build Focused DB Context
            │
            ▼
    Design Migration (Up/Down)
            │
            ▼
       Approval Gate
            │
            ▼
Apply Migration to Local DB & Run Tests
            │
            ▼
  Verify Schema & Rollback Safety
            │
            ▼
Code Review & PR Ready
```
