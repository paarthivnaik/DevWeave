# DevWeave Antigravity Plugin — Implementation Task

## Purpose

You are working inside the **DevWeave repository**.

Your task is to create the first working Antigravity plugin for DevWeave.

DevWeave is a generic AI-native software development lifecycle based on the AI-DLC specification.

The plugin is an **Antigravity adapter** for DevWeave.

Do not turn DevWeave itself into an Antigravity-specific product.

---

# 1. Existing Repository

First inspect the repository.

Do not assume the existing structure.

Identify:

- AI-DLC specification
- lifecycle definitions
- workflow profiles
- conformance scenarios
- schemas
- documentation
- existing `.aidlc` definitions
- existing host/adapters
- existing plugin-related files

Preserve all existing DevWeave functionality.

Do not delete or replace existing specification files.

---

# 2. Plugin Architecture

The desired architecture is:

```text
DevWeave GitHub Repository
│
├── spec/
├── conformance/
├── docs/
├── README.md
│
└── plugins/
    └── devweave/
        │
        ├── plugin.json
        │
        └── skills/
            └── devweave-init/
                └── SKILL.md
```

The directory:

```text
plugins/devweave/
```

is the Antigravity plugin package.

The Dating App repository is NOT part of DevWeave.

Later, this plugin will be installed into the Dating App repository's Antigravity environment.

---

# 3. Important Separation

Keep these concepts separate.

## DevWeave

Defines:

- AI-DLC specification
- lifecycle
- workflow profiles
- state model
- requirements model
- solution model
- planning model
- verification model
- review model
- conformance
- generic project-management capabilities
- generic database capabilities
- security/governance
- token-efficiency principles

## Antigravity Plugin

Defines:

- how Antigravity invokes DevWeave
- Skills
- Antigravity-specific agents where required
- Antigravity-specific rules where required
- Antigravity MCP configuration where required
- Antigravity hooks where supported

The plugin must not duplicate the entire DevWeave specification.

---

# 4. Verify Current Antigravity Plugin Format

Before implementing the plugin:

1. Check the current official Antigravity plugin documentation.
2. Verify the current plugin manifest format.
3. Verify the current Skill format.
4. Verify the current local plugin installation method.
5. Verify whether agents, rules, MCP and hooks are currently supported in plugins.
6. Use only currently supported properties.
7. Do not invent unsupported fields.

If the current Antigravity format differs from this document, use the current official format while preserving the DevWeave architecture.

---

# 5. Create Plugin Manifest

Create:

```text
plugins/devweave/plugin.json
```

The manifest must identify the plugin as:

```text
devweave
```

and describe it as:

```text
DevWeave AI-DLC software engineering workflow
```

Use the exact manifest schema required by the current Antigravity plugin documentation.

Do not add unnecessary properties.

Do not add:

- Jira credentials
- API keys
- PATs
- database passwords
- model API keys
- repository-specific configuration

---

# 6. Create First Skill

Create:

```text
plugins/devweave/skills/devweave-init/SKILL.md
```

This is the first DevWeave Skill.

The Skill's purpose is:

> Initialize DevWeave in the repository where the Skill is executed.

The Skill must instruct Antigravity to inspect the target repository and establish repository knowledge for AI-DLC.

---

# 7. `devweave-init` Skill

The Skill should perform the following logical workflow.

```text
/devweave-init
       │
       ▼
Inspect repository
       │
       ├── languages
       ├── frameworks
       ├── versions
       ├── dependencies
       ├── architecture
       ├── conventions
       ├── tests
       ├── database
       ├── APIs
       ├── cloud
       ├── CI/CD
       └── security
       │
       ▼
Build repository knowledge
       │
       ▼
Create/update .aidlc/
       │
       ▼
Report initialization result
```

---

# 8. Repository Discovery Rules

The Skill must instruct Antigravity to use repository evidence.

Examples of evidence:

- source files
- project files
- package files
- solution/project files
- configuration files
- lock files
- Docker files
- CI/CD files
- test projects
- migration files
- README/documentation
- directory structure

Never claim a technology exists only because it is common for a project type.

For example:

Do NOT say:

```text
This is probably a .NET application.
```

unless repository evidence confirms it.

Instead identify evidence such as:

```text
*.csproj
*.sln
TargetFramework
PackageReference
```

and record the detected technology.

---

# 9. Technology Detection

Detect, when evidence exists:

- programming languages
- frameworks
- libraries
- runtime versions
- package managers
- build tools
- test frameworks
- database technologies
- API technologies
- cloud technologies
- containerization
- CI/CD
- infrastructure
- authentication/security technologies

Support polyglot repositories.

Example:

```text
C#
TypeScript
Python
SQL
```

may all exist in one repository.

Do not assume one language per repository.

---

# 10. Confidence

Where appropriate, classify detection confidence as:

```text
HIGH
MEDIUM
LOW
```

Example:

```yaml
technology:
  name: .NET
  version: "10"
  confidence: HIGH
  evidence:
    - src/MyApi/MyApi.csproj
    - TargetFramework=net10.0
```

Never invent a version.

If the version cannot be established, record:

```text
version: unknown
```

rather than guessing.

---

# 11. Repository Knowledge

Create or update the DevWeave repository knowledge structure defined by the existing DevWeave specification.

If the repository already defines the exact structure, follow that definition.

Otherwise use the established DevWeave structure:

```text
.aidlc/
├── repository/
├── knowledge/
│   ├── repository/
│   │   ├── architecture/
│   │   ├── patterns/
│   │   ├── conventions/
│   │   └── constraints/
│   ├── domain/
│   ├── technical/
│   ├── candidates/
│   └── registry.yaml
├── work-items/
├── decisions/
├── verification/
├── audit/
└── state/
```

