# DevWeave Workflow Profiles & Execution Lanes

DevWeave provides **risk-calibrated workflow profiles** and **specialized execution lanes** to optimize token usage, turnaround velocity, and safety governance.

---

## 1. Overview of Execution Lanes

```mermaid
flowchart TD
    subgraph LANES["DevWeave Execution Lanes"]
        direction TB
        L1["<b>Canonical 7-Phase Flow</b><br>Feature, Refactor, Security, Database, High-Risk"]
        L2["<b>V1.1 Modernization Pipeline (8 Phases)</b><br>Init -> Context -> Analyze [G1] -> Plan [G2] -> Branch -> Implement -> Verify [G3] -> PR"]
        L3["<b>Fix Fast Lane</b><br>Triage -> Diagnose -> Land [GATE]"]
        L4["<b>Express Mode</b><br>Low-Risk / Docs / Typos (Unified Flow)"]
    end
```

---

## 2. Canonical 7-Phase User Workflow

The standard pathway for net-new features, complex refactoring, and multi-file architecture changes:

```mermaid
flowchart LR
    P0["0. INIT<br><code>devweave-init</code>"] --> P1["1. CONTEXT<br><code>devweave-context</code>"]
    P1 --> P2["2. ANALYZE<br><code>devweave-analyze</code>"]
    P2 --> P3["3. PLAN<br><code>devweave-plan</code>"]
    P3 --> P4["4. BRANCH<br><code>devweave-branch</code><br><b>[HARD GATE]</b>"]
    P4 --> P5["5. IMPLEMENT<br><code>devweave-implement</code>"]
    P5 --> P6["6. REVIEW<br><code>devweave-pr-review</code><br><b>[HARD GATE]</b>"]
    P6 --> P7["7. PR<br><code>devweave-pr</code><br><b>[HARD GATE]</b>"]
```

### Phase Summary:
1. **`devweave-init`**: 5-layer tech stack detection and knowledge graph synthesis.
2. **`devweave-context <ID>`**: Work item intake, PII/Privacy gating, blast-radius scoping, durable resume detection (`handoff.md`).
3. **`devweave-analyze <ID>`**: Deep architectural exploration, root-cause investigation, and technology revalidation.
4. **`devweave-plan <ID>`**: Precise, verifiable implementation plan with exact file anchors and test criteria.
5. **`devweave-branch <ID>`**: Mandatory branch checkpoint (`feature/<ID>`, `refactor/<ID>`).
6. **`devweave-implement <ID>`**: Surgical code modifications with Test Intelligence and automated test execution.
7. **`devweave-pr-review <ID>`**: Dual-model consensus review (Principal Architect + Senior DBA + Security).
8. **`devweave-pr <ID>`**: Final compliance check, durable domain knowledge promotion, and PR assembly.

---

## 3. Specialized Fast Lanes & Modernization Pipeline

### A. V1.1 Modernization Pipeline (Legacy Monolith Migration)

Tailored for migrating legacy stacks (e.g., monolith to microservices, framework upgrades, language migrations) with zero regressions:

```mermaid
flowchart LR
    M0["0. M-INIT<br><code>devweave-modernization-init</code>"] --> M1["1. M-CONTEXT<br><code>devweave-modernization-context &lt;ID&gt;</code>"]
    M1 --> M2["2. M-ANALYZE<br><code>devweave-modernization-analyze &lt;ID&gt;</code><br><b>[HARD GATE #1]</b>"]
    M2 --> M3["3. M-PLAN<br><code>devweave-modernization-plan &lt;ID&gt;</code><br><b>[HARD GATE #2]</b>"]
    M3 --> M4["4. M-BRANCH<br><code>devweave-modernization-branch &lt;ID&gt;</code>"]
    M4 --> M5["5. M-IMPLEMENT<br><code>devweave-modernization-implement &lt;ID&gt;</code>"]
    M5 --> M6["6. M-VERIFY<br><code>devweave-modernization-verify &lt;ID&gt;</code><br><b>[HARD GATE #3]</b>"]
    M6 --> M7["7. M-PR<br><code>devweave-modernization-pr &lt;ID&gt;</code>"]
```

