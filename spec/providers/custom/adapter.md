# Custom & Offline Manual Provider Adapter Specification

## 1. Overview
The Custom Provider Adapter provides offline support, manual markdown template ingestion, and extensible custom REST API connectivity for environments without active PM tool integration.

## 2. CLI Tool Detection
- No external CLI mandatory.
- Checks local workspace directories and template availability.

## 3. Ingestion Modes
1. **Interactive Markdown Template**: Prompts developer with structured prompt template to input title, description, acceptance criteria, legacy modules, and attachment file paths.
2. **Offline File Ingestion**: Reads pre-created work item file `.devweave/inbox/<ID>.md`.
3. **Custom REST Script**: Configurable endpoint hook via local shell script without embedding secrets.

## 4. Normalization
Outputs standard `work-item.json` with `source.provider = "custom"` or `"manual"`.
