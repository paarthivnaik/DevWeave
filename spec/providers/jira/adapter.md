# Jira Provider Adapter Specification

## 1. Overview
The Jira Provider Adapter connects DevWeave to Atlassian Jira Cloud and Jira Data Center via Jira CLI (`jira` or `acli`), Jira REST API v3, or Jira MCP Server.

## 2. CLI Tool Detection
- Primary Command: `jira` (e.g. `jira version` or `jira issue view <ID>`)
- Alternative: `acli` (Atlassian Command Line Interface)
- Missing CLI Action: Route to `devweave-setup --provider jira`

## 3. Authentication Mechanism
- Token/API Key: Native OS Credential Manager via `jira init` or secure session token.
- Zero Secret Rule: Zero tokens written to `.devweave/` or repository artifacts.

## 4. Work Item Mapping
- `id` -> `key` (e.g. `PROJ-1234`)
- `title` -> `fields.summary`
- `description` -> `fields.description` (parsed from Atlassian Document Format ADF to Markdown)
- `type` -> `fields.issuetype.name`
- `status` -> `fields.status.name`
- `priority` -> `fields.priority.name`
- `acceptance_criteria` -> Extracted from custom field (e.g. `customfield_10020`) or parsed from description section
- `comments` -> `fields.comment.comments`
- `attachments` -> `fields.attachment`
- `linked_items` -> `fields.issuelinks` (`inwardIssue`, `outwardIssue`)
- `related_historical_work` -> JQL Search `text ~ "query" OR labels in (...) ORDER BY created DESC`
