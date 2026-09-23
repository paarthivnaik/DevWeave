# End-to-End Request & Execution Flow: legacy

`mermaid
sequenceDiagram
    autonumber
    actor Client
    participant Entry as Entrypoint / Handler
    participant Svc as Domain Service
    participant Repo as Data Access / DAL
    participant DB as Storage Engine

    Client->>Entry: Request Payload
    Entry->>Entry: Schema & Type Validation
    Entry->>Svc: Execute Domain Operation
    Svc->>Repo: Query / Mutation
    Repo->>DB: Parameterized Query
    DB-->>Repo: Result Set
    Repo-->>Svc: Domain Model
    Svc-->>Entry: Response DTO
    Entry-->>Client: HTTP / JSON Response
`
"@

    # 11. integrations.md (External Interfaces & Data Stores)
    Set-Content -Path (Join-Path D:\DevWeave\conformance\fixtures\legacy\.devweave\repository "integrations.md") @"
# Integrations & External Interfaces: legacy

- **Primary Database / Storage**: Ecosystem native or configured store
- **Message Queues / APIs**: Discovered via dependencies
- **Confidence**: HIGH
