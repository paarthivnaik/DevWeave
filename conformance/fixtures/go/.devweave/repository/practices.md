# Go Best Practices

- **MANDATORY**: Always check returned error values explicitly.
- **RECOMMENDED**: Pass context.Context as the first parameter for I/O functions.
- **ANTI_PATTERN**: Do not ignore errors with _ = fn() without explicit documented rationale.
