---
name: report
description: [Utility - Metrics & Reporting] Generates an executive/engineering process metrics report aggregating utilization, cycle time, token spend, compliance, and effectiveness surveys.
---

# DevWeave Metrics Report Skill (`devweave-report`)

## Purpose
Walks `.devweave/work-items/**/audit.md` and `.devweave/archive/**/audit.md`, extracts all fenced `phase-metrics` JSON blocks, and compiles a comprehensive productivity and quality report.

---

## Report Sections
1. **Utilization & Velocity**: % of work items completing all phases, per-phase fire/abort counts.
2. **Impact & Cycle Time**: P50 / P90 duration from first phase start to last phase PR merge.
3. **Cost & Token Spend**: Estimated token usage per phase and per ticket.
4. **Compliance Attestation**: PII gate pass rate, audit-log emissions, security boundary enforcement.
5. **Effectiveness & Friction**: Trends from post-PR Likert surveys (Plan accuracy, Analysis coverage, Friction score, free-text feedback).

## Outputs
- Self-contained Markdown/HTML summary at `.devweave/reports/<timestamp>.md`.
