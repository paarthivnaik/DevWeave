---
name: devweave-modernization-context
description: "[Modernization Phase 1: Context] Ingest generic work item context via WorkItemProvider adapters, extract attachment text & OCR images, model candidate claims, build bounded migration slice, integrate knowledge graph deltas, and enforce human checkpoint."
---

# Gemini Modernization Context Command (`devweave-modernization-context`)

Construct a bounded, token-efficient migration context for the specified modernization work item by discovering relevant legacy source slices, acquiring full work item details via generic provider adapters (Azure DevOps, Jira, GitHub, Custom), extracting text and performing OCR on attachments, cataloging candidate claims with verification statuses, retrieving related knowledge graph entities, loading targeted technology practices, and compiling `context.md`, `work-item.json`, `evidence.json`, `migration-slice.json`, and `audit.md` without loading entire legacy repositories into AI memory.
