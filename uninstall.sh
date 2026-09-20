#!/usr/bin/env bash
# Removes omni-models from ~/.local/bin. Never touches your OpenCode config.
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
SHARE_DIR="$HOME/.local/share/omniroute-opencode-model-manager"

if [ -f "$BIN_DIR/omni-models" ]; then
  rm -f -- "$BIN_DIR/omni-models"
  printf 'Removed %s\n' "$BIN_DIR/omni-models"
else
  printf 'Nothing to remove at %s\n' "$BIN_DIR/omni-models"
fi

if [ -d "$SHARE_DIR" ]; then
  rm -rf -- "$SHARE_DIR"
  printf 'Removed %s\n' "$SHARE_DIR"
fi

printf '\nYour OpenCode config was not touched.\n'
printf 'Backups made by omni-models (if any) remain next to your config, e.g.:\n'
printf '  ~/.config/opencode/opencode.jsonc.bak-*\n'
