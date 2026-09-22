# DevWeave V1.0 — Autonomous Technology Detection & Best-Practice Adaptation

## Purpose

This document defines a V1.0 requirement for `DevWeave Init`:

> **DevWeave must autonomously inspect an unknown repository, detect its programming languages, frameworks, libraries, tools, versions, architecture patterns, and relevant engineering context, and then automatically adapt its AI-DLC behavior using the applicable best practices.**

The developer should not need to tell DevWeave:

- "This is a .NET repository"
- "Use EF Core practices"
- "This project uses LINQ"
- "This is Angular"
- "This is PHP/Laravel"
- "Use Java/Spring practices"

DevWeave must discover these facts from repository evidence.

---

# 1. Core Principle

DevWeave is technology-neutral at the core, but **technology-aware at runtime**.

```text
                DevWeave / AI-DLC
                       |
                       v
              Repository Discovery
                       |
                       v
             Autonomous Detection
                       |
        +--------------+--------------+
        |              |              |
     Language       Frameworks      Libraries
        |              |              |
        +--------------+--------------+
                       |
                       v
              Version Detection
                       |
                       v
          Applicable Practice Selection
                       |
                       v
             Focused AI-DLC Context
                       |
                       v
       Discovery / Requirements / Solution
                       |
                       v
       Plan / Implement / Test / Verify
                       |
                       v
                    Review
```

The core AI-DLC specification must **not** become hard-coded around any language.

Instead:

```text
AI-DLC Core
     |
     +-- Language capability
     +-- Framework capability
     +-- Library capability
     +-- Database capability
     +-- Testing capability
     +-- Security capability
     +-- Architecture capability
```

---

# 2. What "Autonomous" Means

Autonomous detection means DevWeave should infer the technology stack from repository evidence.

Examples of evidence:

```text
.csproj
.sln
.cs
global.json
Directory.Build.props
```

may indicate .NET.

```text
package.json
angular.json
tsconfig.json
*.component.ts
```

may indicate Angular/TypeScript.

```text
composer.json
*.php
artisan
```

may indicate PHP/Laravel.

```text
pom.xml
build.gradle
*.java
```

may indicate Java/Maven/Gradle.

```text
pyproject.toml
requirements.txt
*.py
```

may indicate Python.

Detection must be evidence-based.

Do not rely only on directory names or file extensions.

---

# 3. Detection Layers

`DevWeave Init` should perform progressive detection.

## Layer 1 — Repository structure

Detect:

- monorepo
- single project
- multiple applications
- services
- packages
- shared libraries
- frontend/backend separation
- infrastructure
- database/migrations
- tests

## Layer 2 — Programming languages

Detect all relevant languages.

Example:

```yaml
languages:
  - name: csharp
    confidence: high
  - name: typescript
    confidence: high
  - name: sql
    confidence: medium
```

Do not assume only one language.

## Layer 3 — Frameworks

Detect frameworks such as:

```text
ASP.NET Core
Angular
React
Spring Boot
Laravel
Django
FastAPI
Express
NestJS
```

Only report technologies supported by repository evidence.

## Layer 4 — Libraries and important tooling

Examples:

```text
EF Core
LINQ
RxJS
Entity Framework
Serilog
xUnit
NUnit
Jest
Jasmine
JUnit
Mockito
Composer
Maven
Gradle
npm
pnpm
```

The list must remain extensible.

## Layer 5 — Versions

Detect versions whenever reliable evidence exists.

Examples:

```text
.NET 9
Angular 21
PHP 8.3
Java 21
Python 3.12
EF Core 9
```

If version cannot be reliably determined:

```yaml
version:
  value: unknown
  confidence: low
```

Never invent a version.

---

# 4. Technology Detection Output

Initialization should produce repository technology knowledge.

Example:

```text
.aidlc/
└── repository/
    ├── profile.md
    ├── technologies.md
    ├── frameworks.md
    ├── dependencies.md
    └── practices.md
```

`technologies.md` should contain evidence.

Example:

```yaml
technology:
  name: C#
  version: "13"
  confidence: high
  evidence:
    - path: src/Booking/Booking.csproj
    - path: global.json
```

Framework:

```yaml
framework:
  name: ASP.NET Core
  version: "9"
  confidence: high
  evidence:
    - path: src/Api/Api.csproj
```

Library:

```yaml
library:
  name: Entity Framework Core
  version: "9"
  confidence: high
  evidence:
    - path: src/Infrastructure/Infrastructure.csproj
```

---

# 5. Best-Practice Selection

After detection, DevWeave should determine applicable engineering practices.

