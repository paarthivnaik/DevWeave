# DevWeave Specification: Generic Work Item Context Acquisition & Setup

## 1. Executive Summary

DevWeave V1.2.0 introduces the **Generic Work Item Context Acquisition & Setup** capability. This subsystem decouples the DevWeave AI-DLC lifecycle from any single project-management (PM) tool (e.g., Jira, Azure DevOps, GitHub, Linear, or custom issue trackers), CLI wrapper, or AI vendor, while incorporating deep work-item analysis, safe attachment text extraction, image Optical Character Recognition (OCR), linked/historical work discovery, candidate claims modeling, and bounded migration slicing.

---

## 2. Core Architecture

```text
                    DevWeave
                       |
              Work Item Context
                       |
              WorkItemProvider
                       |
       +---------------+---------------+
       |               |               |
      Jira       Azure DevOps       GitHub
       |               |               |
     CLI/API          CLI/API         CLI/API
                       |
                 Secure Auth (Zero Secret Leakage)
                       |
                Work Item Data
                       |
       +---------------+---------------+
       |               |               |
   Comments       Attachments       Links
       |               |               |
       |          Text / OCR           |
       +---------------+---------------+
                       |
                 Evidence / Claims
                       |
              Legacy Repository Intelligence
                       |
                Knowledge Graph (Deltas)
                       |
              Migration Slice
                       |
             Unified Context (context.md)
                       |
            HUMAN CHECKPOINT (Blocking)
                       |
                    ANALYZE
```

---

## 3. Work Item Context Acquisition Pipeline

The primary command for ingesting work-item context into a modernization story is:
```bash
devweave-modernization-context <ID>
```

### 3.1 Step-by-Step Acquisition Flow

1. **Provider Identification & Selection**:
   - Check if the project management provider is configured in `.devweave/modernization/workspace.json` (or `.devweave/workspace.json`).
   - If not configured, interactively prompt the developer:
     ```text
     Which project-management system contains this work item?
     1. Azure DevOps
     2. Jira
     3. GitHub
     4. Other / Custom
     ```
   - Persist non-secret provider metadata in workspace configuration.

2. **Client / CLI Detection**:
   - Query `ProviderAdapter.detectClient()` (e.g., `az`, `jira` / `acli`, `gh`, custom CLI).
   - If missing:
     ```text
     Required client for <provider> is not installed.
     Run:
     devweave-setup
     ```
     **STOP IMMEDIATELY**. Do not attempt unmanaged installation during context acquisition.

3. **Secure Authentication Verification**:
   - Verify active session / token / credential via `ProviderAdapter.authenticationStatus()`.
   - If unauthenticated, guide the developer through the provider's native secure authentication mechanism.
   - **Zero Secret Rule**: Tokens, keys, or credentials MUST NEVER be written to `.devweave/`, Git history, logs, markdown artifacts, JSON state, knowledge graph, or AI prompts.

4. **Generic Privacy & Data-Processing Hard Gate**:
   - Before retrieving remote work-item data, comments, attachments, or dispatching to AI processing, enforce the generic privacy gate:
     ```text
     This operation will retrieve work-item information, comments,
     attachments, and related content for modernization analysis.

     Proceed? [Approve] [Reject]
     ```
   - If rejected, halt execution immediately without issuing remote requests.

5. **Complete Work Item Acquisition & Normalization**:
   - Ingest ID, Title, Description, Type, Status, Priority, Assignee, Reporter, Labels, Iteration, Timestamps, Acceptance Criteria, and Provider Metadata.
   - Store normalized representation in `.devweave/modernization/stories/<ID>/work-item.json` matching `work-item.schema.json`.

6. **Comments Retrieval & Attribution**:
   - Ingest discussion comments with clear author attribution and timestamp.
   - Preserve comments as contextual evidence; comments do NOT automatically become authoritative codebase facts.

7. **Attachment Classification & Text Extraction**:
   - Categorize attachments into `TEXT`, `DOCUMENT`, `IMAGE`, `ARCHIVE`, or `OTHER`.
   - For text-readable formats (`.txt`, `.md`, `.json`, `.csv`, `.xml`, `.yaml`, `.log`), safely download to controlled temporary storage, extract content, and validate against path traversal.
   - Link extracted text into `work-item.json` and `.devweave/modernization/stories/<ID>/evidence/`.

8. **Image Processing & OCR Pipeline**:
   - For image attachments (`.png`, `.jpg`, `.jpeg`, `.bmp`, `.tiff`, `.webp`), process using available OCR capabilities (e.g., Tesseract OCR, system vision services, or lightweight image models).
   - Assign quality assessment: `SUCCESS`, `PARTIAL`, or `FAILED` with confidence score.
   - **Non-Blocking Invariance**: OCR failures or unavailable OCR engines MUST NOT block context completion.
   - **Anti-Hallucination Invariance**: Never invent, guess, or extrapolate unreadable visual text.

