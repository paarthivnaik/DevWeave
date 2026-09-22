# DevWeave Conformance & Host Verification

The Conformance Suite ensures that any AI coding host adapter adheres to the canonical DevWeave specification.

## Verification Checklist
1. **Declarative First**: Ensure no proprietary runtime or mandatory programming language is imposed.
2. **Schema Adherence**: All artifacts must validate against canonical JSON Schemas in `schemas/`.
3. **State Machine Integrity**: Gated transitions must block invalid progression and enforce approvals.
4. **Environment Safety**: Production database mutations and destructive shell commands must be rejected by default.
5. **Traceability**: Changes must maintain unbroken linkage from `REQ-xxx` to `PLAN-xxx`, code diffs, and test results.
