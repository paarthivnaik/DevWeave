# Angular Best Practices

- **MANDATORY**: Use Standalone Components where supported.
- **RECOMMENDED**: Unsubscribe from RxJS observables using takeUntilDestroyed or async pipe.
- **ANTI_PATTERN**: Do not perform direct DOM mutations; use Angular template bindings.
