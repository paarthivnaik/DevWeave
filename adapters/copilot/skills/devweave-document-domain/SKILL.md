---
name: devweave-document-domain
description: "[Knowledge - Domain Documentation] Captures and synthesizes durable domain knowledge, ubiquitous language, business rules, processes, and mappings into .devweave/domain/knowledge.json and .devweave/domains/<name>.md."
---

# DevWeave Document Domain Skill (`devweave-document-domain`)

## Purpose
Synthesizes and maintains the canonical business domain intelligence layer under `.devweave/domain/knowledge.json` and human-readable scorecards under `.devweave/domains/<name>.md`. Captures ubiquitous language, domain concepts, business rules, processes, capabilities, terminology, domain events, constraints, and mappings to repository entities with evidence-backed provenance.

---

## Inputs & Parameters
- `--domain <name>`: Optional target domain identifier (e.g. `domain:billing`, `domain:prescriptions`).
- `--reconcile`: Reconciles domain knowledge against current codebase and Knowledge Graph.

---

## Canonical Domain Model (`.devweave/domain/knowledge.json`)
```json
{
  "$schema": "https://devweave.org/schemas/v1/domain-knowledge.schema.json",
  "schemaVersion": "1.4.0",
  "domainId": "domain:<name>",
  "name": "<Human Readable Domain Name>",
  "status": "OBSERVED",
  "concepts": [],
  "businessRules": [],
  "processes": [],
  "capabilities": [],
  "terminology": [],
  "domainEvents": [],
  "constraints": [],
  "mappings": {
    "domainToCode": [],
    "domainToApi": [],
    "domainToData": []
  }
}
```

---

## Step-by-Step Instructions
1. Prompt developer for domain boundary, scope, or target capability.
2. Inspect repository manifests, source files, and Knowledge Graph to identify domain entities and evidence.
3. Extract ubiquitous terms, business rules, validations, and workflows.
4. Structure concepts with stable IDs (`domain:<name>:concept:<item>`) and status (`OBSERVED`, `DERIVED`, `HUMAN_CONFIRMED`).
5. Persist canonical domain knowledge to `.devweave/domain/knowledge.json` and `.devweave/domains/<name>.md`.
6. Output summary and **STOP IMMEDIATELY**.
