# Python / FastAPI Best Practices & Invariants

- **MANDATORY**: Use Pydantic v2 schemas for all request/response models.
- **RECOMMENDED**: Use async route handlers for I/O-bound operations.
- **ANTI_PATTERN**: Do not use mutable default arguments in function definitions.
