# DevWeave AI-DLC Rules for Gemini CLI

When using DevWeave with Gemini CLI, adhere strictly to the 7-phase AI-DLC engineering lifecycle:

## 1. Core Lifecycle Invariants
1. **7-Phase Progression**: Phase 0 (Init) -> Phase 1 (Context) -> Phase 2 (Analyze) -> Phase 3 (Plan) -> Phase 4 (Branch) -> Phase 5 (Implement) -> Phase 6 (PR Review) -> Phase 7 (PR).
2. **Phase Isolation**: Never auto-advance without explicit human decision. Every command outputs its artifact and halts.
3. **Plan-Bound Implementation**: In Phase 5, strictly bound code edits to approved `plan.md`.
4. **Dual-Model Review**: In Phase 6, evaluate code as a **Principal Software Architect** and **Senior DBA**.
5. **Zero Secret Storage**: Never write credentials or PATs to `.devweave/` or Git history.
6. **Durable Knowledge Caching**: Reuse and promote domain knowledge via `.devweave/domains/`.

## 2. Engineering Intelligence Rules
1. **11-Dimension Evidence-Based Detection**: Classify detected technologies as `CURRENT` or `LEGACY` citing evidence files (`file`, `reason`); unobserved facts remain `UNKNOWN`.
2. **Legacy Practice Invariance**: Document legacy practices as `OBSERVED` invariants; never promote legacy practices to recommended standards.
3. **Tripartite Modernization**: Modernization orchestrates Legacy EI + Modernization EI (transformation mappings: `MIGRATED_TO`, `TRANSFORMED_TO`, `SPLIT_INTO`, `RETIRED`) + Target Technology EI.
4. **Contextual Resolver**: Execute `EngineeringIntelligenceResolver` before coding to inject relevant rules under a 1,500 token budget.
5. **No Silent Rule Activation**: LLM-generated mandatory rules require human approval before activation; rules are versioned (`v1` -> `v2`) with immutable history in `.devweave/intelligence/history/`.
6. **Precedence Hierarchy & Exceptions**: Conflicts resolve via standard precedence (`ORGANIZATION` > `PROJECT` > `REPOSITORY` > `DEVELOPER` > `OFFICIAL` > `RECOMMENDED` > `OBSERVED`). Expired exceptions (`expiresAt < now`) are immediately invalidated.
7. **Downstream Staleness Guard**: Flag downstream artifacts as `NEEDS_REVALIDATION` when bound rules change; never silently rewrite approved artifacts.