#### The 3 Mandatory Modernization Hard Gates:
- **Hard Gate #1 (Post-ANALYZE)**: Human signs off on legacy behavioral mapping (`mappings.json`).
- **Hard Gate #2 (Post-PLAN)**: Human signs off on implementation blueprint, test specs, and DB migration scripts.
- **Hard Gate #3 (Post-VERIFY)**: Human signs off on dual verification scorecard and parity checks.

---

### B. Fix Lane (Bug Triage & Rapid Remediation)

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

### C. Express Mode (Low-Risk Fast Track)

For typos, documentation updates, configuration tweaks, or single-line trivial fixes:

```mermaid
flowchart LR
    E1["<code>devweave-express &lt;ID&gt;</code>"] --> E2["Surgical Edit & Test"]
    E2 --> E3["Direct Verification & PR Package"]
```

- **Execution**: Single autonomous command verifying safety thresholds.
- **Safety Guard**: Halts immediately and escalates to the canonical flow if blast radius exceeds 3 files or touches core business logic.

---

## 4. Complete Workflow Profiles Matrix

| Profile | Target Scenario | State Progression | Human Gates | Risk Tier |
|---|---|---|---|---|
| **`EXPRESS`** | Typos, doc fixes, comments, trivial config | `CONTEXT` $\to$ `IMPLEMENT` $\to$ `VERIFY` $\to$ `PR` | Pre-PR | Low |
| **`BUG`** | Production defects, test failures, regressions | `TRIAGE` $\to$ `DIAGNOSE` $\to$ `PLAN` $\to$ `IMPLEMENT` $\to$ `LAND` | Diagnose, Land | Medium |
| **`FEATURE`** | Net-new business capabilities, user stories | `INIT` $\to$ `CONTEXT` $\to$ `ANALYZE` $\to$ `PLAN` $\to$ `BRANCH` $\to$ `IMPLEMENT` $\to$ `REVIEW` $\to$ `PR` | Branch, Review, PR | Medium-High |
| **`REFACTOR`** | Code cleanup, performance tuning, architecture decoupling | `CONTEXT` $\to$ `BASELINE_TEST` $\to$ `ANALYZE` $\to$ `PLAN` $\to$ `BRANCH` $\to$ `IMPLEMENT` $\to$ `REVIEW` $\to$ `PR` | Branch, Review, PR | Medium-High |
| **`MODERNIZATION`** | Framework migrations, runtime upgrades, monolith extraction | `M-INIT` $\to$ `M-CONTEXT` $\to$ `M-ANALYZE` $\to$ `M-PLAN` $\to$ `M-BRANCH` $\to$ `M-IMPLEMENT` $\to$ `M-VERIFY` $\to$ `M-PR` | Analyze (G1), Plan (G2), Verify (G3) | High |
| **`SECURITY`** | CVE remediation, auth/authz fixes, crypto upgrades | `CONTEXT` $\to$ `THREAT_MODEL` $\to$ `PLAN` $\to$ `BRANCH` $\to$ `IMPLEMENT` $\to$ `SEC_SCAN` $\to$ `REVIEW` $\to$ `PR` | Threat Model, Plan, Review, PR | Critical |
| **`DATABASE`** | Schema migrations, index tuning, ORM updates | `CONTEXT` $\to$ `SCHEMA_INSPECT` $\to$ `MIGRATION_PLAN` $\to$ `DRY_RUN` $\to$ `IMPLEMENT` $\to$ `REVIEW` $\to$ `PR` | Migration Plan, Dry Run, Review, PR | High |
| **`HIGH_RISK`** | Core financial logic, PII pipelines, kernel modules | `CONTEXT` $\to$ `DEEP_DISCOVERY` $\to$ `MULTI_PLAN` $\to$ `PANEL_APPROVAL` $\to$ `IMPLEMENT` $\to$ `REVIEW` $\to$ `PR` | All Phases Mandatory | Critical |

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
