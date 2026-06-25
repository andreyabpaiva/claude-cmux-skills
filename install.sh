#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$REPO_DIR/bin/cmux-claude"
TARGET="/usr/local/bin/cmux-claude"

echo "claude-cmux-skills installer"
echo ""

# Make CLI executable
chmod +x "$BIN"
echo "✓ bin/cmux-claude marked executable"

# Symlink to /usr/local/bin
if [[ -L "$TARGET" ]]; then
  rm "$TARGET"
fi
ln -s "$BIN" "$TARGET"
echo "✓ cmux-claude → $TARGET"

# Verify
if command -v cmux-claude &>/dev/null; then
  echo "✓ cmux-claude is available globally"
  echo ""
  echo "Run 'cmux-claude install' to install all skills globally."
  echo "Run 'cmux-claude list' to see available skills."
else
  echo ""
  echo "cmux-claude was installed but is not in your PATH."
  echo "Add /usr/local/bin to your PATH in ~/.zshrc or ~/.bashrc:"
  echo "  export PATH=\"/usr/local/bin:\$PATH\""
fi
