# DevWeave Generic Work Item Context Acquisition & Evidence Modeling

## Overview
DevWeave V1.2.0 introduces the **Generic Work Item Context Acquisition & Setup** subsystem. It connects DevWeave to external project-management systems (Azure DevOps, Jira, GitHub, Custom) via vendor-neutral provider adapters, ingesting rich story details, discussions, attachments, OCR visual text, linked items, and historical work without hardcoding dependencies or storing credentials.

---

## Key Capabilities

### 1. Vendor-Neutral Provider Adapters
- **Azure DevOps (`azure-devops`)**: Seamlessly interfaces with Azure Boards work items, parent/child links, and WIQL queries via `az boards` CLI / REST API.
- **Atlassian Jira (`jira`)**: Interacts with Jira Cloud / Server via `jira-cli`, `acli`, or REST API.
- **GitHub Issues & Projects (`github`)**: Bridges GitHub Issues and Projects v2 via `gh` CLI and GraphQL.
- **Custom / Offline (`custom`)**: Enables manual markdown templates and custom REST connectors.

### 2. Mandatory Setup Routing (`devweave-setup`)
When a required CLI client is missing, DevWeave directs the developer to run `devweave-setup` and stops execution. It never executes unmanaged installations silently.

### 3. Generic Privacy & Data-Processing Gate
Before dispatching work items, comments, or attachments to remote services or AI processing, a privacy gate requests explicit developer confirmation.

### 4. Zero Secret Storage Invariance
No passwords, PATs, or tokens are ever stored in `.devweave/`, Git history, or AI prompts. Authentication relies on OS credential managers (Windows Credential Manager, macOS Keychain, Linux Secret Service).

### 5. Safe Text & Image OCR Pipeline
- Text attachments are sanitized to prevent directory traversal attacks (`../`).
- Image mockups and diagrams are processed via OCR with quality confidence scoring (`SUCCESS`, `PARTIAL`, `FAILED`).
- OCR failure is non-blocking and the system never hallucinates unreadable text.

### 6. Candidate Claims & Verification Modeling
Statements made in user stories, attachments, or comments are initialized as `UNVERIFIED` in `evidence.json`. They must be verified by codebase AST inspection or schema validation before implementation tasks are constructed.

### 7. Bounded Migration Slicing
Instead of dumping full legacy repositories into AI memory, DevWeave constructs focused, bounded dependency graph slices (`migration-slice.json`) with strict token budgeting (< 12,000 tokens).

### 8. Blocking Human Checkpoint
The context phase concludes with a structured summary and stops immediately. Silence is never approval.
