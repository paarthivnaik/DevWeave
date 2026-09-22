# DevWeave Model Capability Model Specification

DevWeave decouples the AI-DLC lifecycle from proprietary vendor model names (e.g. `gpt-4o`, `claude-3-5-sonnet`, `gemini-1.5-pro`) by defining abstract **Model Capabilities**.

---

## 1. Capability Taxonomy

DevWeave defines the following abstract capabilities:

| Capability | Description | Characteristics | Reference Host Mapping (Antigravity) |
| :--- | :--- | :--- | :--- |
| `fast-analysis` | High-throughput, low-latency scanning and filtering. | Ultra-low cost, fast token output, concise reasoning. | `flash_lite` |
| `reasoning` | General-purpose architectural and planning reasoning. | Strong logical synthesis, structured output adherence. | `flash` / `pro` |
| `deep-reasoning` | Complex problem solving, architectural trade-offs, formal specs. | Extended chain-of-thought, edge-case exploration. | `pro` / `reasoning` |
| `coding` | Code generation, syntactic modifications, localized edits. | Precise syntax, idiom conformance, minimal hallucination. | `flash` / `pro` |
| `coding-and-analysis` | End-to-end coding coupled with deep context synthesis. | High context window capacity, accurate multi-file edits. | `pro` |
| `independent-reasoning` | Unbiased verification, verification plan synthesis, test validation. | Adversarial checks, assumption questioning. | `pro` / `reasoning` |
| `independent-review` | Code review, quality, security, and standards assessment. | Critical evaluation, policy compliance checking. | `pro` |

---

## 2. Canonical Phase Capability Mapping

The standard capability allocation across AI-DLC phases is defined as follows:

```yaml
discovery:
  capability: fast-analysis
  description: "Quickly scan directory trees, manifests, and configs."

requirements:
  capability: reasoning
  description: "Synthesize user goals and extract unambiguous acceptance criteria."

solution:
  capability: deep-reasoning
  description: "Formulate architectural designs and evaluate trade-offs."

approval:
  capability: reasoning
  description: "Evaluate solution against requirements and policy gates."

plan:
  capability: reasoning
  description: "Generate atomic step-by-step implementation tasks."

implementation:
  capability: coding
  description: "Apply planned code edits with precise syntax and formatting."

testing:
  capability: coding-and-analysis
  description: "Author comprehensive test cases and diagnose failures."

verification:
  capability: independent-reasoning
  description: "Run and audit deterministic linters, compilers, and security scans."

review:
  capability: independent-review
  description: "Perform objective multi-perspective code and architecture review."
```

---

## 3. Host Adapter Contract

Host adapters must provide a resolution mechanism that maps these abstract capabilities to the active host's available models. If a specific capability cannot be mapped directly, the adapter falls back gracefully to the nearest higher capability tier.
