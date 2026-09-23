#!/usr/bin/env bash
# DevWeave Autonomous In-Place Plugin Updater & 24h TTL Daily Check
# Updates DevWeave plugins across all 6 AI coding hosts in-place from remote source.
# Updates both user-global host directories and local project repositories automatically.

set -e

SOURCE_REPO="${1:-https://github.com/paarthivnaik/DevWeave.git}"
TARGET_REF="${2:-latest}"
FORCE="${3:-false}"

CACHE_DIR="$HOME/.devweave"
CACHE_FILE="$CACHE_DIR/update-cache.json"

mkdir -p "$CACHE_DIR"

NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
SHOULD_CHECK=false

if [ "$FORCE" = "true" ] || [ ! -f "$CACHE_FILE" ]; then
    SHOULD_CHECK=true
else
    # Check if last check was > 24 hours ago
    LAST_CHECK=$(grep -o '"last_check_timestamp": "[^"]*' "$CACHE_FILE" | cut -d'"' -f4 || true)
    if [ -z "$LAST_CHECK" ]; then
        SHOULD_CHECK=true
    else
        # 86400 seconds = 24 hours
        LAST_EPOCH=$(date -d "$LAST_CHECK" +%s 2>/dev/null || date -j -f "%Y-%m-%dT%H:%M:%SZ" "$LAST_CHECK" +%s 2>/dev/null || echo 0)
        NOW_EPOCH=$(date +%s)
        DIFF=$((NOW_EPOCH - LAST_EPOCH))
        if [ "$DIFF" -ge 86400 ]; then
            SHOULD_CHECK=true
        fi
    fi
fi

if [ "$SHOULD_CHECK" = "false" ]; then
    exit 0
fi

echo -e "\033[0;36m🔍 Checking for latest DevWeave release (source: $SOURCE_REPO)...\033[0m"

# Test internet connectivity with 2s timeout
if ! nc -z -w 2 github.com 443 2>/dev/null && ! curl -s --connect-timeout 2 -I https://github.com >/dev/null 2>&1; then
    echo -e "\033[0;33m[DevWeave] Offline or remote unreachable. Using cached plugin version.\033[0m"
    exit 0
fi

TEMP_CLONE=$(mktemp -d /tmp/devweave-update-XXXXXX)

cleanup() {
    rm -rf "$TEMP_CLONE"
}
trap cleanup EXIT

if [ "$TARGET_REF" = "latest" ] || [ -z "$TARGET_REF" ]; then
    git clone --depth 1 "$SOURCE_REPO" "$TEMP_CLONE" >/dev/null 2>&1
else
    git clone --depth 1 --branch "$TARGET_REF" "$SOURCE_REPO" "$TEMP_CLONE" >/dev/null 2>&1 || git clone --depth 1 "$SOURCE_REPO" "$TEMP_CLONE" >/dev/null 2>&1
fi

if [ -d "$TEMP_CLONE/plugins" ]; then
    # 1. Antigravity Global Plugin
    if [ -d "$HOME/.gemini/config/plugins/devweave" ]; then
        cp -r "$TEMP_CLONE/plugins/antigravity/"* "$HOME/.gemini/config/plugins/devweave/" 2>/dev/null || true
    fi

    # 2. Claude Code Global Commands & Plugin
    if [ -d "$HOME/.claude/commands" ]; then
        cp -r "$TEMP_CLONE/plugins/claude/commands/"* "$HOME/.claude/commands/" 2>/dev/null || true
    fi
    if [ -d "$HOME/.claude/plugins/devweave" ]; then
        cp -r "$TEMP_CLONE/plugins/claude/"* "$HOME/.claude/plugins/devweave/" 2>/dev/null || true
    fi

    # 3. Gemini CLI Global Commands & Plugin
    if [ -d "$HOME/.gemini/commands" ]; then
        cp -r "$TEMP_CLONE/plugins/gemini/commands/"* "$HOME/.gemini/commands/" 2>/dev/null || true
    fi
    if [ -d "$HOME/.gemini/plugins/devweave" ]; then
        cp -r "$TEMP_CLONE/plugins/gemini/"* "$HOME/.gemini/plugins/devweave/" 2>/dev/null || true
    fi

    # 4. Local Project Workspace Updating (if executed inside a repo)
    if [ -d "./.agents/plugins/devweave" ]; then
        cp -r "$TEMP_CLONE/plugins/antigravity/"* "./.agents/plugins/devweave/" 2>/dev/null || true
        echo -e "\033[0;36m📦 Updated local workspace DevWeave plugin at .agents/plugins/devweave\033[0m"
    fi
    if [ -d "./.github/prompts" ]; then
        cp -r "$TEMP_CLONE/plugins/copilot/prompts/"* "./.github/prompts/" 2>/dev/null || true
        echo -e "\033[0;36m📦 Updated local workspace Copilot prompts at .github/prompts\033[0m"
    fi

    # Save cache file
    cat <<EOF > "$CACHE_FILE"
{
  "last_check_timestamp": "$NOW",
  "source_repo": "$SOURCE_REPO",
  "target_ref": "$TARGET_REF",
  "status": "UP_TO_DATE"
}
EOF

    echo -e "\033[0;32m✨ DevWeave plugins updated successfully to latest release.\033[0m"
fi

