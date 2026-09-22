# DevWeave Workflow Profiles Guide

Workflow Profiles optimize the AI-DLC state progression according to risk, scope, and engineering context.

## Available Profiles
- **`EXPRESS`**: Context -> Implement -> Test -> Verify -> PR Ready (for typos, quick documentation fixes).
- **`BUG`**: Diagnostic -> Repro -> Solution -> Fix -> Regression Tests -> Review -> PR Ready.
- **`FEATURE`**: Full canonical 12-state progression for net-new features.
- **`REFACTOR`**: Test baseline capture -> Invariance refactor -> Full regression suite.
- **`MODERNIZATION`**: Dependency analysis -> Staged upgrades -> Compatibility testing.
- **`SECURITY`**: Threat modeling -> Fix -> Security scanners -> Specialist security review.
- **`DATABASE`**: Schema inspection -> Migration generation -> Local execution -> Rollback verification.
- **`HIGH_RISK`**: Maximum discovery -> Comprehensive threat modeling -> Mandatory human gate -> Multi-agent review panel.
