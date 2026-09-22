---
name: context-analysis
description: Analyzes blast radius, identifies target files, and constructs token-efficient context payloads.
---

# Context Analysis Skill

## Purpose
Determine the exact impact zone of a work item, locate relevant code symbols and interface contracts, and assemble a bounded prompt context within configured token limits.

## When to Use
- Prior to Solution Design, Planning, and Implementation steps.

## Inputs
- Work item requirements
- Repository knowledge base

## Required Context
- High-level architecture map
- Index of symbols and module entry points

## Procedure
1. Perform blast-radius analysis to locate impacted modules and files.
2. Query `.devweave/knowledge/` for matching domain and technical constraints.
3. Extract necessary interface signatures and relevant code blocks.
4. Calculate estimated token budget and prune lower-priority content.
5. Produce `context.json` artifact.

## Constraints
- Never include entire lockfiles or unrelated modules.
- Maintain total context size within designated effort budget.

## Expected Artifacts
- `context.json` (conforming to `context.schema.json`)

## Success Criteria
- Context payload contains all essential signatures with zero extraneous files.

## Failure Conditions
- Inability to resolve symbol references or ambiguous module boundaries.
