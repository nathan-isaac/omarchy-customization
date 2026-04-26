# Todo

## Migrate `~/.zshrc` to current `omarchy-zsh` layout

The `omarchy-zsh` package layout changed. The current `~/.zshrc` (lines 4-16) loads from `/usr/share/omarchy-zsh/conf.d/` and `/usr/share/omarchy-zsh/functions/`, neither of which exists in the current package. Both `if [[ -d ... ]]` checks are false, so nothing loads — silently a no-op.

**Current (broken — does nothing):**

```zsh
# Load omarchy-zsh configuration
if [[ -d /usr/share/omarchy-zsh/conf.d ]]; then
  for config in /usr/share/omarchy-zsh/conf.d/*.zsh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

# Load omarchy-zsh functions and aliases
if [[ -d /usr/share/omarchy-zsh/functions ]]; then
  for func in /usr/share/omarchy-zsh/functions/*.zsh; do
    [[ -f "$func" ]] && source "$func"
  done
fi
```

**Replace with (from `/usr/share/omarchy-zsh/templates/zshrc`):**

```zsh
# Load zsh options, keybindings, and completion
[[ -f /usr/share/omarchy-zsh/shell/zoptions ]] && source /usr/share/omarchy-zsh/shell/zoptions

# Load shared shell configuration (aliases, functions, environment, tool init)
[[ -f /usr/share/omarchy-zsh/shell/all ]] && source /usr/share/omarchy-zsh/shell/all
```

### What you'd gain

`shell/zoptions`:
- History config (HISTFILE, 32768 size, share/dedupe across sessions)
- Completion options: `MENU_COMPLETE`, `ALWAYS_TO_END`, `COMPLETE_IN_WORD`
- `AUTO_CD`, `EXTENDED_GLOB`, no beep, interactive comments
- `NO_HASH_CMDS` / `NO_HASH_DIRS` (mise needs these)
- Three fzf widgets: Ctrl+Alt+F (file picker with fd+bat preview), Ctrl+Alt+L (git log picker), Ctrl+V (env var picker)

`shell/all`: sources `envs`, `aliases`, `functions`, `inits` (not yet inspected)

### Things to watch

- `shell/zoptions` already sets `zstyle ':completion:*' matcher-list` and `list-colors` — overlaps with the same zstyles in the managed block in `~/.zshrc`. Last one wins; values are roughly equivalent, but worth diffing.
- If `shell/aliases` defines `ll` differently from `alias ll='eza -lha --group-directories-first --icons=auto'`, the user's alias (loaded later) wins — current ordering is fine.
- Inspect `shell/all` (and the four files it sources) before swapping, in case anything conflicts with `install-atuin.sh`, `install-zoxide.sh`, `install-fzf.sh` setups.

### Files

- `~/.zshrc` lines 4-16 — replace
- Reference template: `/usr/share/omarchy-zsh/templates/zshrc`
