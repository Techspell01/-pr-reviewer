#!/bin/bash
# Install pr-reviewer subagent to Claude Code
# Usage: curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/pr-reviewer/main/install.sh | bash

set -e

AGENTS_DIR=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect platform
case "$(uname -s)" in
  Darwin*|Linux*) AGENTS_DIR="$HOME/.claude/agents" ;;
  MINGW*|MSYS*|CYGWIN*|Windows*) AGENTS_DIR="$HOME/.claude/agents" ;;
  *) AGENTS_DIR="$HOME/.claude/agents" ;;
esac

echo "Installing pr-reviewer to $AGENTS_DIR..."

# Create agents directory if it doesn't exist
mkdir -p "$AGENTS_DIR"

# Copy agent files
if [ -d "$SCRIPT_DIR/agents" ]; then
  cp "$SCRIPT_DIR/agents"/*.md "$AGENTS_DIR/" 2>/dev/null || true
  echo "✓ Copied agents to $AGENTS_DIR"
else
  # If running from web, download
  curl -fsSL "https://raw.githubusercontent.com/YOUR_USERNAME/pr-reviewer/main/agents/pr-reviewer.md" -o "$AGENTS_DIR/pr-reviewer.md"
  echo "✓ Downloaded pr-reviewer.md to $AGENTS_DIR"
fi

echo ""
echo "pr-reviewer installed successfully!"
echo "Usage: In Claude Code, say 'Review my changes before I open a PR'"
