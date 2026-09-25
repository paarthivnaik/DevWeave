# DevWeave V1.2 Modernization & Setup Command Contract Specification

This specification defines the canonical command naming, parameter schema, lifecycle phase mapping, and syntax validation rules for the **DevWeave Modernization Lifecycle** and **Generic Setup Subsystem**.

---

## 1. Mandatory Hyphenated Command Contract

All DevWeave modernization and setup commands use **hyphen-separated naming** (`devweave-setup`, `devweave-modernization-<phase>`).

Namespace space-separated syntax (e.g., `devweave modernization init`) and colon syntax (e.g., `devweave:modernization:init`) are **strictly prohibited and invalid**.

```text
devweave-setup
       ↓
devweave-modernization-init
       ↓
devweave-modernization-context <ID>
       ↓
devweave-modernization-analyze <ID>
       ↓
devweave-modernization-plan <ID>
       ↓
devweave-modernization-branch <ID>
       ↓
devweave-modernization-implement <ID>
       ↓
devweave-modernization-verify <ID>
       ↓
devweave-modernization-pr <ID>
```

Auxiliary inspection commands:
- `devweave-modernization-status <ID>`
- `devweave-modernization-report <ID>`

---

## 2. Command Reference & Phase Mapping

| Command | Argument | Phase Mapped | Input Description | Primary Output Artifacts | Next Suggested Action |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `devweave-setup` | *Optional flags* | `SETUP` | Optional `--provider <name>`, `--check-only`, `--reconfigure` | Host tool detection, OS credential verification, `.devweave/modernization/workspace.json` | `devweave-modernization-context <ID>` |
| `devweave-modernization-init` | *Optional flags* | `INIT` | Natural language architecture declaration, optional legacy source path | `.devweave/modernization/` (`architecture-intent.json`, `technology-profile.json`, `source-memory.json`, `workspace.json`) | `devweave-modernization-context <ID>` |
| `devweave-modernization-context` | `<ID>` (Required) | `CONTEXT` | Work item ID / Modernization ID | `.devweave/modernization/stories/<ID>/` (`work-item.json`, `evidence.json`, `migration-unit.json`, `migration-slice.json`, `context.md`, `state.json`, `audit.md`) | `devweave-modernization-analyze <ID>` |
| `devweave-modernization-analyze` | `<ID>` (Required) | `ANALYZE` | Work item ID | `.devweave/modernization/stories/<ID>/` (`analysis.md`, `mappings.json`, `audit.md`) | **Hard Gate #1** $\to$ `devweave-modernization-plan <ID>` |
| `devweave-modernization-plan` | `<ID>` (Required) | `PLAN` | Work item ID | `.devweave/modernization/stories/<ID>/` (`plan.md`, `audit.md`) | **Hard Gate #2** $\to$ `devweave-modernization-branch <ID>` |
| `devweave-modernization-branch` | `<ID>` (Required) | `BRANCH` | Work item ID | `.devweave/modernization/stories/<ID>/` (`state.json`, `audit.md`) | `devweave-modernization-implement <ID>` |
| `devweave-modernization-implement` | `<ID>` (Required) | `IMPLEMENT` | Work item ID | Target source files, `evidence.md`, `audit.md` | `devweave-modernization-verify <ID>` |
| `devweave-modernization-verify` | `<ID>` (Required) | `VERIFY` | Work item ID | `.devweave/modernization/stories/<ID>/` (`verification.md`, `audit.md`) | **Hard Gate #3** $\to$ `devweave-modernization-pr <ID>` |
| `devweave-modernization-pr` | `<ID>` (Required) | `PR` | Work item ID | `.devweave/modernization/stories/<ID>/` (`report.md`, `pr-description.md`, `audit.md`) | PR merge review |
| `devweave-modernization-status` | `<ID>` (Required) | `STATUS` | Work item ID | Formatted CLI status summary | None (Non-mutating) |
| `devweave-modernization-report` | `<ID>` (Required) | `REPORT` | Work item ID | `.devweave/modernization/stories/<ID>/report.md` | None (Non-mutating) |

---

## 3. Command Syntax & Parameter Rules

### 3.1 `devweave-setup`
- **Syntax**: `devweave-setup [--provider <jira|azure-devops|github|custom>] [--check-only] [--reconfigure]`
- **Behavior**:
  - Scans environment for PM CLI clients (`az`, `jira`/`acli`, `gh`), OCR engines (`tesseract`), and credentials.
  - Asks developer authorization before triggering installation helpers.
  - Verifies secure authentication without writing credentials to repository.

### 3.2 `devweave-modernization-init`
- **Syntax**: `devweave-modernization-init [intent-string] [--source <path>] [--target <path>]`
- **Behavior**:
  - Accepts natural language architecture descriptions without requiring a rigid questionnaire.
  - Automatically identifies target repository characteristics if source files exist.
  - If target repository is empty/insufficient, records state as `AI_DETERMINED` for unspecified details.
  - Generates initial Modernization ID (`MOD-001`, `MOD-002`, etc.) and initial durable state.

### 3.3 Item-Scoped Commands (`context`, `analyze`, `plan`, `branch`, `implement`, `verify`, `pr`, `status`, `report`)
- **Syntax**: `devweave-modernization-<command> <ID>`
- **Branch Syntax**: `devweave-modernization-branch <ID> [--name <branch_name>] [--base <base_branch>]` (supports explicit flags, interactive prompting, and natural language phrasing such as `"create feature/99-User-Registration from master"`).
- **Validation**:
  - The `<ID>` parameter is **mandatory**.
  - Format must match `^[A-Za-z0-9_-]+$` (e.g., `MOD-001`, `MIG-42`, `MOD-LEGACY-AUTH`, `99`).
  - Missing `<ID>` returns exit code `1` with explicit usage instructions:
    ```text
    ERROR: Missing required argument <ID>.
    Usage: devweave-modernization-<command> <ID>
    Example: devweave-modernization-<command> MOD-001
    ```

---

## 4. Rejection Rules for Malformed Invocations

The CLI dispatcher must reject the following patterns with descriptive remediation messages:

1. **Space-separated subcommand pattern**:
   - Invocation: `devweave modernization init`
   - Rejection:
     ```text
     ERROR: Invalid command syntax 'devweave modernization init'.
     DevWeave uses hyphenated modernization commands.
     Did you mean: devweave-modernization-init?
     ```
2. **Colon-separated namespace pattern**:
   - Invocation: `devweave:modernization:plan MOD-001`
   - Rejection:
     ```text
     ERROR: Invalid command syntax 'devweave:modernization:plan'.
     Did you mean: devweave-modernization-plan MOD-001?
     ```
3. **Invalid/Unknown modernization command**:
   - Invocation: `devweave-modernization-compile MOD-001`
   - Rejection:
     ```text
     ERROR: Unknown modernization command 'devweave-modernization-compile'.
     Supported commands:
       - devweave-setup
       - devweave-modernization-init
       - devweave-modernization-context <ID>
       - devweave-modernization-analyze <ID>
       - devweave-modernization-plan <ID>
       - devweave-modernization-branch <ID>
       - devweave-modernization-implement <ID>
       - devweave-modernization-verify <ID>
       - devweave-modernization-pr <ID>
       - devweave-modernization-status <ID>
       - devweave-modernization-report <ID>
     ```

---

## 5. Execution Invariants

1. **Single Phase Boundary**: Each command executes strictly its own phase and terminates.
2. **Zero Automatic Progression**: Command $N$ never automatically triggers Command $N+1$.
3. **Suggested Next Command**: Every command concludes by reporting its artifact path and suggesting the exact next CLI invocation.
