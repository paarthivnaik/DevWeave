# Rust Best Practices

- **MANDATORY**: Enforce memory safety with zero unsafe blocks unless formally audited.
- **RECOMMENDED**: Return Result<T, E> with custom error types using thiserror.
- **ANTI_PATTERN**: Avoid unwrap() in production code; use ? operator.
