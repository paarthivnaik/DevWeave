# Scenario 20: Environment Setup & Secure Provider Authentication Orchestration

## 1. Objective
Verify `devweave-setup` diagnostics, tool client detection (`az`, `jira`, `gh`, `tesseract`), human authorization gate for installation commands, and credential verification.

---

## 2. Preconditions
- DevWeave repository or modernization workspace active.

---

## 3. Test Steps

1. Execute `devweave-setup --provider jira`.
2. Inspect environment PATH for `jira` / `acli`.
3. If missing:
   - Display clear platform installation instructions.
   - Seek human authorization before invoking package managers (`winget`, `brew`, `apt`, `npm`).
4. Trigger provider authentication flow (`jira init` / OS credential store).
5. Verify authentication via lightweight query without logging credentials.
6. Persist declarative configuration in `.devweave/modernization/workspace.json` conforming to `provider-config.schema.json`.
7. Output summary and STOP IMMEDIATELY.

---

## 4. Expected Results
- No package manager or script is run without explicit human authorization.
- Zero secret tokens stored in repository files.
- `.devweave/modernization/workspace.json` contains only non-secret metadata.
