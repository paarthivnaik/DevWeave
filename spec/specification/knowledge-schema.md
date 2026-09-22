# DevWeave Knowledge Schema Specification

Each knowledge item captured within DevWeave conforms to a structured schema defining identity, domain categorization, supporting evidence, confidence score, and verification status.

---

## 1. Knowledge Item Fields

| Field | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | `string` | Yes | Unique identifier (e.g., `KB-DOM-001`, `KB-ARCH-004`). |
| `type` | `string` | Yes | Category: `architecture`, `domain`, `technical`, `convention`, `security`. |
| `title` | `string` | Yes | Concise, human-readable summary of the knowledge rule. |
| `description` | `string` | Yes | Full detailed explanation of the rule, behavior, or constraint. |
| `domain` | `string` | Yes | Bounded context or functional area (e.g., `billing`, `auth`, `inventory`). |
| `source` | `string` | Yes | Originating file path, commit hash, or work item ID. |
| `evidence` | `array<string>` | Yes | Specific code snippets, file references, or documentation citations. |
| `confidence` | `number` | Yes | Confidence score from `0.0` to `1.0`. |
| `status` | `string` | Yes | `OBSERVED`, `INFERRED`, `RECOMMENDED`, `APPROVED`, or `DEPRECATED`. |
| `last_verified`| `string (date)` | Yes | ISO 8601 date when the rule was last validated against code. |
| `approved_by` | `string` | No | Identifier of the human maintainer or validation policy gate. |

---

## 2. Example Knowledge Item (YAML Frontmatter + Markdown)

```yaml
---
id: "KB-DOM-004"
type: "domain"
title: "Tax Calculation Invariance"
description: "Tax rates must be locked at invoice creation time and never recalculated on historical invoices."
domain: "billing"
source: "src/billing/services/tax_calculator.ts#L45-L89"
evidence:
  - "src/billing/models/invoice.ts: immutable tax_snapshot field"
  - "tests/billing/tax_test.ts: historical recalculation rejection test"
confidence: 0.98
status: "APPROVED"
last_verified: "2026-09-22"
approved_by: "team-lead"
---

### Implementation Guidelines
When modifying the invoice settlement workflow, ensure `invoice.tax_snapshot` is utilized for reporting rather than making dynamic calls to `TaxService.getRate()`.
```
