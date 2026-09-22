# Scenario 02: Discovery & Intelligence Conformance

## Objective
Verify that discovery scans identify key tech stack properties without reading unnecessary files.

## Steps
1. Execute discovery on repository containing `.NET`, `Java`, or `TypeScript`.
2. Assert discovery completes within bounded file read operations.
3. Assert no source files outside manifests were ingested.
