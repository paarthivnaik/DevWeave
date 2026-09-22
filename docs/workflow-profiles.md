# DevWeave Workflow Profiles & Execution Lanes

DevWeave provides **risk-calibrated workflow profiles** and **specialized execution lanes** to optimize token usage, turnaround velocity, and safety governance.

---

## 1. Overview of Execution Lanes

```mermaid
flowchart TD
    subgraph LANES["DevWeave Execution Lanes"]
        direction TB
        L1["<b>Canonical 6-Phase Flow</b><br>Feature, Refactor, Security, Database, High-Risk"]
        L2["<b>Fix Fast Lane</b><br>Triage -> Diagnose -> Land"]
        L3["<b>Modernization Lane</b><br>Analyze -> Plan (Migration Manifest) -> Implement -> Verify"]
        L4["<b>Express Mode</b><br>Low-Risk / Docs / Typos (Unified Flow)"]
    end
```

---

## 2. Canonical 6-Phase User Workflow

The standard pathway for net-new features, complex refactoring, and multi-file architecture changes:

```mermaid
flowchart LR
    P1["1. CONTEXT<br><code>devweave-context</code>"] --> P2["2. ANALYZE<br><code>devweave-analyze</code>"]
    P2 --> P3["3. PLAN<br><code>devweave-plan</code>"]
    P3 --> P4["4. BRANCH<br><code>devweave-branch</code><br><b>[HARD GATE]</b>"]
    P4 --> P5["5. IMPLEMENT<br><code>devweave-implement</code>"]
    P5 --> P6["6. PR<br><code>devweave-pr</code><br><b>[HARD GATE]</b>"]
```

### Phase Summary:
1. **`devweave-context <ID>`**: Work item intake, PII/Privacy gating, blast-radius scoping, durable resume detection (`handoff.md`).
2. **`devweave-analyze <ID>`**: Deep architectural exploration, root-cause investigation, and technology revalidation.
3. **`devweave-plan <ID>`**: Precise, verifiable implementation plan with exact file anchors and test criteria.
4. **`devweave-branch <ID>`**: Mandatory branch checkpoint (`feature/<ID>`, `refactor/<ID>`).
5. **`devweave-implement <ID>`**: Surgical code modifications and automated test verification.
6. **`devweave-pr <ID>`**: Final compliance check, multi-perspective code review, durable domain knowledge promotion, and PR assembly.

---

## 3. Specialized Fast Lanes

### A. Fix Lane (Bug Triage & Rapid Remediation)

Designed for accelerated bug fixes with deterministic root-cause diagnosis:

```mermaid
flowchart LR
    F1["1. TRIAGE<br><code>devweave-fix-triage &lt;ID&gt;</code>"] --> F2["2. DIAGNOSE<br><code>devweave-fix-diagnose &lt;ID&gt;</code>"]
    F2 --> F3["3. LAND<br><code>devweave-fix-land &lt;ID&gt;</code><br><b>[HARD GATE]</b>"]
```

| Skill | Role & Output | Checkpoint Gate |
|---|---|---|
| `devweave-fix-triage` | Ingests error logs, stack traces, reproduction steps, and assigns severity (`P0` to `P3`). | Human reviews severity and reproduction viability. |
| `devweave-fix-diagnose` | Pinpoints offending source code, captures root cause, and generates targeted fix plan. | Human approves root-cause diagnosis and proposed fix. |
| `devweave-fix-land` | Creates `fix/<ID>` branch, implements patch, executes regression tests, verifies fix, and generates PR package. | Hard approval required before opening PR. |

---

### B. Modernization Lane (Legacy Migration & Upgrades)

Tailored for migrating legacy stacks (e.g., monolith to microservices, framework upgrades, language migrations):

```mermaid
flowchart TD
    M1["1. Migration Scope & Context<br><code>devweave-context &lt;ID&gt;</code>"] --> M2["2. Legacy Source & Target Architecture Analysis<br><code>devweave-analyze &lt;ID&gt;</code>"]
    M2 --> M3["3. Migration Manifest Planning<br><code>devweave-modernize &lt;ID&gt;</code><br><i>Generates migration_manifest.md</i>"]
    M3 --> M4["4. Isolated Branch Creation<br><code>devweave-branch &lt;ID&gt;</code><br><b>[HARD GATE]</b>"]
    M4 --> M5["5. Incremental Modernization Implementation<br><code>devweave-implement &lt;ID&gt;</code>"]
    M5 --> M6["6. Parity Verification & PR<br><code>devweave-pr &lt;ID&gt;</code><br><b>[HARD GATE]</b>"]
```

