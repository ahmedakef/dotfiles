#!/bin/bash
set -ox pipefail


if [ -z "$DOTFILES_DIR" ]; then
    echo "Error: DOTFILES_DIR environment variable is not set."
    exit 1
fi


ln -s "$DOTFILES_DIR/zsh/alias.sh" ~/alias.sh
