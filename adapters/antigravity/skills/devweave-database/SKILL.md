---
name: devweave-database
description: Inspects authorized local schemas, drafts migrations, and verifies database integrity.
---

# DevWeave Database Skill (Antigravity)

## Instructions
1. Check database environment boundary (`LOCAL`, `DEVELOPMENT`, `TEST` permitted; `PRODUCTION` blocked).
2. Inspect table DDL and relationships.
3. Generate backward-compatible migration scripts (up and down).
4. Apply migration against local/development database.
5. Run integration tests and verify rollback safety.
