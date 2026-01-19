#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install Stow
"${SCRIPT_DIR}/install-stow.sh"
"${SCRIPT_DIR}/install-rsync.sh"

# JavaScript
"${SCRIPT_DIR}/install-javascript.sh"

# Shell
"${SCRIPT_DIR}/install-atuin.sh"
"${SCRIPT_DIR}/install-zsh.sh"

# JetBrains
"${SCRIPT_DIR}/install-jetbrains.sh"
