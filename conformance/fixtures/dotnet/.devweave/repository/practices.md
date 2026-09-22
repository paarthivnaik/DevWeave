# .NET / EF Core Best Practices & Invariants

- **MANDATORY**: Ensure nullable reference types are respected.
- **RECOMMENDED**: Use AsNoTracking() on read-only EF Core queries.
- **RECOMMENDED**: Use LINQ method syntax adhering to project idioms.
- **ANTI_PATTERN**: Avoid async void methods outside event handlers.
