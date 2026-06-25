#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$REPO_DIR/bin/cmux-claude"

echo "claude-cmux-skills installer"
echo ""

chmod +x "$BIN"
echo "✓ bin/cmux-claude marked executable"

if [[ -w /usr/local/bin ]]; then
  TARGET_DIR="/usr/local/bin"
else
  TARGET_DIR="$HOME/.local/bin"
  mkdir -p "$TARGET_DIR"
fi
TARGET="$TARGET_DIR/cmux-claude"

if [[ -L "$TARGET" ]]; then
  rm "$TARGET"
fi
ln -s "$BIN" "$TARGET"
echo "✓ cmux-claude → $TARGET"

if command -v cmux-claude &>/dev/null; then
  echo "✓ cmux-claude is available globally"
  echo ""
  echo "Run 'cmux-claude install' to install all skills globally."
  echo "Run 'cmux-claude list' to see available skills."
else
  echo ""
  echo "cmux-claude was installed but $TARGET_DIR is not in your PATH."
  echo "Add this to ~/.zshrc or ~/.bashrc:"
  echo "  export PATH=\"$TARGET_DIR:\$PATH\""
fi
