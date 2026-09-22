# DevWeave Security & Governance Specification

Security and governance within DevWeave protect repositories, infrastructure, secrets, and production environments from unauthorized or accidental harm.

---

## 1. Security Domains

1. **Secrets & Credentials**: Prevent credential leakage into prompts, artifacts, diffs, or git history.
2. **Filesystem Boundaries**: Prevent unauthorized file access, mass deletions, or modification outside the repository root.
3. **Network & External Access**: Restrict outbound network requests to authorized endpoints and package registries.
4. **Tool & MCP Safety**: Enforce least-privilege tool access with bounded capabilities.
5. **Database Governance**: Restrict database mutation to local and development environments with complete production lockdown.
6. **Destructive Commands**: Block shell commands involving destructive disk formatting, recursive force deletion (`rm -rf /`, `rmdir /s /q C:\`), or process termination outside task scope.

---

## 2. Human Approval Gatekeeping

Human approval is strictly mandatory for the following operations:
- Direct database schema mutations in STAGING or PRODUCTION.
- Destructive migration scripts or irreversible table drops.
- Deployment trigger commands to production environments.
- Modification of security policies or approval rules.
- Addition of new external MCP servers or unauthorized CLI tools.
- Mass file deletion exceeding policy thresholds (e.g. > 10 files).