```text
Detected Stack
      |
      +-- C#
      +-- ASP.NET Core
      +-- EF Core
      +-- LINQ
      +-- xUnit
      |
      v
Practice Selection
      |
      +-- C# practices
      +-- ASP.NET Core practices
      +-- EF Core practices
      +-- LINQ practices
      +-- xUnit practices
      |
      v
Applicable Practices
```

The system must not load every available practice.

It should select practices based on:

- detected technology
- version
- affected component
- work-item type
- repository conventions
- architecture
- risk
- affected files
- database/API/security impact

---

# 6. Practices Must Be Contextual

Do not apply a practice blindly.

Bad:

```text
Always use AsNoTracking.
```

Better:

```text
Practice:
Use no-tracking queries for appropriate read-only workloads.

Applicability:
Read-only EF Core query.

Evidence:
Official guidance + repository context.

Status:
RECOMMENDED
```

The same principle applies to every language.

---

# 7. Practice Categories

V1.0 should support at least:

```text
MANDATORY
RECOMMENDED
ADVISORY
ANTI_PATTERN
```

Examples:

### MANDATORY

Security/compliance requirement.

### RECOMMENDED

Strong engineering guidance applicable to the detected context.

### ADVISORY

Useful improvement that does not necessarily require change.

### ANTI_PATTERN

Known pattern that should be avoided when applicable.

---

# 8. Practice Sources

Practices should be distinguishable by source.

```text
Practice Source
     |
     +-- Official technology guidance
     +-- Repository conventions
     +-- Organization standards
     +-- Approved DevWeave practices
     +-- Project-specific rules
```

Do not represent an AI-generated suggestion as official guidance.

Every practice should preserve its source and confidence.

Example:

```yaml
id: EFCORE-QUERY-001
technology: Entity Framework Core
category: performance
classification: RECOMMENDED

practice: >
  Review read-only queries for unnecessary change tracking.

source:
  type: official-guidance
  reference: documented source configured by DevWeave

applicability:
  - read-only-query

status: ACTIVE
```

---

# 9. Repository Conventions Have Higher Priority

When a repository has established conventions, DevWeave should detect them.

Example:

```text
Repository convention:
All EF Core queries use repository-specific projection methods.
```

DevWeave should not blindly replace that convention with a generic recommendation.

Recommended precedence:

```text
Security / Compliance
        |
Organization Policy
        |
Repository Convention
        |
Official Technology Guidance
        |
DevWeave Recommendation
```

If two practices conflict, DevWeave must identify the conflict instead of silently choosing one.

---

# 10. Version Awareness

Practices must be version-aware.

Example:

```text
Angular 8
```

must not automatically receive assumptions intended for:

```text
Angular 21
```

Likewise:

```text
.NET 6
.NET 8
.NET 9
.NET 10
```

may have different applicable guidance.

When version-specific guidance is unavailable:

```text
Use version-neutral practice
```

rather than inventing version-specific behavior.

---

# 11. Multi-Language Repositories

DevWeave must support repositories containing multiple languages.

Example:

```text
DevWeave Repository
|
+-- Backend
|     +-- C#
|     +-- ASP.NET Core
|     +-- EF Core
|
+-- Frontend
|     +-- TypeScript
|     +-- Angular
|     +-- RxJS
|
+-- Infrastructure
|     +-- YAML
|     +-- Docker
|
+-- Database
|     +-- SQL
```

The work item should receive only the relevant practices.

For a backend change:

```text
C#
ASP.NET Core
EF Core
LINQ
Database
```

For an Angular UI change:

```text
TypeScript
Angular
RxJS
Testing
```

Do not inject unrelated frontend practices into backend work.

---

# 12. Practice Applicability Engine

The context engine should effectively perform:

```text
Work Item
    |
    v
Affected Files
    |
    v
Affected Components
    |
    v
Detected Technologies
    |
    v
Relevant Practices
    |
    v
Focused Context
```

Example:

```text
Work Item:
Optimize booking search query

Affected:
BookingRepository.cs

Detected:
C#
EF Core
LINQ
MySQL

Selected practices:
- EF Core query efficiency
- LINQ query composition
- database indexing/query analysis
- repository performance conventions

Not selected:
- Angular
- React
- CSS
- frontend state management
```

This is critical for token efficiency.

---

# 13. Technology Practice Knowledge

Persist applicable practices under repository knowledge.

Recommended structure:

