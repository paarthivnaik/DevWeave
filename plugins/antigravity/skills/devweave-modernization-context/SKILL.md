---
name: devweave-modernization-context
description: "[Modernization Phase 1: Context] Ingest generic work item context via WorkItemProvider adapters with two-tier configuration persistence and dynamic PATH refresh, extract attachment text & OCR images, model candidate claims, build bounded migration slice, integrate knowledge graph deltas, and enforce human checkpoint."
---

# Antigravity Modernization Context Skill (`devweave-modernization-context`)

## Purpose
Construct a bounded, token-efficient migration context for the specified modernization work item by discovering relevant legacy source slices, acquiring full work item details via generic provider adapters (Azure DevOps, Jira, GitHub, Custom) with two-tier configuration persistence and dynamic PATH refresh, extracting text and performing OCR on attachments, cataloging candidate claims with verification statuses, retrieving related knowledge graph entities, loading targeted technology practices, and compiling `context.md`, `work-item.json`, `evidence.json`, `migration-slice.json`, and `audit.md` without loading entire legacy repositories into AI memory.

---

## Inputs & Parameters
- `<ID>`: Modernization work item ID (e.g. `MOD-001`, `99`, `PROJ-1234`).
- Optional flags:
  - `--provider <azure-devops|jira|github|custom>`: Explicitly select or override PM provider.
  - `--reconfigure`: Prompt to update provider selection.
  - `--skip-ocr`: Skip OCR extraction on image attachments.

---

## Preconditions
- Central modernization project initialized (`.devweave/modernization/architecture-intent.json` or `.devweave/modernization/workspace.json`).

---

## Allowed Actions

### 1. PM Provider Selection & Dynamic PATH Verification
- **Dynamic PATH Refresh**: Refresh current process `PATH` from OS Registry/Environment before probing provider CLIs.
- **Two-Tier Configuration Check**:
  - 1. Check workspace configuration: `.devweave/modernization/workspace.json` (or `.devweave/workspace.json`).
  - 2. Check global user configuration: `~/.devweave/config.json`.
  - If provider is configured in workspace or global settings and `--reconfigure` is not set, **automatically use the configured provider without re-prompting**.
- **First-Time Selection (If unconfigured or `--reconfigure` passed)**:
  Prompt the developer:
  ```text
  Which project-management system contains this work item?
  1. Azure DevOps
  2. Jira
  3. GitHub
  4. Other / Custom
  ```
  Persist selected provider to `.devweave/modernization/workspace.json` and `~/.devweave/config.json`.
- **Client / CLI Detection**:
  - Run `ProviderAdapter.detectClient()` (e.g., `az`, `jira`/`acli`, `gh`).
  - If client is missing:
    ```text
    Required client for <provider> is not installed or not found in PATH.
    Run:
    devweave-setup
    ```
    **STOP IMMEDIATELY**. Do not proceed with unmanaged installation.
- **Secure Authentication Check**:
  - Verify credentials via provider native status command.
  - If unauthenticated, guide developer to authenticate.
  - **Zero Secret Rule**: Never store credentials, tokens, or PATs in `.devweave/`, Git, logs, JSON, or prompts.

### 2. Generic Privacy & Data-Processing Hard Gate
- Prompt developer to confirm permission before dispatching work-item text or attachments to external processing:
  ```text
  This operation will retrieve work-item information, comments, attachments, and related content for modernization analysis.
  Proceed? [Approve] [Reject]
  ```
- If rejected, stop context acquisition immediately.

