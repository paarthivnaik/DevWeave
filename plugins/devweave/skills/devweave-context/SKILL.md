---
name: devweave-context
description: Ingests work item via PM MCP or manual input with PII/privacy hard gate, supports --refresh change detection, loads domain/product catalogs, and builds focused context.md.
---

# DevWeave Context Skill (`devweave-context`)

## Execution Invariants
1. **Single-Phase Execution**: Execute ONLY the CONTEXT phase. Do NOT automatically advance to ANALYZE.
2. **PII / Privacy Hard Gate**: Prompt user to confirm ticket contains no unredacted PII/PHI or sensitive data before fetching.
3. **Resume Detection**: If `.devweave/work-items/<ID>/` exists, check for `handoff.md` and display before continuing.
4. **Zero Secret Storage**: Never write Personal Access Tokens (PATs) or raw secrets into artifacts.

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

### Step 2: Work Item Retrieval & Normalization
- Retrieve ticket via configured PM MCP (Jira, Azure DevOps, GitHub, Linear) or prompt for manual paste input.
- Classify work item type: `BUG` vs `FEATURE` (Story/Task/Epic).
- For **Features**: Extract acceptance criteria, parent Epic, sibling stories, and Figma design references.
- For **Bugs**: Extract environment, reproduction sequence, error logs, and runtime stack traces.

### Step 3: Domain, Product & Technology Context Loading
- Load relevant product docs from `.devweave/products/<name>.md`.
- Load relevant domain scorecards from `.devweave/domains/<name>.md` honoring YAML frontmatter (`criticality`, `compliance: ["WCAG 2.1 AA", "SOC2"]`, `owners`, `on_call`).
- Detect target technology. If runtime version has changed (e.g. .NET Core 3.1 $\to$ .NET 9), mark affected domain knowledge as `NEEDS_REVALIDATION`.

### Step 4: Assemble Context Artifact
- Create or update `.devweave/work-items/<ID>/context.md`.
- Record metrics and audit event in `.devweave/work-items/<ID>/audit.md`.
- Update state in `.devweave/work-items/<ID>/state.md`.

### Step 5: Human Checkpoint
- Present completion summary:
  ```text
  CONTEXT COMPLETE
  Work Item: <ID> (Type: <BUG | FEATURE>)
  Loaded Domains: <list>
  Compliance Regimes: <list>
  Artifact: .devweave/work-items/<ID>/context.md

  Human Decision: [Approve Context] [Request Changes] [Provide Info] [Stop]
  Suggested Next Phase: ANALYZE
  Run: DevWeave-analyze <ID>

  DevWeave is waiting for your instruction.
  ```

### Step 6: Terminate Execution
- Stop and wait for explicit user instruction.
