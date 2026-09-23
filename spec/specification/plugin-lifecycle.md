# DevWeave Plugin Lifecycle & Update Specification

> **"Less Tokens. More Work. Lower Bill."**

## 1. Overview
DevWeave plugins operate across 6 diverse AI coding hosts (Google Antigravity, Anthropic Claude Code, GitHub Copilot, Google Gemini CLI, OpenAI Codex, and Cognition Devin). To maintain host symmetry and continuous enterprise delivery, DevWeave establishes a declarative in-place update lifecycle.

---

## 2. Update Lifecycle Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│ Developer Starts AI Coding Session (Any Host)               │
└──────────────────────────────┬──────────────────────────────┘
                               │
                ┌──────────────▼──────────────┐
                │ 24h TTL Update Cache Check  │
                │ (~/.devweave/update-cache)  │
                └──────────────┬──────────────┘
                               │
             ┌─────────────────┴─────────────────┐
             │                                   │
      [Cache Valid (<24h)]             [Expired / First Run]
             │                                   │
             ▼                                   ▼
     Instant Execution                  Fast Connectivity Check
        (0 latency)                              │
                                       ┌─────────┴─────────┐
                                       │                   │
                                   [Online]            [Offline]
                                       │                   │
                                       ▼                   ▼
                                In-Place Sync       Graceful Fallback
                                (Update Cache)      (0 Disruption)
```

---

## 3. Host Symmetry Matrix

| Host Environment | Command / Skill | In-Place Target Directory |
| :--- | :--- | :--- |
| **Google Antigravity** | `devweave-update` | `~/.gemini/config/plugins/devweave` |
| **Anthropic Claude Code** | `/devweave-update` | `~/.claude/commands` |
| **GitHub Copilot** | `@devweave /update` | `.github/copilot/prompts` |
| **Google Gemini CLI** | `gemini devweave-update` | `~/.gemini/commands` |
| **OpenAI Codex** | `$devweave update` | `~/.codex/commands` |
| **Cognition Devin** | `devweave:update` | `~/.devin/commands` |