### 3. Work Item Acquisition & Evidence Processing
- **Work Item Retrieval**: Ingest title, description, type, status, priority, acceptance criteria, assignee, reporter, labels, iteration, and provider metadata. Save normalized `.devweave/modernization/stories/<ID>/work-item.json`.
- **Comments Extraction**: Fetch chronological comments with author attribution.
- **Attachment Text & OCR Processing**:
  - Classify attachments: `TEXT`, `DOCUMENT`, `IMAGE`, `ARCHIVE`, `OTHER`.
  - Extract text from text-based attachments into `.devweave/modernization/stories/<ID>/evidence/`.
  - Execute OCR on image attachments (`SUCCESS`, `PARTIAL`, `FAILED`).
  - *Non-Blocking*: OCR failures do NOT halt the context phase.
  - *Zero Hallucination*: Never fabricate visual text.
- **Linked Items & Historical Work**: Ingest linked work items and discover related prior art.
- **Candidate Claims Modeling**: Extract claims requiring verification (`UNVERIFIED`, `VERIFIED`, `CONTRADICTED`, `PARTIALLY_VERIFIED`, `UNKNOWN`) and write `.devweave/modernization/stories/<ID>/evidence.json`.

### 4. Legacy Repository Slicing & Graph Delta Integration
- **Legacy Inspection**: Inspect legacy codebase in `READ_ONLY` mode (controllers, views, models, database objects, tests).
- **Bounded Migration Slice**: Identify modernization unit (`PAGE`, `SCREEN`, `FEATURE`, `MODULE`, `SERVICE`, `DOMAIN`, etc.) and trace direct dependencies. Persist `.devweave/modernization/stories/<ID>/migration-slice.json` within token budget (< 12,000 tokens).
- **Target Architecture Alignment**: Map against `.devweave/modernization/architecture-intent.json` (`USER_DECLARED` vs `UNKNOWN` / `AI_DETERMINED`).
- **Knowledge Graph Delta**: Record incremental relationships (`WORK_ITEM`, `MIGRATED_TO`, `AFFECTS`, `REFERENCES`, `HAS_ATTACHMENT`).

### 5. Unified Context Synthesis (`context.md`)
- Compile standard `context.md` covering:
  - Work Item Metadata & Description
  - Requested Modernization Unit
  - Target Architecture Intent
  - Legacy Architecture & Bounded Migration Slice
  - Database & Integration Dependencies
  - Tests & Verification Traceability
  - Linked & Historical Prior Art
  - Evidence & Candidate Claims Matrix
  - Risks & Unresolved Questions

### 6. User-Only Story Audit Trail (`audit.md`)
- Log exclusively human actions and prompt inputs to `.devweave/modernization/stories/<ID>/audit.md` with `Author: <User Name> <email@example.com>`.

---

## Artifacts Generated
```text
.devweave/modernization/stories/<ID>/
├── work-item.json              <-- Normalized work-item details, comments & attachment catalog
├── evidence.json               <-- Extracted claims & verification statuses
├── migration-unit.json         <-- Target modernization unit definition
├── migration-slice.json        <-- Bounded dependency graph slice
├── context.md                  <-- Unified Markdown context
├── state.json                  <-- Story phase tracker & hard gates
├── audit.md                    <-- Append-only human activity, prompt & decision log
└── evidence/                   <-- Extracted text & OCR evidence files
```

---

## State Updates
- Sets `currentPhase` = `CONTEXT`
- Sets `phases.CONTEXT` = `COMPLETED`
- Sets `phases.ANALYZE` = `PENDING`
- Sets `status` = `WAITING_FOR_HUMAN`
- Sets `nextSuggestedPhase` = `ANALYZE`

---

## Human Checkpoint (Blocking Stop)
- Present structured summary:
  ```text
  Modernization context completed.

  Work item: <ID> (<Title>)
  Provider: <provider>
  Modernization unit: <Unit Name> (<Unit Type>)
  Legacy dependencies identified: <N>
  Database dependencies: <N>
  Tests identified: <N>
  Related work items: <N>
  Unverified claims: <N>
  OCR findings: <N> images processed
  Target architecture: <Frontend> + <Backend> + <Pattern> + <Database>

  Next suggested phase: ANALYZE
  ```
- **STOP IMMEDIATELY**. Never automatically execute `devweave-modernization-analyze`.
