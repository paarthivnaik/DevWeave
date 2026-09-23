---
name: devweave-modernization-status
description: "[Modernization Observation] Inspect and display durable status, completed phases, active gate requirements, and next suggested command for a modernization work item."
---

# OpenAI Codex Modernization Status Command (`codex run devweave-modernization-status`)

## Purpose
Read and render the current durable state of a modernization work item without modifying any files or triggering state transitions.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`).

---

## Preconditions
- State file exists (`.devweave/modernization/stories/<ID>/state.json`).

---

## Allowed Actions
1. Read `.devweave/modernization/stories/<ID>/state.json`.
2. Format human-readable phase progression scorecard.
3. Display current gate requirements and blocker details if any.
4. Output exact next suggested CLI command.

---

## Output Example
```text
Modernization ID: MOD-001
Current Phase:    VERIFY
Status:           WAITING_FOR_HUMAN (Hard Gate #3)

Phase Progression:
  [✓] INIT
  [✓] CONTEXT
  [✓] ANALYZE (Approved by Human-Lead)
  [✓] PLAN (Approved by Human-Lead)
  [✓] BRANCH (devweave/modernization/MOD-001)
  [✓] IMPLEMENT (All tests passing)
  [→] VERIFY (Scorecard ready for review)
  [ ] PR

Next Suggested Command:
  devweave-modernization-verify MOD-001
```

---

## STOP Rule
- Non-mutating observation command; **STOP IMMEDIATELY** after outputting status.
