# DevWeave on Google Antigravity

Google Antigravity serves as the primary reference AI coding host for DevWeave.

---

## 1. Plugin Integration Structure

DevWeave packages a full marketplace-ready plugin at `plugins/devweave/`:

```text
plugins/devweave/
├── plugin.json               # Marketplace manifest ($schema, name: "devweave", version: "1.0.0")
├── rules/
│   └── AGENTS.md             # AI-DLC lifecycle rules, phase boundaries, zero secret storage
└── skills/                   # 19 specialized engineering workflow skills
    ├── devweave-init/
    ├── devweave-context/
    ├── devweave-analyze/
    ├── devweave-plan/
    ├── devweave-branch/
    ├── devweave-implement/
    ├── devweave-pr/
    ├── devweave-status/
    ├── devweave-handoff/
    ├── devweave-archive/
    ├── devweave-fix-triage/
    ├── devweave-fix-diagnose/
    ├── devweave-fix-land/
    ├── devweave-modernize/
    ├── devweave-express/
    ├── devweave-report/
    ├── devweave-improve/
    ├── devweave-document-product/
    └── devweave-document-domain/
```

---

## 2. Installation & Verification

### Local Directory Installation
To register the DevWeave plugin in Google Antigravity:

```powershell
agy plugin install D:\DevWeave\plugins\devweave
```

### Validate Plugin Structure
```powershell
agy plugin validate plugins/devweave
```
*Output: All 19 skills validated with `[ok]`.*

### Verify Active Plugin
```powershell
agy plugin list
```
*Output:*
```text
Available plugins:
  devweave (plugins/devweave)
    Status: active
    Skills: 19 available
```

---

## 3. Skill Invocation Methods

1. **CLI Execution (`agy run`)**:
   ```powershell
   agy run devweave-init
   agy run devweave-context "JIRA-1234"
   agy run devweave-analyze "JIRA-1234"
   agy run devweave-plan "JIRA-1234"
   agy run devweave-branch "JIRA-1234"
   agy run devweave-implement "JIRA-1234"
   agy run devweave-pr "JIRA-1234"
   ```

2. **Fix Lane Execution**:
   ```powershell
   agy run devweave-fix-triage "BUG-567"
   agy run devweave-fix-diagnose "BUG-567"
   agy run devweave-fix-land "BUG-567"
   ```

3. **Interactive Antigravity Chat UI**:
   - Type `/devweave-init` to inspect and initialize the active workspace repository.
   - Mention `@devweave-context` or run phase commands directly in the conversation.