```text
.aidlc/
├── repository/
│   ├── profile.md
│   ├── technologies.md
│   ├── frameworks.md
│   ├── dependencies.md
│   └── practices.md
│
└── knowledge/
    └── practices/
        ├── csharp/
        ├── aspnetcore/
        ├── efcore/
        ├── linq/
        ├── angular/
        ├── typescript/
        ├── php/
        ├── laravel/
        ├── java/
        └── python/
```

Do not create empty categories unnecessarily.

Only persist practices relevant to the detected repository.

---

# 14. AI-DLC Phase Integration

Practices must influence the lifecycle, not only INIT.

```text
INIT
 |
 +-- Detect technology
 +-- Detect frameworks
 +-- Detect libraries
 +-- Detect versions
 +-- Detect repository conventions
 +-- Build practice context
 |
 v
DISCOVERY
 |
 +-- Technology-aware discovery
 |
 v
REQUIREMENTS
 |
 +-- Identify technology constraints
 |
 v
SOLUTION
 |
 +-- Apply architecture/framework practices
 |
 v
PLAN
 |
 +-- Apply implementation/testing practices
 |
 v
IMPLEMENT
 |
 +-- Use relevant coding practices
 |
 v
TEST
 |
 +-- Use repository-native testing practices
 |
 v
VERIFY
 |
 +-- Verify against applicable practices
 |
 v
REVIEW
 |
 +-- Review technology-specific risks and anti-patterns
```

---

# 15. Examples

## Example A — .NET + EF Core + LINQ

Detection:

```text
C#
ASP.NET Core
EF Core
LINQ
xUnit
```

DevWeave automatically considers:

```text
C# coding practices
ASP.NET Core practices
EF Core query/data-access practices
LINQ practices
xUnit testing practices
```

For a query change, only the relevant subset is loaded.

---

## Example B — Angular

Detection:

```text
TypeScript
Angular
RxJS
```

DevWeave considers:

```text
Angular architecture
component practices
dependency injection
signals/RxJS where applicable
subscription/lifecycle handling
testing
```

The exact practices must be based on detected Angular/version context and repository evidence.

---

## Example C — PHP + Laravel

Detection:

```text
PHP
Laravel
Composer
PHPUnit
```

DevWeave considers:

```text
PHP practices
Laravel practices
Composer dependency practices
PHPUnit testing practices
security practices
database practices where applicable
```

---

## Example D — Java + Spring Boot

Detection:

```text
Java
Spring Boot
Maven
JUnit
```

DevWeave considers:

```text
Java practices
Spring Boot practices
Maven practices
JUnit practices
```

---

# 16. Detection Confidence

Every detected technology should have confidence.

```text
HIGH
MEDIUM
LOW
```

Example:

```yaml
technology: Angular
confidence: HIGH
evidence:
  - angular.json
  - package.json
  - tsconfig.json
```

If confidence is LOW, DevWeave should avoid aggressive technology-specific behavior.

```text
LOW confidence
    |
    v
Generic safe behavior
    +
Request/perform deeper discovery if necessary
```

---

# 17. Conflicting Technology Detection

If the repository contains multiple versions/frameworks:

```text
Angular 8
Angular 17
```

or multiple applications:

```text
Frontend A → Angular 17
Frontend B → Angular 8
```

DevWeave must scope practices to the affected component.

It must not assume one technology/version applies globally.

---

# 18. Autonomous Behavior Rules

DevWeave should automatically:

1. Detect.
2. Validate detection evidence.
3. Determine applicable practices.
4. Scope practices to the affected area.
5. Include only relevant practices in context.
6. Apply them during implementation/testing/verification/review.
7. Record important practice decisions.
8. Avoid practices that are not applicable.
9. Preserve repository-specific conventions.
10. Ask for clarification only when ambiguity materially affects correctness.

The user should not have to manually select a language practice pack for normal repositories.

---

# 19. What DevWeave Must NOT Do

Do not:

```text
Assume repository language
Assume framework
Assume database
Assume cloud provider
Assume coding style
Assume framework version
Apply every practice
Load all practice documentation into context
Treat AI suggestions as official standards
Override repository conventions silently
```

---

# 20. Token Efficiency Requirement

Technology awareness must not increase context unnecessarily.

Bad:

```text
.NET repository
→ load every .NET practice
→ load every EF Core practice
→ load every LINQ practice
→ load entire repository
```

Better:

```text
Work Item
   ↓
Affected files
   ↓
Detected technologies for those files
   ↓
Applicable practices only
   ↓
Focused context
```

The system should optimize for:

```text
Useful engineering work
-----------------------
AI tokens + AI calls + rework
```

---

# 21. Conformance Requirements

Add conformance tests for autonomous technology adaptation.

