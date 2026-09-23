---
name: devweave-modernization-report
description: "[Modernization Reporting] Synthesize comprehensive end-to-end modernization lifecycle report capturing architecture decisions, migration mappings, verification scorecards, and knowledge graph updates."
---

# Antigravity Modernization Report Skill (`devweave-modernization-report`)

## Purpose
Assemble an executive and technical modernization summary report consolidating architecture intent, source slices, component transformation mappings, test execution proofs, and knowledge graph promotions.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- Modernization workspace exists (`.devweave/modernization/<ID>/`).

---

## Allowed Actions
1. Read all phase artifacts (`architecture-intent.json`, `technology-profile.json`, `context.md`, `analysis.md`, `mappings.json`, `plan.md`, `verification.md`, `state.json`).
2. Synthesize comprehensive markdown report.
3. Save report to `.devweave/modernization/<ID>/report.md`.

---

## Artifacts Generated
```text
.devweave/modernization/<ID>/
└── report.md
```

---

## Report Contents
- Executive Summary & Modernization Objectives
- Source & Target Architecture Comparison
- Technology Practice Profile & Guidelines Enforced
- Generic Migration Unit Breakdown
- Component Mappings (`MIGRATED_TO`, `REPLACED_BY`, etc.)
- Behavior Preservation & Regression Verification Results
- Human Gate Decisions & Governance Log

---

## STOP Rule
- Upon assembling and saving the report, **STOP IMMEDIATELY**.
