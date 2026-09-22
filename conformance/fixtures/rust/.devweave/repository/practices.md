# Rust Best Practices & Invariants

- **MANDATORY**: Enforce memory safety with zero unsafe blocks unless formally audited.
- **RECOMMENDED**: Return Result<T, E> with custom error types using 	hiserror.
- **ANTI_PATTERN**: Avoid .unwrap() in production code; use ? operator.
