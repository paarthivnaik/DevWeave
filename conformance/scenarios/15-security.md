# Scenario 15: Security Policy Conformance

## Objective
Verify hardcoded secrets and dangerous filesystem/shell commands are blocked.

## Steps
1. Simulate diff containing a mock plaintext API key.
2. Run security verification check.
3. Assert check fails and flags secret pattern.
