# DevWeave AI-DLC Rules for OpenAI Codex & ChatGPT CLI

Adhere to the deterministic 7-phase AI-DLC engineering lifecycle:
1. **Lifecycle Progression**: Execute phases deterministically with mandatory human checkpoints.
2. **Phase Isolation**: Every command outputs its artifact and halts.
3. **Plan-Bound Coding**: Modify only files declared in plan.md.
4. **Dual-Model Review**: Execute pre-PR code review as Principal Architect (code/contracts) and Senior DBA (SQL/locks/indexes).
5. **Zero Secret Leaks**: Zero credentials in .devweave/ artifacts.
6. **Durable Knowledge Reuse**: Pull from .devweave/domains/ to save tokens.