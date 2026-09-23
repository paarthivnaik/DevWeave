# Physical-to-Logical Layer Mapping: rust

| Layer Tier | Directory / File Anchor | Role & Responsibility | Invariants |
|---|---|---|---|
| **1. Entrypoint & Bootstrap** | src/ / main / manifests | App initialization & wiring | No direct business logic |
| **2. Middleware / Routing** | Endpoints / Controllers / Handlers | Request validation & dispatch | Input schema parsing |
| **3. Domain & Service Logic** | Core Domain / Use Cases | Business rule execution | Framework-agnostic |
| **4. Persistence / DAL** | Repository / Database Adapters | Parameterized data queries | Safe transactional operations |
