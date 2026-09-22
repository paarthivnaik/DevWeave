# DevWeave on Google Antigravity

Google Antigravity serves as the primary reference AI coding host for DevWeave.

---

## 1. Plugin Integration Structure

DevWeave packages a full marketplace-ready plugin at `plugins/antigravity/`:

```text
plugins/antigravity/
├── plugin.json               # Marketplace manifest ($schema, name: "devweave", version: "1.0.0")
├── rules/
│   └── AGENTS.md             # AI-DLC lifecycle rules, phase boundaries, zero secret storage
└── skills/                   # 20 specialized engineering workflow skills
    ├── devweave-init/             # [Phase 0: Init] Autonomous repo detection
    ├── devweave-context/          # [Phase 1: Context] Work item intake & PII gate
    ├── devweave-analyze/          # [Phase 2: Analyze] Deep archaeology & root cause
    ├── devweave-plan/             # [Phase 3: Plan] Implementation task breakdown
    ├── devweave-branch/           # [Phase 4: Branch] Isolated Git worktree gate
    ├── devweave-implement/        # [Phase 5: Implement] Plan-bound surgical coding
    ├── devweave-pr-review/        # [Phase 6: Review] Dual-model consensus code review (Architect + DBA)
    ├── devweave-pr/               # [Phase 7: PR] Final PR packaging & human gate
    ├── devweave-fix-triage/       # [Fix Lane - Phase 1] Error triage & repro
    ├── devweave-fix-diagnose/     # [Fix Lane - Phase 2] Hypotheses & fix plan
    ├── devweave-fix-land/         # [Fix Lane - Phase 3] Patch, test & landing
    ├── devweave-modernize/        # [Modernization Lane] migration_manifest.md
    ├── devweave-express/          # [Express Lane] Fast track for low-risk changes
    ├── devweave-status/           # [Utility] Lifecycle state inspector
    ├── devweave-handoff/          # [Utility] Team handoff package generator
    ├── devweave-archive/          # [Utility] Workspace archiver post-merge
    ├── devweave-report/           # [Utility] Executive process & metrics report
    ├── devweave-improve/          # [Utility] Skill friction logs & improver
    ├── devweave-document-product/ # [Knowledge] Product architecture catalog
    └── devweave-document-domain/  # [Knowledge] Domain knowledge & scorecards
```

---

## 2. Installation & Verification

### Local Directory Installation
To register the DevWeave plugin in Google Antigravity:

```powershell
agy plugin install D:\DevWeave\plugins\antigravity
```

### Validate Plugin Structure
```powershell
agy plugin validate plugins/antigravity
```
*Output: All 20 skills validated with `[ok]`.*

### Verify Active Plugin
```powershell
agy plugin list
```
*Output:*
```text
Available plugins:
  devweave (plugins/antigravity)
    Status: active
    Skills: 20 available
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
   agy run devweave-pr-review "JIRA-1234"     # Dual-Model Review (Architect + DBA)
   agy run devweave-pr "JIRA-1234"            # Final PR Assembly & Approval Gate
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
