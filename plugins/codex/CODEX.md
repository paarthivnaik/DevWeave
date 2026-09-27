# DevWeave AI-DLC Rules for OpenAI Codex & ChatGPT CLI

Adhere to the deterministic 7-phase AI-DLC engineering lifecycle:

## 1. Core Lifecycle Invariants
1. **Lifecycle Progression**: Execute phases deterministically with mandatory human checkpoints.
2. **Phase Isolation**: Every command outputs its artifact and halts. Never auto-advance without human instruction.
3. **Plan-Bound Coding**: Modify only files declared in `plan.md`.
4. **Dual-Model Review**: Execute pre-PR code review as Principal Architect (code/contracts) and Senior DBA (SQL/locks/indexes).
5. **Zero Secret Leaks**: Zero credentials or PATs in `.devweave/` artifacts or Git history.
6. **Durable Knowledge Reuse**: Pull from `.devweave/domains/` to save tokens.

## 2. Engineering Intelligence Rules
1. **11-Dimension Evidence-Based Detection**: Classify detected technologies as `CURRENT` or `LEGACY` citing evidence files (`file`, `reason`); unobserved facts remain `UNKNOWN`.
2. **Legacy Practice Invariance**: Document legacy practices as `OBSERVED` invariants; never promote legacy practices to recommended standards.
3. **Tripartite Modernization**: Modernization orchestrates Legacy EI + Modernization EI (transformation mappings: `MIGRATED_TO`, `TRANSFORMED_TO`, `SPLIT_INTO`, `RETIRED`) + Target Technology EI.
4. **Contextual Resolver**: Execute `EngineeringIntelligenceResolver` before coding to inject relevant rules under a 1,500 token budget.
5. **No Silent Rule Activation**: LLM-generated mandatory rules require human approval before activation; rules are versioned (`v1` -> `v2`) with immutable history in `.devweave/intelligence/history/`.
6. **Precedence Hierarchy & Exceptions**: Conflicts resolve via standard precedence (`ORGANIZATION` > `PROJECT` > `REPOSITORY` > `DEVELOPER` > `OFFICIAL` > `RECOMMENDED` > `OBSERVED`). Expired exceptions (`expiresAt < now`) are immediately invalidated.
7. **Downstream Staleness Guard**: Flag downstream artifacts as `NEEDS_REVALIDATION` when bound rules change; never silently rewrite approved artifacts.