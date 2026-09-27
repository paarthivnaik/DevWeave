---
name: document-domain
description: [Knowledge - Domain Documentation] Captures durable, subsystem-level domain knowledge and scorecards with YAML frontmatter into .devweave/domains/<name>.md.
---

# DevWeave Document Domain Skill (`devweave-document-domain`)

## Purpose
Curates domain-driven knowledge scorecards under `.devweave/domains/<name>.md` with structured YAML frontmatter. Downstream AI-DLC phases consume these scorecards to enforce domain-driven compliance (WCAG, HIPAA, SOC2, PII handling) without requiring global config flags.

---

## Frontmatter Schema
```yaml
---
type: domain
name: <domain-name>
product: <product-name>
criticality: tier-1 # [tier-0, tier-1, tier-2, tier-3]
pii_phi: true
compliance: ["WCAG 2.1 AA", "HIPAA", "SOC2"]
owners:
  - team: <team-name>
    primary: <email>
on_call:
  pagerduty: <service>
  slack: "#<channel>"
tech_stack: <technologies>
component_library: <library>
---
```

---

## Step-by-Step Instructions
1. Prompt developer for domain name and subsystem boundaries.
2. Structure frontmatter metadata (criticality, compliance regimes, team ownership).
3. Document domain rules, data models, error codes, and testing patterns.
4. Save to `.devweave/domains/<name>.md`.
5. Register domain entry in `.devweave/knowledge/registry.yaml`.
