# DevWeave AI-DLC Rules for Gemini CLI

When using DevWeave with Gemini CLI, adhere strictly to the 7-phase AI-DLC engineering lifecycle:
1. **7-Phase Progression**: Phase 0 (Init) -> Phase 1 (Context) -> Phase 2 (Analyze) -> Phase 3 (Plan) -> Phase 4 (Branch) -> Phase 5 (Implement) -> Phase 6 (PR Review) -> Phase 7 (PR).
2. **Phase Isolation**: Never auto-advance without explicit human decision.
3. **Plan-Bound Implementation**: In Phase 5, strictly bound code edits to approved plan.md.
4. **Dual-Model Review**: In Phase 6, evaluate code as a **Principal Software Architect** and **Senior DBA**.
5. **Zero Secret Storage**: Never write credentials or PATs to .devweave/ or Git history.
6. **Durable Knowledge Caching**: Reuse and promote domain knowledge via .devweave/domains/.