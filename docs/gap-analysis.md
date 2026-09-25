# DevWeave Canonical Lifecycle Alignment & Gap Analysis

## 1. Executive Summary
This document provides the formal architectural inspection and gap analysis comparing **Normal Development** (`DEVELOPMENT`) and **Modernization** (`MODERNIZATION`) workflows against DevWeave's canonical AI-DLC framework.

### Guiding Principles:
1. **Unified AI-DLC Core**: Modernization is not a second independent framework; it is a specialized workflow profile running on top of shared state, Git, graph, provider, policy, and artifact infrastructure.
2. **Mandatory Base Initialization (`devweave-init`)**: All normal development commands and `devweave-modernization-init` strictly require completed base repository initialization.
3. **Deterministic Progression & Gates**: Every phase depends on the previous phase's approved deliverables.

---

## 2. Canonical Dual-Workflow Architecture

```text
                               DEVWEAVE CORE
                                     |
                +--------------------+--------------------+
                |                                         |
     AI-DLC Core Engine                            Policy & Governance
     (State, Git, Graph, Artifacts)               (Gates, Privacy, Audits)
                |                                         |
                +--------------------+--------------------+
                                     |
                             Workflow Profiles
                                /          \
                               /            \
        DEVELOPMENT PROFILE                      MODERNIZATION PROFILE
                 |                                         |
         devweave-init                             devweave-init (Prerequisite)
                 |                                         |
        devweave-context <ID>                     devweave-modernization-init
                 |                                         |
        devweave-analyze <ID>                     devweave-modernization-context <ID>
                 |                                         |
        devweave-plan <ID>                        devweave-modernization-analyze <ID> [Gate #1]
                 |                                         |
        devweave-branch <ID> [Gate]               devweave-modernization-plan <ID> [Gate #2]
                 |                                         |
        devweave-implement <ID>                   devweave-modernization-branch <ID>
                 |                                         |
        devweave-pr-review <ID> [Gate]            devweave-modernization-implement <ID>
                 |                                         |
        devweave-pr <ID>                          devweave-modernization-verify <ID> [Gate #3]
                                                           |
                                                  devweave-modernization-pr <ID>
```

---

## 3. Comprehensive Capability Gap Matrix

| Capability / Requirement | Normal Existing | Normal Partial | Modernization Existing | Modernization Partial | Missing | Reconciliation Action |
|---|:---:|:---:|:---:|:---:|:---:|---|
| **Base Init (`devweave-init`)** | **Yes** | | | | | Preserved; enforced as mandatory prerequisite before all work-item and modernization phases. |
| **Modernization Init (`devweave-modernization-init`)** | | | **Yes** | | Base-init prerequisite check | Add explicit blocking prerequisite check requiring `devweave-init` before `devweave-modernization-init`. |
| **Init Prerequisite Gates** | | **Partial** | | **Partial** | Strict CLI blocking gate message | Enforce exact error message: *"DevWeave has not been initialized for this repository. Run: devweave-init before continuing."* |
| **Context Acquisition** | **Yes** | | **Yes** | | | Connect shared `WorkItemProvider` (Jira, ADO, GitHub, Custom), attachment extraction, image OCR, and privacy gate. |
| **Work-Item Provider Infrastructure** | **Yes** | | **Yes** | | | Shared provider adapters without vendor lock-in. |
| **Setup & Authentication (`devweave-setup`)** | **Yes** | | **Yes** | | | Central tool detection and OS credential verification with zero secret storage. |
| **State Machine & Resume** | **Yes** | **Partial** | **Yes** | **Partial** | Unified resume validation against Git & artifacts | Unified state machine supporting `workflow: DEVELOPMENT` and `workflow: MODERNIZATION`. Validate Git branch & artifacts on resume. |
| **Branch Validation on Resume** | | **Partial** | | **Partial** | Branch mismatch prompt | Prompt developer to switch branch if expected branch != current Git branch. |
| **Deep Impact Analysis** | **Yes** | **Partial** | **Yes** | **Partial** | 11-dimension impact analysis & edge cases | Align normal `devweave-analyze` across Repo, Code, API, UI, Data, Messaging, Tests, Config, Security, Ops, Deployment. |
| **Dependency Traversal** | **Yes** | | **Yes** | | | Shared graph traversal (< 32k tokens for normal, < 12k tokens for modernization slices). |
| **Implementation Planning** | **Yes** | | **Yes** | | | Normal plan traces to requirements & analysis (`PLAN -> ANALYSIS -> REQUIREMENT`); Modernization plan maps source-to-target relationships. |
| **Downstream Artifact Staleness** | | **Partial** | | **Partial** | Explicit staleness invalidation | Mark downstream artifacts `STALE` if predecessor context/analysis changes materially. |
| **Isolated Branch Creation** | **Yes** | | **Yes** | | | Shared Git branch creator with interactive `--name` and `--base` selection. |
| **Pattern vs Best Practice Selection** | | **Partial** | | **Partial** | Interactive decision prompt | Prompt developer if existing repository pattern conflicts with target technology best practice. |
| **Plan-Bound Implementation** | **Yes** | | **Yes** | | Plan deviation detector | Enforce plan boundaries; prompt developer if unexpected scope deviation is discovered during implementation. |
| **Dual-Model PR Review** | **Yes** | | | | | Keep independent Technical Architect (Reviewer A) + Senior DBA (Reviewer B) review with consolidated `review.md`. |
| **Modernization Parity Verification** | | | **Yes** | | Mapping completeness check | Verify functional, API, UI, data, business rule preservation, and verify no source component is silently omitted from map. |
| **Critical Findings Remediation Gate** | **Yes** | | **Yes** | | | Require `CRITICAL = 0` and blocking `ERROR = 0` before PR creation is permitted. |
| **PR Assembly & Knowledge Merge** | **Yes** | | **Yes** | | | Generate PR package from existing verified artifacts without full rediscovery; merge graph deltas into knowledge graph. |
| **Modernization Status & Reporting** | | | **Yes** | | | Non-mutating status display and comprehensive end-to-end report. |
| **Shared Knowledge Graph** | **Yes** | | **Yes** | | | Single JSON knowledge graph (`knowledge-graph.json`) with incremental `graph-delta.json` merging. |
| **User-Only Story Audit Trail** | **Yes** | | **Yes** | | | Append-only `audit.md` capturing exclusively human actions, prompts, and gate approvals with author attribution. |
