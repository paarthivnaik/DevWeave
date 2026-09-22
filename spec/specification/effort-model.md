# DevWeave Effort Model Specification

The Effort Model determines the computational depth, context granularity, reasoning rigor, agent count, and review intensity applied to an AI-DLC execution.

> **Crucial Distinction:** **Effort is NOT the same as Model.**  
> A high-capability model can be run with `LOW` effort for quick tasks, and a fast model can be invoked repeatedly across multiple steps under `HIGH` effort orchestration.

---

## 1. Effort Levels

DevWeave defines four standardized effort tiers:

1. **`LOW`**
   - Quick lookups, shallow code searches, single-file edits, minor formatting.
   - Minimal context loading; single-pass reasoning; lightweight verification.
2. **`MEDIUM`** (Default)
   - Standard feature work, bug fixes, routine refactors.
   - Targeted discovery; standard requirements and planning; complete test pass.
3. **`HIGH`**
   - Cross-cutting features, multi-module refactorings, complex integrations.
   - Deep discovery; formal threat/risk analysis; multi-agent review; exhaustive test verification.
4. **`CRITICAL`**
   - Core security modules, database schema migrations with zero-downtime requirements, financial calculations, breaking public API changes.
   - Maximum discovery & blast-radius analysis; multi-perspective specialist panel; mandatory human-in-the-loop sign-off; full regression and fuzz/chaos testing.

---

## 2. Effort Dimension Matrix

| Dimension | `LOW` | `MEDIUM` | `HIGH` | `CRITICAL` |
| :--- | :--- | :--- | :--- | :--- |
| **Discovery Depth** | Immediate file/symbol | Module & direct dependencies | Subsystem & dependency tree | Entire repository & blast radius |
| **Context Window Budget** | Minimal (< 8k tokens) | Focused (< 32k tokens) | Structured (< 64k tokens) | Comprehensive / Multi-chunk |
| **Reasoning Depth** | Fast single-turn | Balanced CoT | Deep multi-step reasoning | Multi-agent deliberation & critique |
| **Subagent Concurrency** | 1 (Single agent) | 1–2 Subagents | 2–4 Subagents | Dedicated Specialist Panel |
| **Testing Depth** | Modified unit test | Module test suite | Full test suite + Integration | Full suite + Stress / Edge-case tests |
| **Verification Depth** | Fast Lint | Build + Lint + Typecheck | Build + Lint + Typecheck + Security | Full verification + Policy audit |
| **Review Depth** | Self-review | Peer agent review | Dual reviewer consensus | Multi-specialist consensus + Human |
| **Approval Gate** | Auto / Implicit | Standard policy gate | Explicit confirmation | Mandatory human sign-off |
