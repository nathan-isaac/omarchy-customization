#!/bin/sh

# https://github.com/omacom-io/omarchy-zsh
# sudo pacman -S omarchy-zsh

omarchy-pkg-add omarchy-zsh
omarchy-pkg-add zsh-syntax-highlighting
omarchy-pkg-add zsh-autosuggestions
omarchy-pkg-add zsh-completions
omarchy-pkg-aur-add zsh-vi-mode
omarchy-pkg-aur-add fzf-tab-git

# omarchy-setup-zsh

ZSHRC="${HOME}/.zshrc"
MARKER="# zsh plugins (managed by omarchy-customization)"

if [ -f "$ZSHRC" ] && ! grep -qF "$MARKER" "$ZSHRC"; then
    cat >> "$ZSHRC" <<'EOF'

# zsh plugins (managed by omarchy-customization)
if [[ -o interactive ]]; then
    autoload -Uz compinit && compinit

    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh

    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
EOF
fi
