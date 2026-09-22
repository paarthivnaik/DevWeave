# DevWeave Audit Events Specification

The Audit system records structured lifecycle milestones, tool interactions, approvals, and token utilization for enterprise governance and telemetry.

---

## 1. Audited Lifecycle Events

DevWeave logs structured events conforming to `audit-event.schema.json` for the following milestones:

1. `RUN_STARTED`: Work item initiation and profile assignment.
2. `STATE_CHANGED`: State machine transitions (e.g. `INIT` -> `DISCOVERED`).
3. `ARTIFACT_CREATED`: Initial artifact authoring (`requirements.md`, `solution.md`).
4. `ARTIFACT_UPDATED`: Modification or iteration of an artifact.
5. `APPROVAL_REQUESTED`: Gated prompt presented to human or policy validator.
6. `APPROVAL_GRANTED` / `APPROVAL_REJECTED`: Decision recorded.
7. `TOOL_INVOKED`: Tool / CLI / MCP command initiated.
8. `DATABASE_ACCESSED`: Database connection or migration executed.
9. `TEST_EXECUTED`: Test suite run completed with pass/fail counts.
10. `VERIFICATION_COMPLETED`: Static analysis, lint, and build verification logged.
11. `REVIEW_FINDING_CREATED`: Review comment or blocking issue opened.
12. `FINDING_RESOLVED`: Review comment remediated and closed.
13. `RUN_COMPLETED`: Final PR package generated and work item closed.

---

## 2. Token & Cost Telemetry

Each audit event optionally captures input, output, and cumulative token metrics, enabling continuous cost attribution and efficiency monitoring.
