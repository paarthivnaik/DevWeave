# DevWeave Specification: Candidate Claims & Evidence Modeling

## 1. Purpose

During work item intake, specifications, user comments, and visual mockups often make assertions about legacy codebases that may be outdated, inaccurate, or contradicted by current repository reality (e.g., *"Customer page uses stored procedure X"* or *"All authentication is handled via cookie session"*).

DevWeave models these statements as **Candidate Claims** and tracks them through a formal verification lifecycle before code implementation begins.

---

## 2. Claim Lifecycle & Verification Statuses

```text
       +-----------------------+
       |   Candidate Claim     |
       |  (Intake / Extraction)|
       +-----------+-----------+
                   |
                   v
             [ UNVERIFIED ]  <-- Default initial status
                   |
       +-----------+-----------+
       | AST / Code Inspection |
       | DB Schema Inspection  |
       | Test Suite Execution  |
       +-----------+-----------+
                   |
     +-------------+-------------+-------------+
     |                           |             |
     v                           v             v
[ VERIFIED ]              [ CONTRADICTED ]  [ PARTIALLY_VERIFIED ]
(Confirmed in code/DB)    (Refuted by code)  (Partially accurate)
```

### Verification Status Definitions:
- **`UNVERIFIED`**: Initial state upon ingestion from work items, comments, or attachments. Cannot be used as factual implementation basis without code confirmation.
- **`VERIFIED`**: Confirmed by AST static analysis, repository inspection, database schema query, or test execution.
- **`CONTRADICTED`**: Explicitly contradicted by inspected code or database schema (e.g., sproc was deleted in previous refactor). Flagged in `context.md` for human attention.
- **`PARTIALLY_VERIFIED`**: Partially accurate (e.g., sproc exists but takes different parameters).
- **`UNKNOWN`**: Insufficient information to prove or disprove; escalated to human review.

---

## 3. Evidence Artifact Structure (`evidence.json`)

Candidate claims and supporting evidence are persisted in `.devweave/modernization/stories/<ID>/evidence.json` adhering to `evidence.schema.json`:

```json
{
  "work_item_id": "MOD-001",
  "claims": [
    {
      "id": "claim-001",
      "statement": "Customer screen invokes sp_Customer_Update for discount recalculation",
      "source": "attachment:customer-spec.txt",
      "source_type": "attachment",
      "verification_status": "UNVERIFIED",
      "notes": "Must verify against legacy SQL definitions during ANALYZE phase"
    }
  ],
  "evidence_items": [
    {
      "id": "ev-001",
      "category": "TEXT_EXTRACTION",
      "reference_path": ".devweave/modernization/stories/MOD-001/evidence/customer-spec.txt",
      "content_summary": "Customer business rules and discount calculation matrix",
      "quality": "HIGH"
    }
  ],
  "updated_at": "2026-09-25T09:30:00Z"
}
```

---

## 4. Downstream Lifecycle Invariants

1. **No Plan Grounded in Contradicted Claims**: The `PLAN` phase MUST NOT create tasks based on claims with status `CONTRADICTED`.
2. **Unverified Claims Warning**: In `ANALYZE` and `PLAN`, any remaining `UNVERIFIED` claims are explicitly reported in the scorecard and human checkpoint.
3. **Traceability**: Every claim traces directly back to its source work item, comment, attachment, or code file.
