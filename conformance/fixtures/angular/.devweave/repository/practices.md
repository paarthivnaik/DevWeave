# Angular Best Practices & Invariants

- **MANDATORY**: Use Standalone Components where supported.
- **RECOMMENDED**: Unsubscribe from RxJS observables using 	akeUntilDestroyed or sync pipe.
- **ANTI_PATTERN**: Do not perform direct DOM mutations; use Angular template bindings.
