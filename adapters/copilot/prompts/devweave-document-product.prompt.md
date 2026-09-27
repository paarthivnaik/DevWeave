---
name: document-product
description: [Knowledge - Product Documentation] Captures durable, long-lived product-level context (architecture, installers, middleware, frontend shell) into .devweave/products/<name>.md.
---

# DevWeave Document Product Skill (`devweave-document-product`)

## Purpose
Establishes and curates top-level product architecture documentation under `.devweave/products/<name>.md` so that AI agents reuse durable product knowledge instead of re-discovering the system repeatedly.

---

## Step-by-Step Instructions
1. Prompt developer for product scope or inspect target codebase directories.
2. Synthesize product profile:
   - High-Level Architecture & Tech Stack
   - Key Modules, Entry Points, and Middleware
   - Data Stores & External Integrations
   - CI/CD & Deployment Pipelines
3. Save to `.devweave/products/<name>.md`.
4. Register product entry in `.devweave/knowledge/registry.yaml`.
