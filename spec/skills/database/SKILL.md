---
name: database
description: Inspects local/dev schemas, plans migrations, and applies database modifications safely.
---

# Database Skill

## Purpose
Inspect authorized database schemas, generate migration scripts, validate data integrity constraints, and verify database operations safely.

## When to Use
- During `DATABASE` profile workflows or any work item touching data models and schemas.

## Inputs
- Entity requirements / data change specifications
- Existing schema files or database connection endpoint (Local/Dev only)

## Required Context
- Database environment boundaries and access permissions
- Migration tooling conventions (e.g. Prisma, EF Core, Flyway, Alembic)

## Procedure
1. Inspect existing table schemas and foreign key constraints.
2. Formulate backward-compatible migration plan (e.g. expand/contract).
3. Author migration script or ORM schema update.
4. Execute migration against authorized local/development database.
5. Validate rollback script and run integration tests.

## Constraints
- PRODUCTION database direct modification is STRICTLY PROHIBITED by default.
- Never hardcode or commit database credentials.

## Expected Artifacts
- Migration scripts (up/down)
- Updated ORM models
- Schema verification report

## Success Criteria
- Migration applies and rolls back cleanly without data loss.

## Failure Conditions
- Lock timeouts, irreversible destructive operations, or failed migration rollback.
