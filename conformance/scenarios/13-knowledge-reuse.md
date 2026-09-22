# Scenario 13: Knowledge Reuse Conformance

## Objective
Verify that previously captured knowledge items are loaded into subsequent work item contexts without redundant discovery.

## Steps
1. Capture domain knowledge in `.devweave/knowledge/domain/`.
2. Initiate a new work item touching that domain.
3. Assert discovery reads cached knowledge and incurs zero rediscovery token overhead.
