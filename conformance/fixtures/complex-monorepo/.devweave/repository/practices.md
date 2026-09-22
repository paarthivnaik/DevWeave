# Monorepo Best Practices & Invariants

- **MANDATORY**: Keep service boundaries decoupled; communicate via shared event contracts.
- **RECOMMENDED**: Run targeted service test suites during local task execution.
- **ANTI_PATTERN**: Never import internal service implementation files across service boundaries.
