#!/usr/bin/env bash
# Installs omni-models into ~/.local/bin.
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
BIN_DIR="$HOME/.local/bin"
SHARE_DIR="$HOME/.local/share/omniroute-opencode-model-manager"

mkdir -p -- "$BIN_DIR"
cp -- "$SCRIPT_DIR/omni-models" "$BIN_DIR/omni-models"
chmod +x -- "$BIN_DIR/omni-models"

mkdir -p -- "$SHARE_DIR"
cp -r -- "$SCRIPT_DIR/presets" "$SHARE_DIR/presets"

printf 'Installed omni-models to %s\n' "$BIN_DIR/omni-models"
printf 'Installed presets to %s\n' "$SHARE_DIR/presets"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    printf '\n%s is not in your PATH.\n' "$BIN_DIR"
    printf 'Add this to your shell rc file (e.g. ~/.bashrc or ~/.zshrc):\n\n'
    printf '  export PATH="%s:$PATH"\n\n' "$BIN_DIR"
    ;;
esac
