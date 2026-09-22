# Scenario 18: Model Capability Negotiation Conformance

## Objective
Verify that abstract capability requirements (e.g. `fast-analysis`, `deep-reasoning`) are mapped to host models without failing on unavailable tiers.

## Steps
1. Request `fast-analysis` task.
2. Assert host adapter resolves to appropriate fast model (e.g. `flash_lite`).
3. Request `deep-reasoning` task and assert resolution to reasoning model (e.g. `pro`).
