# DevWeave Conformance Suite (`conformance/`)

Compliance test suites, schema validators, and host verification harnesses for DevWeave V1.0.

## Vision
**Less Tokens. More Work. Lower Bill.**

## Overview
The `conformance/` suite ensures that any host adapter (including Google Antigravity, Claude, Codex, Copilot, etc.) correctly adheres to the canonical DevWeave specification.

## Verification Areas
1. **Schema Validation**: Validating that all skill, agent, policy, workflow, and artifact files conform to JSON Schemas.
2. **State Machine Verification**: Testing valid and invalid state transitions across the AI-DLC lifecycle.
3. **Artifact Integrity**: Validating required headers, sections, and metadata across lifecycle stages.
4. **Host Contract Testing**: Verifying that host adapters implement mandatory capabilities without introducing proprietary lock-in.

## License
Apache License 2.0. See [../LICENSE](../LICENSE) for details.
