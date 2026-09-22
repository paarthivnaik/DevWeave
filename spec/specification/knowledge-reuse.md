# DevWeave Knowledge Reuse Specification

Knowledge reuse is the foundational mechanism powering DevWeave's core value proposition: **"Less Tokens. More Work. Lower Bill."**

---

## 1. The Knowledge Accumulation & Reuse Loop

Instead of burning tokens rediscovering repository patterns and domain constraints on every user prompt, DevWeave maintains a continuous learning and reuse loop:

```text
       Work Item 001 (e.g. Feature)
                   │
                   ▼
         Discovery & Diagnostic
                   │
                   ▼
       Business / Tech Rule Extracted
                   │
                   ▼
            Evidence Collected
                   │
                   ▼
         Verification & Approval
                   │
                   ▼
    Persisted to .devweave/knowledge/
                   │
                   ├───────────────────────────────────┐
                   │                                   │
                   ▼                                   ▼
       Work Item 002 (e.g. Bugfix)         Work Item 003 (e.g. Refactor)
                   │                                   │
                   ▼                                   ▼
    Relevant Knowledge Loaded Instantly   Relevant Knowledge Loaded Instantly
         (0 Discovery Tokens)                (0 Discovery Tokens)
```

---

## 2. Invalidation & Maintenance

1. **Deterministic Stale Checking**: When files cited in a knowledge item's `evidence` field are modified, the knowledge item's status transitions from `APPROVED` to `INFERRED` or `NEEDS_REVALIDATION`.
2. **Automated Verification**: During subsequent testing or CI runs, verification tasks re-check cited evidence and re-promote valid items to `APPROVED`.
3. **Deprecation**: Supervised removal or marking as `DEPRECATED` when architecture migrations make older patterns obsolete.
