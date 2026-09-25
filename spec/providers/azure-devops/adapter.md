# Azure DevOps Provider Adapter Specification

## 1. Overview
The Azure DevOps Provider Adapter integrates DevWeave with Azure Boards via Azure CLI (`az boards`), Azure DevOps REST API, or Azure DevOps MCP Server.

## 2. CLI Tool Detection
- Primary Command: `az boards` (via `az extension show --name azure-devops`)
- Detection Command: `az --version`
- Missing CLI Action: Route to `devweave-setup --provider azure-devops`

## 3. Authentication Mechanism
- Interactive: `az login`
- PAT / Service Principal: Managed via `az devops login` into Windows Credential Manager / Keychain.
- Zero Secret Rule: No PAT or OAuth tokens stored in `.devweave/`.

## 4. Work Item Mapping
- `id` -> `id` (e.g. `1042`)
- `title` -> `fields['System.Title']`
- `description` -> `fields['System.Description']` (HTML sanitized to Markdown)
- `type` -> `fields['System.WorkItemType']` (`User Story`, `Bug`, `Task`, `Epic`)
- `status` -> `fields['System.State']`
- `priority` -> `fields['Microsoft.VSTS.Common.Priority']` (Mapped to `High`, `Medium`, `Low`)
- `acceptance_criteria` -> `fields['Microsoft.VSTS.Common.AcceptanceCriteria']`
- `comments` -> Work item comments API endpoint (`_apis/wit/workItems/{id}/comments`)
- `attachments` -> Relations of type `AttachedFile` (`_apis/wit/attachments/{id}`)
- `linked_items` -> Relations of type `Hierarchy-Forward`, `Hierarchy-Reverse`, `Related`, `Dependency-Forward`
- `related_historical_work` -> WIQL Query `SELECT [System.Id] FROM WorkItems WHERE [System.WorkItemType] IN ('User Story','Bug') AND [System.Title] CONTAINS '...'`
