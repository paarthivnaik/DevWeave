# DevWeave V1.0 — Schema Validation Evidence

## 1. Test Execution Metadata

- **Test Suite**: `conformance/tests/validate_schemas.ps1`
- **Date & Timestamp**: `2026-09-22T18:22:00+05:30`
- **DevWeave Version**: `1.0.0`
- **Target Schemas Directory**: `conformance/schemas/`
- **Total Schemas Validated**: 13
- **Total Test Cases Executed**: 26 (13 Valid Fixtures + 13 Invalid Fixtures)
- **Overall Status**: **PASSED (26/26)**

---

## 2. Test Execution Matrix

| Schema | Valid Fixture Result | Invalid Fixture Result | Validation Error Detection | Status |
| :--- | :--- | :--- | :--- | :--- |
| **`approval.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Missing required fields, invalid enum | **PASS** |
| **`audit-event.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Invalid actor type, missing timestamp | **PASS** |
| **`context.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Negative token budget, missing sources | **PASS** |
| **`decision.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Invalid ID pattern, invalid status | **PASS** |
| **`knowledge.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Out-of-bounds confidence, invalid type | **PASS** |
| **`plan.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Empty tasks array (`minItems: 1`) | **PASS** |
| **`requirement.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Missing criteria, invalid ID pattern | **PASS** |
| **`review-finding.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Invalid perspective enum | **PASS** |
| **`solution.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Invalid impact level, missing summary | **PASS** |
| **`state.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Unrecognized state, invalid history type | **PASS** |
| **`task.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Step number < 1, empty target files | **PASS** |
| **`test-result.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Negative test count, invalid status | **PASS** |
| **`verification.schema.json`** | ✅ PASS | ✅ Correctly Rejected | Empty checks array (`minItems: 1`) | **PASS** |

---

## 3. Deterministic Validation Details

The test harness confirms that:
1. All valid schema fixtures parse cleanly and satisfy all schema constraints (types, patterns, enums, required fields).
2. All invalid schema fixtures are deterministically rejected with precise error messages identifying the violated constraint.
3. No canonical schemas were modified or weakened to achieve passing status.
