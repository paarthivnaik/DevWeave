# DevWeave Domain Knowledge Specification

**Version**: 1.4.0  
**Status**: Canonical Product Specification  
**Subsystem**: Domain Knowledge Intelligence Layer (Superpower 24)

---

## 1. Executive Overview

Domain Knowledge is a first-class semantic and business understanding layer in DevWeave. It answers **"What does this software system mean to the business/domain?"** by capturing concepts, business rules, processes, capabilities, terminology, domain events, and constraints with evidence-backed provenance.

### Three Complementary Knowledge Layers:
| Layer | Answers | Role |
| :--- | :--- | :--- |
| **Knowledge Graph** | **What exists and how is it structurally connected?** | Navigation/structural index over repository entities and relationships. |
| **Domain Knowledge** | **What does it mean to the business/system?** | Semantic layer containing concepts, terminology, business rules, capabilities, processes, constraints, and mappings to repository entities. |
| **Engineering Intelligence** | **How should we build/change it?** | Organization/project/repository/technology practices, standards, policies, exceptions, and implementation guidance. |

---

## 2. Context vs. Analyze Responsibility Boundary

A core invariant of the DevWeave lifecycle is the strict boundary between context acquisition and domain analysis:

```text
devweave-context <ID>
        │
        │ Acquire work item, comments, attachments, OCR, candidate claims (evidence.json)
        │ Context establishes WHAT is requested. No deep repository/domain traversal.
        ▼
context.md / work-item.json / evidence.json
        │
        ▼
devweave-analyze <ID>  <--- Domain Knowledge joins here!
        │
        │ 1. Read context.md from disk
        │ 2. Candidate Domain Resolution
        │ 3. Domain Knowledge Retrieval (concepts, rules, mappings)
        │ 4. Knowledge Graph Traversal (guided by domain entities)
        │ 5. Engineering Intelligence Resolution (<1,500 tokens)
        │ 6. Targeted Repository Source Verification
        │ 7. Impact Analysis & Evidence Reconciliation
        ▼
analysis.md
```

---

## 3. Domain Knowledge Entity Lifecycle & Statuses

Every domain entity retains provenance, analyzed commit, confidence, and one of the canonical statuses:
- **`OBSERVED`**: Fact directly evidenced by static source code, schemas, or tests.
- **`DERIVED`**: Fact inferred from structural analysis and verified by code patterns.
- **`AI_INFERRED`**: Synthesized by AI reasoning, awaiting static verification or human confirmation.
- **`HUMAN_CONFIRMED`**: Explicitly approved or authored by a human developer.
- **`CONFLICTING`**: Incompatible statements across stories or commits (`KNOWLEDGE_CONFLICT`).
- **`UNKNOWN`**: Unobserved entity in partial/new repositories (zero fact fabrication).
- **`NEEDS_REVALIDATION`**: Evidence source files were modified, requiring targeted re-analysis.

---

## 4. Concurrency & Story Deltas

To prevent merge conflicts across 70 concurrent developers:
1. Story implementation writes additions and modifications exclusively to `.devweave/work-items/<ID>/domain-delta.json`.
2. During the PR phase (`devweave-pr` / `devweave-modernization-pr`), deltas are deterministically merged into `.devweave/domain/knowledge.json`.
3. Contradictory statements create an explicit `KNOWLEDGE_CONFLICT` requiring developer resolution.

---

## 5. Modernization Invariants

In modernization workflows:
- Legacy domain knowledge remains strictly **`READ_ONLY`**.
- Transformation mappings (`MIGRATED_TO`, `TRANSFORMED_TO`, `SPLIT_INTO`, `RETIRED`) bridge legacy concepts to target domain models.
