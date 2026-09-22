---
name: devweave-modernize
description: Modernization Lane - Orchestrates framework/runtime upgrades, parity contracts, migration manifests, and stepwise feature migration.
---

# DevWeave Modernize Skill (`devweave-modernize`)

## Step-by-Step Instructions
1. **Modernize Context**: Ingest upgrade scope and detect target runtime zones.
2. **Modernize Analyze**: Perform deep architectural analysis (DTO contracts, ORM query changes, template syntax).
3. **Modernize Plan**: Emit `plan.md` AND `.devweave/migration/<Feature>/migration_manifest.md` with 100% parity checklist.
4. **Modernize Branch**: Create migration branch (`modernize/<ID>`) upon human approval.
5. **Modernize Implement**: Execute stepwise migrations with lockstep manifest status updates (🔴 $\to$ 🟡 $\to$ 🟢).
6. **Modernize PR**: Execute parity verification sweep and assemble modernization PR package.
