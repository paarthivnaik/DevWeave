# Legacy System Invariants

- **MANDATORY**: Parameterize all raw SQL queries to prevent injection.
- **RECOMMENDED**: Wrap legacy procedural calls in isolated adapter functions.
- **ANTI_PATTERN**: Do not alter global database connection state.
