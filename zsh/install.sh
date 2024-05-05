#!/bin/bash
set -ox pipefail



ln -s alias.sh ~/alias.sh
ln -s plugins_configs.sh ~/plugins_configs.sh


if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

brew install pure bat fd

if [[ "$(uname)" == "Linux" ]]; then
    sudo apt-get update
    sudo apt-get install pure bat fd-find
    # installing bat
    wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb
    sudo dpkg -i bat-musl_0.24.0_amd64.deb

    # installing fzf
    wget https://github.com/junegunn/fzf/releases/download/0.50.0/fzf-0.50.0-linux_amd64.tar.gz
    tar xvf fzf-0.50.0-linux_amd64.tar.gz
    sudo cp fzf /usr/local/bin
else
    brew install pure bat fd
fi
source ~/.zshrc


# settings top edit in iTerm2
# https://github.com/junegunn/fzf/issues/164
