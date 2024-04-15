#!/bin/bash
set -ox pipefail


if [ -z "$DOTFILES_DIR" ]; then
    echo "Error: DOTFILES_DIR environment variable is not set."
    exit 1
fi


ln -s "$DOTFILES_DIR/zsh/alias.sh" ~/alias.sh
ln -s "$DOTFILES_DIR/zsh/plugins_configs.sh" ~/plugins_configs.sh


if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

brew install pure bat fd

if [[ "$(uname)" == "Linux" ]]; then
    sudo apt-get update
    sudo apt-get install pure bat fd
else
    brew install pure bat fd
fi
source ~/.zshrc