Minimum scenarios:

```text
19 — Autonomous language detection
20 — Framework/library detection
21 — Version detection
22 — Technology-specific practice selection
23 — Practice applicability filtering
24 — Multi-language repository behavior
25 — Version-aware behavior
26 — Repository convention precedence
27 — Low-confidence detection fallback
28 — Technology-specific verification/review
29 — Technology practice token efficiency
```

Required fixtures:

```text
.NET + EF Core + LINQ
Angular + TypeScript
PHP + Laravel
Java + Spring Boot
Python + FastAPI
Node + TypeScript
Multi-language monorepo
Legacy repository
```

---

# 22. Acceptance Criteria

V1.0 technology adaptation passes when:

```text
[ ] DevWeave detects repository languages autonomously
[ ] DevWeave detects frameworks where evidence exists
[ ] DevWeave detects important libraries/tools where evidence exists
[ ] DevWeave detects versions where reliable evidence exists
[ ] DevWeave records detection evidence
[ ] DevWeave assigns detection confidence
[ ] DevWeave selects applicable practices automatically
[ ] DevWeave scopes practices to affected components
[ ] DevWeave supports multi-language repositories
[ ] DevWeave is version-aware
[ ] DevWeave respects repository conventions
[ ] DevWeave distinguishes official guidance from recommendations
[ ] DevWeave avoids loading irrelevant practices
[ ] DevWeave uses technology practices during implementation
[ ] DevWeave uses technology practices during verification
[ ] DevWeave uses technology practices during review
[ ] DevWeave remains technology-neutral at the AI-DLC core
[ ] No mandatory language/runtime dependency is introduced
[ ] Conformance tests demonstrate the behavior
```

---

# 23. Implementation Task for Google Antigravity

Use this as the implementation instruction:

```text
Implement the DevWeave V1.0 requirement:
Autonomous Technology Detection & Best-Practice Adaptation.

Before changing anything:
1. Inspect the current DevWeave specification.
2. Inspect the current Init implementation.
3. Inspect repository intelligence.
4. Inspect knowledge architecture.
5. Inspect context assembly.
6. Inspect existing conformance scenarios and schemas.
7. Identify the minimum architecture changes required.

Required behavior:
- DevWeave Init autonomously detects languages from repository evidence.
- Detect frameworks, libraries and important tooling where evidence exists.
- Detect versions where reliable evidence exists.
- Record evidence and confidence.
- Determine applicable technology-specific engineering practices.
- Scope practices to affected components/work items.
- Preserve repository conventions.
- Keep AI-DLC core technology-neutral.
- Do not introduce a mandatory runtime or language-specific dependency.
- Do not hard-code only .NET, Angular or PHP.
- Design the practice mechanism to be extensible to any future technology.
- Do not load all practices into every AI context.
- Use only relevant practices for the current work item.

Initial technology examples for validation:
- C# / .NET / ASP.NET Core / EF Core / LINQ
- TypeScript / Angular
- PHP / Laravel
- Java / Spring Boot
- Python / FastAPI
- Node / TypeScript

Important:
These examples are validation targets, not hard-coded limits.

Implement one task at a time.

First task:
Inspect the current architecture and propose the smallest V1.0 implementation plan for autonomous detection and practice selection.

Do not modify files yet.

Stop and report the proposal.
```

---

# 24. Final Architecture

The target behavior is:

```text
                     UNKNOWN REPOSITORY
                             |
                             v
                    DEVWEAVE INIT
                             |
                             v
                  AUTONOMOUS DISCOVERY
                             |
          +------------------+------------------+
          |                  |                  |
          v                  v                  v
      Languages         Frameworks          Libraries
          |                  |                  |
          +------------------+------------------+
                             |
                             v
                       Versions
                             |
                             v
                  Repository Conventions
                             |
                             v
                 Practice Applicability Engine
                             |
                             v
                  Technology-Aware Knowledge
                             |
                             v
                    Focused Context Engine
                             |
                             v
                       AI-DLC Lifecycle
                             |
          +------------------+------------------+
          |                  |                  |
       Solution          Implement           Review
          |                  |                  |
          +------------------+------------------+
                             |
                             v
                      Verify / Learn
                             |
                             v
                    Reusable Knowledge
```

## Core principle

> **The developer tells DevWeave WHAT needs to be built or changed. DevWeave determines HOW the repository's technology stack should influence the engineering process.**

The technology-specific behavior must emerge from repository detection and applicable practices, not from manually configuring DevWeave for every project.

This is a V1.0 capability and should be validated before moving to V1.1.
