# Getting Started with DevWeave

Welcome to DevWeave — the generic, declarative AI-DLC (AI-Driven Development Lifecycle) system.

## Core Philosophy
**Less Tokens. More Work. Lower Bill.**

## Step 1: Initialize Your Repository
To onboard a new repository, trigger the initialization skill:
```text
Run devweave-init on current workspace
```
This generates `.devweave/` with:
- `.devweave/repository/`: Architectural, build, test, and tech stack intelligence.
- `.devweave/knowledge/`: Extracted domain rules and conventions.
- `.devweave/work-items/`: Active and archived AI-DLC tasks.

## Step 2: Running Your First Work Item
Describe your goal to the agent:
```text
"Add user cancellation endpoint for pending bookings"
```
DevWeave automatically routes through the AI-DLC lifecycle:
1. Requirements Analysis (`requirements.md`)
2. Solution Design (`solution.md`)
3. Human Approval Gate
4. Implementation Plan (`plan.md`)
5. Incremental Implementation
6. Automated Testing (`test-results.json`)
7. Deterministic Verification (`verification.md`)
8. Multi-Perspective Code Review (`review.md`)
9. PR Ready Package (`pr-description.md`)
