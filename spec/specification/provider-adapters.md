# DevWeave Specification: Project Management Provider Adapters

## 1. Abstraction Architecture

DevWeave interacts with external project management systems through a unified, vendor-neutral `WorkItemProvider` interface. Core lifecycle phases remain completely decoupled from provider-specific APIs, CLIs, or data formats.

```text
                  +--------------------------+
                  |    WorkItemProvider      |
                  +--------------------------+
                  | + detect()               |
                  | + detectClient()         |
                  | + isInstalled()          |
                  | + authenticationStatus() |
                  | + authenticate()         |
                  | + fetchWorkItem(id)      |
                  | + fetchComments(id)      |
                  | + fetchAttachments(id)   |
                  | + downloadAttachment()   |
                  | + extractAttachmentText()|
                  | + processImageOCR()      |
                  | + fetchLinks(id)         |
                  | + searchRelated(query)   |
                  | + resolveIdentity()      |
                  +--------------------------+
                               ^
         +-----------+---------+---------+-----------+
         |           |                   |           |
+--------+---+ +-----+-----+       +-----+-----+ +---+--------+
| Jira       | | Azure     |       | GitHub    | | Custom /   |
| Adapter    | | DevOps    |       | Adapter   | | Manual     |
|            | | Adapter   |       |           | | Adapter    |
+------------+ +-----------+       +-----------+ +------------+
```

---

## 2. Standard Provider Methods

| Method | Signature | Description |
|---|---|---|
| `detect` | `() -> bool` | Detects if the current workspace or environment contains configuration for this provider. |
| `detectClient` | `() -> ClientInfo` | Inspects host PATH for the provider CLI (`az`, `jira`/`acli`, `gh`). Returns tool name, version, and presence. |
| `isInstalled` | `() -> bool` | Convenience check returning true if the required client CLI / SDK is available. |
| `authenticationStatus`| `() -> AuthStatus` | Evaluates active authentication session without prompting. |
| `authenticate` | `(interactive: bool) -> AuthResult` | Initiates secure interactive authentication using provider-native flow. |
| `fetchWorkItem` | `(id: string) -> WorkItem` | Ingests and normalizes work item into standard `work-item.schema.json` format. |
| `fetchComments` | `(id: string) -> Array<Comment>` | Fetches chronological discussion comments. |
| `fetchAttachments` | `(id: string) -> Array<Attachment>` | Discovers all attachments and downloads metadata. |
| `downloadAttachment`| `(id: string, attId: string) -> FilePath` | Safely downloads attachment to temporary story workspace. |
| `fetchLinks` | `(id: string) -> Array<LinkedItem>` | Fetches bidirectional linked work items. |
| `searchRelated` | `(query: string) -> Array<PriorArt>` | Discovers related historical tickets, epics, or bugs. |

---

## 3. Supported Built-In Adapters

1. **Atlassian Jira (`jira`)**: Supports Jira Cloud / Server via `jira-cli`, `acli`, or REST API / MCP server. Normalizes custom fields and issue links.
2. **Azure DevOps (`azure-devops`)**: Supports Azure Boards via `az boards` CLI or REST API. Normalizes work item types (`User Story`, `Bug`, `Task`) and parent/child hierarchies.
3. **GitHub Issues & Projects (`github`)**: Supports GitHub Issues & Projects v2 via `gh issue` CLI or GraphQL API. Normalizes milestone, labels, and linked PRs.
4. **Custom / Manual (`custom`)**: Generic fallback supporting offline Markdown template input, manual copy-paste, or custom REST endpoint definitions.
