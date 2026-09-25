---
name: devweave-context
description: "[Phase 1: Context] Ingests work item via PM tool selection (Jira, Azure DevOps, GitHub, Linear, Manual) with two-tier configuration persistence, dynamic PATH refresh, PII/privacy hard gate, supports --refresh change detection, loads domain/product catalogs, and builds focused context.md."
---

# Antigravity Context Skill (`devweave-context`)

## Execution Invariants
1. **Single-Phase Execution**: Execute ONLY the CONTEXT phase. Do NOT automatically advance to ANALYZE.
2. **PII / Privacy Hard Gate**: Prompt user to confirm ticket contains no unredacted PII/PHI or sensitive data before fetching.
3. **PM Tool Persistence & Two-Tier Resolution**: Check `.devweave/workspace.json` $\to$ `~/.devweave/config.json` before prompting. Only prompt if no provider is configured.
4. **Dynamic PATH Refresh**: Refresh environment PATH dynamically before probing CLI presence so newly installed tools are recognized without terminal restarts.
5. **Resume Detection**: If `.devweave/work-items/<ID>/` exists, check for `handoff.md` and display before continuing.
6. **Zero Secret Storage**: Never write Personal Access Tokens (PATs) or raw secrets into artifacts.

---

## Step-by-Step Instructions

### Step 0: Resume & Prerequisite Check
- Check if `.devweave/work-items/<ID>/` already exists.
- If `handoff.md` exists, display it and require acknowledgment.
- If `--refresh` is passed, compare external ticket hash against stored context; if material changes are detected, invalidate downstream phases (`ANALYZE`, `PLAN`) and reset state.

### Step 1: PII / Privacy Hard Gate
- Prompt developer:
  ```text
  [PII / Privacy Gate]
  Please confirm that ticket <ID> contains no unredacted PII, PHI, or sensitive customer credentials and is authorized for AI processing.
  [Confirm & Proceed] [Cancel]
  ```

### Step 2: Two-Tier PM Tool Resolution & Work Item Retrieval
- **Dynamic PATH Refresh**:
  - Refresh the current process `PATH` from Windows Environment / Registry before checking CLI availability.
- **Check Persisted PM Source (Two-Tier Hierarchy)**:
  - 1. Check workspace configuration: `.devweave/workspace.json` (`pmSource`).
  - 2. Check global user configuration: `~/.devweave/config.json` (`defaultPmSource`).
  - If a PM source is found in workspace or global configuration, **automatically use it without re-prompting**.
- **First-Time Selection (If not found or `--reconfigure` passed)**:
  - Present Project Management source selector:
    ```text
    [DevWeave Context Intake]
    Work Item: <ID>

    Select Project Management Source:
      [1] Atlassian Jira (Jira MCP / API)
      [2] Azure DevOps Boards (ADO MCP / API)
      [3] GitHub Issues & Projects (GitHub MCP / GraphQL)
      [4] Linear (Linear MCP)
      [5] Manual Paste / Offline Markdown Input

    Selection: [1 | 2 | 3 | 4 | 5]
    ```
  - Persist selected `pmSource` into `.devweave/workspace.json` and `~/.devweave/config.json`.
- **Subsequent Invocations**:
  - If `pmSource` is configured for an MCP tool (`jira`, `ado`, `github`, `linear`) and the client/MCP server is active, automatically connect and fetch ticket `<ID>` without prompting.
  - If MCP/CLI connection is unavailable or `pmSource` is `manual`, prompt the developer with the structured Markdown template to paste ticket details.
- Classify work item type: `BUG` vs `FEATURE` (Story/Task/Epic).
- For **Features**: Extract acceptance criteria, parent Epic, sibling stories, and Figma design references.
- For **Bugs**: Extract environment, reproduction sequence, error logs, and runtime stack traces.

### Step 3: Domain, Product & Technology Context Loading
- Load relevant product docs from `.devweave/products/<name>.md`.
- Load relevant domain scorecards from `.devweave/domains/<name>.md` honoring YAML frontmatter (`criticality`, `compliance: ["WCAG 2.1 AA", "SOC2"]`, `owners`, `on_call`).
- Detect target technology. If runtime version has changed (e.g. .NET Core 3.1 $\to$ .NET 9), mark affected domain knowledge as `NEEDS_REVALIDATION`.

### Step 4: JSON Knowledge Graph Traversal & Blast Radius Scoping
- Query `.devweave/graph/knowledge-graph.json` to identify target entrypoints and components.
- Perform **1-Hop / 2-Hop Neighborhood Traversal**:
  - *Incoming Edges (Callers)*: Components depending on target.
  - *Outgoing Edges (Callees)*: Dependencies, Repositories, Database Tables, Event Queues.
- Bound context strictly to calculated `focus_paths` under the **32,000 token context budget**.

### Step 5: Assemble Context Artifact
- Create or update `.devweave/work-items/<ID>/context.md`.
- Record metrics and audit event in `.devweave/work-items/<ID>/audit.md`.
- Update state in `.devweave/work-items/<ID>/state.md`.

### Step 6: Human Checkpoint
- Present completion summary:
  ```text
  CONTEXT COMPLETE
  Work Item: <ID> (Type: <BUG | FEATURE>)
  PM Source: <Jira | Azure DevOps | GitHub | Linear | Manual>
  Loaded Domains: <list>
  Compliance Regimes: <list>
  Artifact: .devweave/work-items/<ID>/context.md

  Human Decision: [Approve Context] [Request Changes] [Provide Info] [Stop]
  Suggested Next Phase: ANALYZE
  Run: devweave-analyze <ID>
  ```

### Step 7: Terminate Execution
- Stop and wait for explicit user instruction.
