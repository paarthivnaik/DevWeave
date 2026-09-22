# DevWeave Workflow Profiles Specification

Workflow Profiles define calibrated execution routes through the AI-DLC state machine, optimizing token expenditure and latency while matching task risk and complexity.

---

## 1. Supported Profiles

1. **`EXPRESS`**: For minor fixes, trivial typos, small documentation updates, or single-line config changes.
2. **`BUG`**: For defect diagnosis, root cause isolation, regression test creation, and targeted bug fixes.
3. **`FEATURE`**: For end-to-end user stories, net-new feature additions, and API expansions.
4. **`REFACTOR`**: For non-behavior-modifying structural improvements, cleanups, and technical debt elimination.
5. **`MODERNIZATION`**: For dependency updates, framework upgrades, language version migrations, and deprecation cleanups.
6. **`SECURITY`**: For vulnerability remediations, security patching, secrets auditing, and hardening.
7. **`DATABASE`**: For schema migrations, entity changes, index additions, and query optimizations.
8. **`HIGH_RISK`**: For core architecture refactoring, financial/auth/crypto modifications, and high-impact changes.

---

## 2. Profile Execution Graphs

### 2.1 EXPRESS
Fast-path execution bypassing heavy formal discovery and multi-agent reviews:
```text
Context Assembly
      │
      ▼
Implementation
      │
      ▼
Testing & Verification
      │
      ▼
PR Ready
```

### 2.2 BUG
Root-cause driven execution ensuring reproduction and regression testing:
```text
Targeted Discovery & Diagnostic
      │
      ▼
Bug Reproduction & Analysis
      │
      ▼
Fix Plan & Solution
      │
      ▼
Implementation
      │
      ▼
Regression Testing & Verification
      │
      ▼
Code Review
      │
      ▼
PR Ready
```

### 2.3 FEATURE
Canonical comprehensive lifecycle:
```text
Discovery
      │
      ▼
Requirements Definition
      │
      ▼
Solution Architecture
      │
      ▼
Approval Gate
      │
      ▼
Actionable Plan
      │
      ▼
Implementation
      │
      ▼
Automated Testing
      │
      ▼
Deterministic Verification
      │
      ▼
Multi-Perspective Review
      │
      ▼
PR Ready
```

### 2.4 REFACTOR
Ensures baseline test preservation and strict behavioral invariance:
```text
Baseline Test Verification
      │
      ▼
Structural Refactor Plan
      │
      ▼
Incremental Implementation
      │
      ▼
Regression Test Suite
      │
      ▼
Verification & Invariance Review
      │
      ▼
PR Ready
```

### 2.5 HIGH_RISK
Deep discovery, multi-tier security analysis, explicit sign-off gates, and independent multi-agent reviews:
```text
Deep Discovery & Blast-Radius Analysis
      │
      ▼
Rigorous Requirements & Threat Model
      │
      ▼
Architecture & Security Solution
      │
      ▼
Mandatory Human/Policy Approval Gate
      │
      ▼
Staged Execution Plan
      │
      ▼
Implementation
      │
      ▼
Comprehensive Test Suite (Unit + Integration + Chaos)
      │
      ▼
Static & Dynamic Security Verification
      │
      ▼
Multi-Agent Specialist Review (Security, Architecture, Performance)
      │
      ▼
Final PR Ready Gate
```

---

## 3. Profile Selection Matrix

| Profile | Discovery Depth | Requirements Required | Approval Gate | Multi-Agent Review | Minimum Verification |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `EXPRESS` | Minimal / Cached | Optional | No | Single Turn | Lint + Unit Test |
| `BUG` | Targeted | Informal / Repro | Auto/Policy | Yes | Regression Test + Lint |
| `FEATURE` | Standard | Required | Yes | Yes | Full Build + Test + Lint |
| `REFACTOR` | Architectural | Test Invariance | Yes | Yes | Full Regression Suite |
| `MODERNIZATION` | Dependency Tree | Compatibility | Yes | Yes | Build + Integration Suite |
| `SECURITY` | Threat/Vulnerability | Security Constraints | Mandatory | Specialist Review | Security Scan + Full Test |
| `DATABASE` | Schema/Data Graph | Migration Specs | Mandatory | Specialist Review | Migration Rollback + Tests |
| `HIGH_RISK` | Comprehensive Blast-Radius | Comprehensive Spec | Mandatory Human Gate | Multi-Perspective Panel | Full Static + Dynamic + Pen Tests |
