# DevWeave AI-DLC Playbook for Cognition Devin

Devin autonomous execution playbook for DevWeave AI-DLC:

## 1. Lifecycle Invariants
1. **Structured Playbook Execution**: Follow the 7-phase workflow deterministically.
2. **Phase Isolation**: Every command outputs its artifact and halts. Never auto-advance without human instruction.
3. **Human Gates & Checkpoints**: Pause and present human checkpoints at Phase 4 (Branch), Phase 6 (PR Review), and Phase 7 (PR).
4. **Plan-Bound Changes**: Apply surgical diffs strictly corresponding to `plan.md`.
5. **Dual-Model Code & SQL Review**: Evaluate system architecture, downstream impact, SQL table locks, and cascading failures.
6. **Zero Secret Storage**: Never output raw credentials, PATs, or API keys into `.devweave/`, prompts, or Git history.
7. **Durable Knowledge Base**: Populate and reference `.devweave/domains/` for token reduction.

## 2. Engineering Intelligence Rules
1. **11-Dimension Evidence-Based Detection**: Classify detected technologies as `CURRENT` or `LEGACY` citing evidence files (`file`, `reason`); unobserved facts remain `UNKNOWN`.
2. **Legacy Practice Invariance**: Document legacy practices as `OBSERVED` invariants; never promote legacy practices to recommended standards.
3. **Tripartite Modernization**: Modernization orchestrates Legacy EI + Modernization EI (transformation mappings: `MIGRATED_TO`, `TRANSFORMED_TO`, `SPLIT_INTO`, `RETIRED`) + Target Technology EI.
4. **Contextual Resolver**: Execute `EngineeringIntelligenceResolver` before coding to inject relevant rules under a 1,500 token budget.
5. **No Silent Rule Activation**: LLM-generated mandatory rules require human approval before activation; rules are versioned (`v1` -> `v2`) with immutable history in `.devweave/intelligence/history/`.
6. **Precedence Hierarchy & Exceptions**: Conflicts resolve via standard precedence (`ORGANIZATION` > `PROJECT` > `REPOSITORY` > `DEVELOPER` > `OFFICIAL` > `RECOMMENDED` > `OBSERVED`). Expired exceptions (`expiresAt < now`) are immediately invalidated.
7. **Downstream Staleness Guard**: Flag downstream artifacts as `NEEDS_REVALIDATION` when bound rules change; never silently rewrite approved artifacts.