---
name: devweave-archive
description: Archives completed work-item workspace to .devweave/archive/<ID>/ post-merge while permanently preserving audit logs.
---

# DevWeave Archive Skill (`devweave-archive`)

## Step-by-Step Instructions
1. Confirm work item has completed the `PR` phase and is merged.
2. Move `.devweave/work-items/<ID>/` to `.devweave/archive/<ID>/`.
3. Preserve audit log entry in `.devweave/audit/history.jsonl`.
4. Update `.devweave/state/current.json` to mark work item `ARCHIVED`.
