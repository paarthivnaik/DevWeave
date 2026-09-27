---
name: devweave-setup
description: "[Setup Orchestration] Detect host tools, verify PM client CLIs and OCR engines, authorize installation, and configure secure authentication without secret storage."
---

# Devin Setup Command (`devweave-setup`)

Inspect developer environment, detect PM tool clients (Azure DevOps `az`, Jira `jira`/`acli`, GitHub `gh`, OCR `tesseract`), seek explicit human authorization before running installation commands, and configure secure authentication via OS credential vaults without writing secrets to `.devweave/`.
