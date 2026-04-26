#!/bin/bash

set -e

omarchy-pkg-add fzf

ZSHRC="${HOME}/.zshrc"
MARKER="# fzf init (managed by omarchy-customization)"

if [ -f "$ZSHRC" ] && ! grep -qF "$MARKER" "$ZSHRC"; then
    cat >> "$ZSHRC" <<'EOF'

# fzf init (managed by omarchy-customization)
# Zsh specific - check if shell is interactive
if [[ -o interactive ]]; then
    eval "$(fzf --zsh)"
fi
EOF
fi
