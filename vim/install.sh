#!/bin/bash
set -eo pipefail


if [ -z "$DOTFILES_DIR" ]; then
    echo "Error: DOTFILES_DIR environment variable is not set."
    exit 1
fi

mkdir -p ~/.vim/bundle

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi
ln -vfs "$DOTFILES_DIR/vim/plugins.vim" ~/.vim/plugins.vim
ln -vfs "$DOTFILES_DIR/vim/.vimrc" ~/.vimrc


if [[ "$(uname)" == "Linux" ]]; then
    sudo apt update
    # sudo apt -y install ripgrep

    # installing rg
    wget https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
    sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
    sudo apt -y install build-essential cmake vim python3-dev

else
    brew install ripgrep
fi

# heavy command, do it only once
# cd ~/.vim/bundle/YouCompleteMe
# python3 install.py --all

vim +PluginInstall +qall
