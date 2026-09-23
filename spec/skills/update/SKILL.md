---
name: update
description: In-place synchronization and daily 24h TTL auto-update across all AI coding hosts.
---

# DevWeave In-Place Update Specification

> **"Less Tokens. More Work. Lower Bill."**

## Purpose
Enables autonomous, in-place synchronization of DevWeave skills, templates, schemas, and adapter rules across all 6 supported AI coding hosts without manual uninstall/reinstall friction.

## When to Use
- On demand via `devweave-update` / `/devweave-update` / `@devweave /update`.
- Autonomously on the first session of each calendar day via 24h TTL cache check.

## Inputs
- Upstream source repository URI (`https://github.com/paarthivnaik/DevWeave.git` or enterprise Git mirror)
- Target release branch (`develop` / `main` / tag)

## Execution Invariants
1. **Zero LLM Token Overhead**: Checks and syncs are performed natively by lightweight scripts with zero LLM prompt consumption.
2. **Air-Gap & Offline Resilience**: Times out gracefully in 2s if offline; never blocks or crashes the IDE session.
3. **Workspace State Preservation**: Never touches user workspace data (`.devweave/state/`, `.devweave/knowledge/`).
