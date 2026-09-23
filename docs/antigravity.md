# DevWeave on Google Antigravity

> **"Less Tokens. More Work. Lower Bill."**

Google Antigravity serves as the primary reference AI coding host for DevWeave.

---

## 1. Plugin Integration Structure

DevWeave packages a full marketplace-ready plugin at `plugins/antigravity/`:

```text
plugins/antigravity/
├── plugin.json               # Marketplace manifest ($schema, name: "devweave", version: "1.1.0")
├── rules/
│   └── AGENTS.md             # AI-DLC lifecycle rules, phase boundaries, zero secret storage
└── skills/                   # 31 specialized engineering workflow skills
    ├── devweave-init/             # [Phase 0: Init] Autonomous repo detection & JSON knowledge graph
    ├── devweave-context/          # [Phase 1: Context] Work item intake, PII gate & 1-hop graph scoping
    ├── devweave-analyze/          # [Phase 2: Analyze] Deep archaeology & root cause
    ├── devweave-plan/             # [Phase 3: Plan] Implementation task breakdown
    ├── devweave-branch/           # [Phase 4: Branch] Isolated Git worktree gate
    ├── devweave-implement/        # [Phase 5: Implement] Plan-bound coding & Test Intelligence
    ├── devweave-pr-review/        # [Phase 6: Review] Dual-model consensus code review (Architect + DBA)
    ├── devweave-pr/               # [Phase 7: PR] Final PR packaging, graph merge & human gate
    ├── devweave-modernization-init/        # [M-Phase 0] Modernization target initialization
    ├── devweave-modernization-context/     # [M-Phase 1] Bounded legacy slice extraction
    ├── devweave-modernization-analyze/     # [M-Phase 2] Legacy behavioral mapping & [HARD GATE #1]
    ├── devweave-modernization-plan/        # [M-Phase 3] Target implementation planning & [HARD GATE #2]
    ├── devweave-modernization-branch/      # [M-Phase 4] Modernization sandbox branch isolation
    ├── devweave-modernization-implement/   # [M-Phase 5] Modernization implementation & tests
    ├── devweave-modernization-verify/      # [M-Phase 6] Parity verification & [HARD GATE #3]
    ├── devweave-modernization-pr/          # [M-Phase 7] PR assembly & graph knowledge promotion
    ├── devweave-modernization-status/      # [Modernization Status] Durable phase status inspector
    ├── devweave-modernization-report/      # [Modernization Report] Modernization lifecycle audit
    ├── devweave-fix-triage/       # [Fix Lane - Phase 1] Error triage & repro
    ├── devweave-fix-diagnose/     # [Fix Lane - Phase 2] Hypotheses & fix plan
    ├── devweave-fix-land/         # [Fix Lane - Phase 3] Patch, test & landing
    ├── devweave-modernize/        # [Modernization Lane] V1.0 migration_manifest.md
    ├── devweave-express/          # [Express Lane] Fast track for low-risk changes
    ├── devweave-update/           # [Lifecycle] In-place updater & 24h daily auto-sync
    ├── devweave-status/           # [Utility] Lifecycle state inspector
    ├── devweave-handoff/          # [Utility] Team handoff package generator
    ├── devweave-archive/          # [Utility] Workspace archiver post-merge
    ├── devweave-report/           # [Utility] Executive process & metrics report
    ├── devweave-improve/          # [Utility] Skill friction logs & improver
    ├── devweave-document-product/ # [Knowledge] Product architecture catalog
    └── devweave-document-domain/  # [Knowledge] Domain knowledge & scorecards
```

---

## 2. 1-Click Installation from GitHub

Install DevWeave directly into your Antigravity environment with zero daemons:

```powershell
# Windows (PowerShell):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git $env:TEMP\devweave; agy plugin install $env:TEMP\devweave\plugins\antigravity; Remove-Item -Recurse -Force $env:TEMP\devweave
```

```bash
# macOS / Linux (Bash):
git clone --depth 1 https://github.com/paarthivnaik/DevWeave.git /tmp/devweave && agy plugin install /tmp/devweave/plugins/antigravity && rm -rf /tmp/devweave
```

### Verify Active Plugin
When installing or verifying the plugin, Antigravity processes all 31 skills:
```text
devweave
          ✔ skills      : 31 processed
          - agents      : skipped (not found)
          - commands    : skipped (not found)
          - mcpServers  : skipped (not found)
          - hooks       : skipped (not found)
```
> **Note**: DevWeave packages its full execution workflows as **Progressive Skills** (under `skills/`) and core rules (under `rules/AGENTS.md`). The skipped entries (`agents`, `commands`, `mcpServers`, `hooks`) are optional Antigravity plugin directories not required by DevWeave.

Running `agy plugin list` displays:
```json
{
  "imports": [
    {
      "name": "devweave",
      "source": "antigravity",
      "components": [
        "skills"
      ]
    }
  ]
}
```

---

## 3. How to Update DevWeave in Antigravity

DevWeave provides 3 ways to stay updated:

### Option A: Using the In-Place Update Skill (Fastest)
Inside any Antigravity chat or terminal:
```powershell
agy run devweave-update
```
*(Fetches latest skills and rules from GitHub and updates in-place with zero uninstall friction).*

### Option B: Automatic Daily Sync (24-Hour TTL)
- On your **first session of each calendar day**, DevWeave checks GitHub in the background and updates silently.
- Consumes **0 LLM tokens** and adds **0s latency**.

### Option C: 1-Click Terminal Reinstall
Run the one-liner installation command above at any time to refresh the plugin files directly.

---

## 4. Skill Invocation Methods

1. **Canonical CLI Execution (`agy run`)**:
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

2. **V1.1 Modernization CLI Execution**:
   ```powershell
   agy run devweave-modernization-init "Angular frontend with CQRS microservices and PostgreSQL"
   agy run devweave-modernization-context "MOD-101"
   agy run devweave-modernization-analyze "MOD-101"   # Hard Gate #1
   agy run devweave-modernization-plan "MOD-101"      # Hard Gate #2
   agy run devweave-modernization-branch "MOD-101"
   agy run devweave-modernization-implement "MOD-101"
   agy run devweave-modernization-verify "MOD-101"    # Hard Gate #3
   agy run devweave-modernization-pr "MOD-101"
   agy run devweave-modernization-status "MOD-101"
   agy run devweave-modernization-report "MOD-101"
   ```

3. **Fix Lane Execution**:
   ```powershell
   agy run devweave-fix-triage "BUG-567"
   agy run devweave-fix-diagnose "BUG-567"
   agy run devweave-fix-land "BUG-567"
   ```

4. **Interactive Antigravity Chat**:
   - Type `/devweave-init` or ask the assistant: *"Initialize this repository with DevWeave"*.
