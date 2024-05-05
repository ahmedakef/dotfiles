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


if [[ "$(uname)" == "Linux" ]]; then
    sudo apt-get update
    # use this apt for updated environments
    # but if package manager have old versions, use the following
    # sudo apt-get install -y pure bat fd-find
    # installing bat
    wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb
    sudo dpkg -i bat-musl_0.24.0_amd64.deb

    # installing fzf
    wget https://github.com/junegunn/fzf/releases/download/0.50.0/fzf-0.50.0-linux_amd64.tar.gz
    tar xvf fzf-0.50.0-linux_amd64.tar.gz
    sudo cp fzf /usr/local/bin

    # installing fd
    wget https://github.com/sharkdp/fd/releases/download/v9.0.0/fd-musl_9.0.0_amd64.deb
    sudo dpkg -i fd-musl_9.0.0_amd64.deb
else
    brew install pure bat fd
fi


# settings to edit in iTerm2
# https://github.com/junegunn/fzf/issues/164
