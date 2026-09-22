---
name: devweave-init
description: Autonomously detects repository technology stack across 5 layers and initializes .devweave metadata and practices.
---

# DevWeave Initialization Skill (Antigravity)

## Instructions
1. **Layer 1 (Structure)**: Inspect workspace root for project topology (monorepo, single service, shared libraries, DB migrations).
2. **Layer 2 (Languages)**: Detect programming languages from manifest files (`package.json`, `*.csproj`, `pom.xml`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `composer.json`, `Gemfile`, `CMakeLists.txt`).
3. **Layer 3 (Frameworks)**: Detect active frameworks (ASP.NET Core, Angular, Spring Boot, FastAPI, Laravel, Rails, Express, React, etc.).
4. **Layer 4 (Libraries & Tooling)**: Identify core libraries, ORMs (EF Core, Prisma, Hibernate, SQLAlchemy), and test frameworks (xUnit, pytest, Jest, JUnit, PHPUnit).
5. **Layer 5 (Versions)**: Extract precise version evidence.
6. **Generate `.devweave/` Artifacts**:
   - `.devweave/repository/profile.md`
   - `.devweave/repository/architecture.md`
   - `.devweave/repository/technologies.md`
   - `.devweave/repository/frameworks.md`
   - `.devweave/repository/build.md`
   - `.devweave/repository/testing.md`
   - `.devweave/repository/practices.md`
   - `.devweave/knowledge/conventions.md`
   - `.devweave/state/current.json`
7. Present discovery summary and bound best practices to the user.
