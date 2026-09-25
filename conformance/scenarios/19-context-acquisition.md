# Scenario 19: Generic Work Item Context Acquisition & Evidence Modeling

## 1. Objective
Verify generic work-item context ingestion across multiple providers (Azure DevOps, Jira, GitHub, Custom), attachment text extraction, OCR image processing, candidate claim modeling, and bounded migration slice construction.

---

## 2. Preconditions
- Target repository initialized with `.devweave/modernization/architecture-intent.json`.
- Legacy repository source available in `READ_ONLY` mode.

---

## 3. Test Steps

1. Execute `devweave-modernization-context MOD-001`.
2. Select PM provider (e.g. `azure-devops`).
3. Verify client tool `az` detection. If missing, route to `devweave-setup` and stop.
4. Pass generic privacy / data-processing gate.
5. Ingest work item, comments, and attachments without storing raw credentials.
6. Process text attachments (`.txt`, `.md`, `.sql`) into `.devweave/modernization/stories/MOD-001/evidence/`.
7. Execute OCR on screenshot attachments (`mockup.png`), classifying status as `SUCCESS`, `PARTIAL`, or `FAILED` (non-blocking).
8. Extract candidate claims into `evidence.json` with status `UNVERIFIED`.
9. Construct bounded migration slice (`migration-slice.json`) under 12,000 tokens.
10. Synthesize `context.md` and update `state.json` with `status: WAITING_FOR_HUMAN`.
11. Present summary at human checkpoint and STOP IMMEDIATELY.

---

## 4. Expected Results
- Zero credentials or tokens saved in `.devweave/`.
- All claims initialized as `UNVERIFIED`.
- OCR failures do not block lifecycle.
- Agent halts at human checkpoint without auto-executing `ANALYZE`.