9. **Linked Work Items & Historical Work Discovery**:
   - Fetch direct work-item links (`blocks`, `depends-on`, `relates-to`, `child-of`, `parent-of`, `migrated-from`).
   - Query provider search/indexing for prior art (similar modernization tickets, related bugs, previous migration slices) to provide historical context.

10. **Candidate Claims & Evidence Extraction**:
    - Identify candidate statements requiring verification (e.g., *"Customer page uses stored procedure X"*).
    - Classify claim verification statuses: `UNVERIFIED`, `VERIFIED`, `CONTRADICTED`, `PARTIALLY_VERIFIED`, `UNKNOWN`.
    - Persist in `.devweave/modernization/stories/<ID>/evidence.json`. Unverified claims MUST NOT be treated as architectural truth during downstream implementation.

11. **Legacy Repository Intelligence Integration**:
    - Query legacy repository intelligence (`source-memory.json` in `READ_ONLY` mode) across UI, Controllers, Services, Business Rules, Models, Database objects, and Tests.
    - Token Budgeting: Enforce bounded context loading (< 12,000 tokens) rather than dumping full legacy repositories into AI memory.

12. **Bounded Migration Slice Construction**:
    - Identify modernization unit: `PAGE`, `SCREEN`, `FEATURE`, `MODULE`, `SERVICE`, `DOMAIN`, `WORKFLOW`, `API`, `TRANSACTION`, `COMPONENT`, `CAPABILITY`, or `CUSTOM`.
    - Trace explicit legacy dependencies (Views → Controllers → Services → Database → Tests) and persist `.devweave/modernization/stories/<ID>/migration-slice.json`.

13. **Target Architecture Intent Integration**:
    - Incorporate declared target architecture (e.g., Angular + CQRS Microservices + MySQL) from `.devweave/modernization/architecture-intent.json`.
    - Mark user-declared facts as `source = USER_DECLARED` and unobserved elements as `UNKNOWN` / `AI_DETERMINED`.

14. **Unified Context Synthesis (`context.md`)**:
    - Compile human-readable and AI-optimized `context.md` following canonical section headers.

15. **Incremental Knowledge Graph Integration**:
    - Emit graph deltas (`graph-delta.json`) recording `WORK_ITEM`, `MIGRATED_TO`, `AFFECTS`, `REFERENCES`, and `HAS_ATTACHMENT` relationships without full-graph recalculation.

16. **State & User-Only Audit Logging**:
    - Update `.devweave/modernization/stories/<ID>/state.json` setting `phase = CONTEXT`, `status = WAITING_FOR_HUMAN`, `nextSuggestedPhase = ANALYZE`.
    - Append exclusively human activity to `.devweave/modernization/stories/<ID>/audit.md` with `Author: <User Name> <email@example.com>`.

17. **Human Checkpoint (Blocking Stop Rule)**:
    - Present summary of discovered dependencies, database objects, tests, claims, and OCR findings.
    - Prompt developer for decision: `APPROVE`, `REQUEST_CHANGES`, `PROVIDE_INFORMATION`, `REJECT`, `STOP`.
    - **STOP IMMEDIATELY**. Never auto-advance to `ANALYZE`.

---

## 4. Artifact Structure

```text
.devweave/
├── modernization/
│   ├── workspace.json                  <-- Non-secret provider settings & workspace configuration
│   ├── architecture-intent.json        <-- Target architecture declarations
│   ├── source-memory.json              <-- Read-only legacy repository references
│   └── stories/<ID>/
│       ├── work-item.json              <-- Normalized work-item data & attachments metadata
│       ├── evidence.json               <-- Extracted claims & evidence verification status
│       ├── migration-unit.json         <-- Target modernization unit definition
│       ├── migration-slice.json        <-- Bounded dependency graph slice
│       ├── context.md                  <-- Unified Markdown context
│       ├── state.json                  <-- Lifecycle phase & gate state tracker
│       ├── audit.md                    <-- Append-only human activity audit trail
│       └── evidence/                   <-- Extracted attachment text & OCR logs (local/temp)
```

---

## 5. Token Efficiency & Security Guarantees

1. **Focused Retrieval**: Follow strict hierarchy: exact lookup → graph traversal → file/path lookup → keyword search → semantic retrieval → LLM reasoning.
2. **Zero Secret Storage**: No credentials in workspace files, state files, or prompts.
3. **Path Traversal Protection**: All attachment downloads sanitized to prevent directory breakout (`../`).
4. **Attribution Preservation**: All comments and claims strictly retain author and source type metadata.
