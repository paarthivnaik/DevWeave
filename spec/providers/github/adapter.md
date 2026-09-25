# GitHub Provider Adapter Specification

## 1. Overview
The GitHub Provider Adapter connects DevWeave to GitHub Issues, Discussions, and GitHub Projects v2 via GitHub CLI (`gh`), GitHub GraphQL API, or GitHub MCP Server.

## 2. CLI Tool Detection
- Primary Command: `gh` (e.g. `gh --version`)
- Missing CLI Action: Route to `devweave-setup --provider github`

## 3. Authentication Mechanism
- Interactive: `gh auth login`
- Secure Vault: Managed by GitHub CLI token store.
- Zero Secret Rule: No PAT or OAuth credentials written to `.devweave/`.

## 4. Work Item Mapping
- `id` -> Issue Number (e.g. `#108` or `108`)
- `title` -> `title`
- `description` -> `body`
- `type` -> Derived from labels (`bug`, `feature`, `user-story`, `modernization`)
- `status` -> `state` (`OPEN`, `CLOSED`) or Project Column status
- `priority` -> Derived from labels (`priority:high`, `priority:medium`, `priority:low`)
- `acceptance_criteria` -> Parsed from Markdown checkboxes `- [ ]` in issue body
- `comments` -> `gh issue view <ID> --json comments`
- `attachments` -> Extracted from image and file URLs embedded in markdown body
- `linked_items` -> Closing PRs, referenced issues, and sub-issues
- `related_historical_work` -> `gh search issues "<query>" --state all`
