# DevWeave Project Management Provider Adapters

This directory contains specifications and reference implementations for DevWeave `WorkItemProvider` adapters.

## Directory Structure

```text
spec/providers/
├── README.md                   <-- Overview and adapter registry
├── work-item-provider.md       <-- Base WorkItemProvider interface contract
├── jira/
│   └── adapter.md              <-- Jira Adapter (jira-cli / acli / Jira REST)
├── azure-devops/
│   └── adapter.md              <-- Azure DevOps Adapter (az boards / REST)
├── github/
│   └── adapter.md              <-- GitHub Adapter (gh CLI / GraphQL)
└── custom/
    └── adapter.md              <-- Custom / Offline Manual Adapter
```

## Adding a New Provider

To add a new provider adapter:
1. Implement the `WorkItemProvider` contract defined in `work-item-provider.md`.
2. Ensure normalized output conforms to `work-item.schema.json`.
3. Adhere strictly to the **Zero Secret Storage** rule.
4. Support safe attachment extraction and non-blocking OCR handling.
