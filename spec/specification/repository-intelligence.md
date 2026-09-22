# DevWeave Repository Intelligence Specification

Repository Intelligence is the automated, non-invasive discovery and structured representation of a codebase's technical ecosystem, architectural patterns, build/test pipelines, and operational conventions.

---

## 1. Discovery Dimensions

Repository Intelligence systematically identifies and documents 13 key dimensions:

1. **Languages**: Primary and secondary languages, runtimes, versions, compiler settings.
2. **Frameworks**: Backend, frontend, full-stack, UI, CLI, and integration frameworks.
3. **Architecture**: Monolith, microservices, monorepo, clean architecture, hexagonal, serverless, modular event-driven.
4. **Dependencies**: Package managers, direct/transitive dependencies, lockfiles, internal shared libraries.
5. **Build System**: Compilers, bundlers, task runners, build scripts, incremental build configs.
6. **Test System**: Test frameworks, test runners, assertion libraries, coverage tooling, mocking frameworks.
7. **Databases & ORMs**: Datastores (SQL, NoSQL, vector, cache), migration engines, ORM/query builders.
8. **APIs & Contracts**: REST, GraphQL, gRPC, OpenAPI/Swagger specifications, message queues, event streams.
9. **Cloud & Infrastructure**: Dockerfiles, Docker Compose, Kubernetes manifests, Terraform/Bicep/CloudFormation, serverless configs.
10. **CI/CD Pipelines**: GitHub Actions, GitLab CI, Azure Pipelines, Jenkins, circleci workflows.
11. **Security & Compliance**: Secrets scanning, SAST/DAST configurations, auth providers, sanitization policies.
12. **Coding Conventions**: Linters, formatters, style guides, naming conventions, directory idioms.
13. **Repository Structure**: Monorepo packages, source folders, asset locations, test folder layouts.

---

## 2. Invariance Principle

> **Repository technologies are discovered dynamically and are never hard-coded as DevWeave dependencies.**

DevWeave operates uniformly whether the repository contains C#/.NET 9, Java 21 Spring Boot, Python 3.12 FastAPI, TypeScript Next.js, Go 1.22, Rust, or a polyglot legacy repository.