#### Key Modernization Artifact: `migration_manifest.md`
Contains:
- Source component contract & legacy behavior definition.
- Target component architecture & pattern alignment.
- API & schema translation mapping.
- Feature parity verification matrix.
- Rollback & coexistence strategy.

---

### C. Express Mode (Low-Risk Fast Track)

For typos, documentation updates, configuration tweaks, or single-line trivial fixes:

```mermaid
flowchart LR
    E1["<code>devweave-express &lt;ID&gt;</code>"] --> E2["Surgical Edit & Test"]
    E2 --> E3["Direct Verification & PR Package"]
```

- **Execution**: Single autonomous command verifying safety thresholds.
- **Safety Guard**: Halts immediately and escalates to the canonical 6-phase flow if blast radius exceeds 3 files or touches core business logic.

---

## 4. Complete Workflow Profiles Matrix

| Profile | Target Scenario | State Progression | Human Gates | Risk Tier |
|---|---|---|---|---|
| **`EXPRESS`** | Typos, doc fixes, comments, trivial config | `CONTEXT` $\to$ `IMPLEMENT` $\to$ `VERIFY` $\to$ `PR` | Pre-PR | Low |
| **`BUG`** | Production defects, test failures, regressions | `TRIAGE` $\to$ `DIAGNOSE` $\to$ `PLAN` $\to$ `IMPLEMENT` $\to$ `LAND` | Diagnose, Land | Medium |
| **`FEATURE`** | Net-new business capabilities, user stories | `CONTEXT` $\to$ `ANALYZE` $\to$ `PLAN` $\to$ `BRANCH` $\to$ `IMPLEMENT` $\to$ `PR` | Context, Analyze, Plan, Branch, PR | Medium-High |
| **`REFACTOR`** | Code cleanup, performance tuning, architecture decoupling | `CONTEXT` $\to$ `BASELINE_TEST` $\to$ `ANALYZE` $\to$ `PLAN` $\to$ `IMPLEMENT` $\to$ `VERIFY` $\to$ `PR` | Plan, Branch, PR | Medium-High |
| **`MODERNIZATION`** | Framework migrations, runtime upgrades, monolith extraction | `CONTEXT` $\to$ `ANALYZE` $\to$ `MODERNIZE_MANIFEST` $\to$ `BRANCH` $\to$ `IMPLEMENT` $\to$ `PR` | Analysis, Manifest, Branch, PR | High |
| **`SECURITY`** | CVE remediation, auth/authz fixes, crypto upgrades | `CONTEXT` $\to$ `THREAT_MODEL` $\to$ `PLAN` $\to$ `BRANCH` $\to$ `IMPLEMENT` $\to$ `SEC_SCAN` $\to$ `PR` | Threat Model, Plan, PR | Critical |
| **`DATABASE`** | Schema migrations, index tuning, ORM updates | `CONTEXT` $\to$ `SCHEMA_INSPECT` $\to$ `MIGRATION_PLAN` $\to$ `DRY_RUN` $\to$ `IMPLEMENT` $\to$ `PR` | Migration Plan, Dry Run, PR | High |
| **`HIGH_RISK`** | Core financial logic, PII pipelines, kernel modules | `CONTEXT` $\to$ `DEEP_DISCOVERY` $\to$ `MULTI_PLAN` $\to$ `PANEL_APPROVAL` $\to$ `IMPLEMENT` $\to$ `PR` | All Phases Mandatory | Critical |

---

## 5. Dynamic Technology Revalidation in Profiles

When any profile executes, DevWeave continuously validates that repository technology practices match active framework versions:

```mermaid
stateDiagram-v2
    [*] --> CheckVersion: Analyze / Plan Phase
    CheckVersion --> Active: Version Unchanged
    CheckVersion --> Invalidate: Version Updated (e.g., .NET 8 -> .NET 9)
    Invalidate --> NeedsRevalidation: Mark Affected Domain Practices
    NeedsRevalidation --> Revalidate: Trigger Targeted Practice Refresh
    Revalidate --> Active: Update .devweave/domains/
    Active --> [*]
```

- **`NEEDS_REVALIDATION` Flag**: Applied to domain practices when major/minor framework updates occur.
- **Context Refresh (`--refresh`)**: Invalidates stale work-item state if underlying codebase or PM tickets change mid-stream.
