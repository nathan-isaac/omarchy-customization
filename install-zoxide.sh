#!/bin/bash

set -e

mise use --global zoxide

ZSHRC="${HOME}/.zshrc"
MARKER="# zoxide init (managed by omarchy-customization)"

if [ -f "$ZSHRC" ] && ! grep -qF "$MARKER" "$ZSHRC"; then
    cat >> "$ZSHRC" <<'EOF'

# zoxide init (managed by omarchy-customization)
# Zsh specific - check if shell is interactive
if [[ -o interactive ]]; then
    eval "$(zoxide init --cmd cd zsh)"
fi
EOF
fi