Do not create unnecessary files.

Prefer concise, reusable knowledge over large copied repository contents.

---

# 12. Knowledge Status

Use the DevWeave knowledge statuses:

```text
OBSERVED
INFERRED
RECOMMENDED
APPROVED
DEPRECATED
```

Repository facts discovered directly from source should normally be:

```text
OBSERVED
```

Do not mark recommendations as observed facts.

---

# 13. Repository Conventions

Detect repository conventions such as:

- naming conventions
- folder organization
- project organization
- API conventions
- error handling
- logging
- testing patterns
- configuration patterns
- dependency management
- migration patterns
- build conventions

Only record conventions supported by evidence.

---

# 14. Technology-Aware Practices

If DevWeave already contains technology-practice definitions, use them.

Otherwise record the detected technologies so later DevWeave phases can select appropriate practices.

Practice priority is:

```text
1. Security / Compliance
2. Organization Policy
3. Repository Convention
4. Official Technology Guidance
5. DevWeave Recommendation
```

Do not make technology-specific recommendations during initialization unless the existing DevWeave specification requires them.

Initialization should primarily discover and record facts.

---

# 15. Project Management Detection

During initialization determine whether a project-management MCP capability is available.

Do not hard-code Jira.

Possible providers include:

```text
Jira
Azure DevOps
GitHub
GitLab
Linear
other MCP-compatible providers
```

If no project-management MCP capability exists, record:

```yaml
projectManagement:
  enabled: false
```

Do not fail initialization because project-management MCP is unavailable.

The user can later provide requirements manually.

---

# 16. Security

Never store:

- PATs
- passwords
- API keys
- tokens
- secrets
- connection strings containing credentials

inside:

```text
.aidlc/
```

or any DevWeave artifact.

If credentials are required later, use secure Antigravity/MCP credential mechanisms.

---

# 17. Do Not Modify Application Code

`devweave-init` is discovery and initialization.

It must NOT:

- refactor application code;
- change business logic;
- change database schema;
- install arbitrary dependencies;
- modify production configuration;
- modify source code merely to make DevWeave work.

The only expected repository changes should be DevWeave initialization artifacts such as `.aidlc/`.

---

# 18. Token Efficiency

Initialization must be token-efficient.

Do not dump the entire repository into the model context.

Prefer:

```text
directory structure
+
important project/config files
+
targeted source inspection
+
targeted documentation
```

Build reusable knowledge so later phases do not repeat the same discovery.

The principle is:

```text
Discover Once
      ↓
Store Knowledge
      ↓
Reuse Knowledge
```

---

# 19. Initialization Result

At the end, report:

```text
DevWeave initialization completed.

Repository:
<name>

Languages:
...

Frameworks:
...

Databases:
...

Testing:
...

Architecture:
...

CI/CD:
...

Security:
...

Project Management MCP:
Configured / Not Configured

Knowledge:
Created / Updated

Next recommended action:
DevWeave context/work-item initialization
```

Do not provide unsupported assumptions.

---

# 20. Validation

After creating the plugin and Skill:

1. Validate the plugin manifest against the current Antigravity plugin format.
2. Validate the Skill structure.
3. Check for invalid JSON.
4. Check for missing required files.
5. Check that no secrets were added.
6. Check that existing DevWeave files were not accidentally modified.
7. Review the Git diff.

If a supported Antigravity CLI is available, use it to validate/list/install the plugin according to the current official documentation.

---

# 21. First Test

After the plugin is created, the plugin should eventually be installed into a separate Dating App repository.

The test environment should look like:

```text
C:\Projects\
│
├── DevWeave\
│   ├── spec\
│   ├── conformance\
│   ├── docs\
│   └── plugins\
│       └── devweave\
│           ├── plugin.json
│           └── skills\
│               └── devweave-init\
│                   └── SKILL.md
│
└── DatingApp\
    ├── src\
    ├── tests\
    └── ...
```

Open `DatingApp` in Antigravity.

After installing the plugin, invoke:

```text
/devweave-init
```

The Skill must operate on the Dating App repository, not the DevWeave repository.

---

# 22. Do Not Implement These Yet

For this first Skill, do NOT implement:

- requirements workflow
- solution workflow
- planning workflow
- implementation workflow
- testing workflow
- verification workflow
- review workflow
- database mutation
- Jira integration
- project-management write-back
- production operations
- autonomous code modification
- complex agent orchestration

Those will be added as separate Skills later.

---

# 23. Success Criteria

The first implementation is successful when:

```text
[ ] DevWeave repository remains intact
[ ] AI-DLC specification remains unchanged
[ ] Existing conformance suite remains intact
[ ] Antigravity plugin manifest exists
[ ] Antigravity recognizes the plugin
[ ] devweave-init Skill exists
[ ] Skill is discoverable by Antigravity
[ ] /devweave-init can be invoked
[ ] Skill can inspect the target repository
[ ] Skill can create/update .aidlc/
[ ] Technology detection is evidence-based
[ ] No secrets are stored
[ ] No application source is unnecessarily modified
[ ] Initialization is token-efficient
```

---

# 24. Implementation Discipline

Implement only the first working version.

Do not over-engineer.

Do not introduce a custom DevWeave runtime.

Do not create a Node/Python executable just to implement the Skill.

Use Antigravity's native plugin and Skill mechanisms.

After implementation, show:

1. Files created.
2. Files modified.
3. Validation performed.
4. Plugin installation/test command based on the current official Antigravity documentation.
5. Expected `/devweave-init` behavior.

Then stop.

Do not implement the next DevWeave Skill until this one has been validated.
