#!/bin/bash
set -ox pipefail


if [ -z "$DOTFILES_DIR" ]; then
    echo "Error: DOTFILES_DIR environment variable is not set."
    exit 1
fi

mkdir -p ~/.vim/bundle

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi
ln -s "$DOTFILES_DIR/vim/plugins.vim" ~/.vim/plugins.vim
ln -s "$DOTFILES_DIR/vim/.vimrc" ~/.vimrc


if [[ "$(uname)" == "Linux" ]]; then
    sudo apt update
    sudo apt install ripgrep
    sudo apt install build-essential cmake vim python3-dev

else
    brew install ripgrep
fi
vim +PluginInstall +qall

# heavy command, do it only once
# cd ~/.vim/bundle/YouCompleteMe
# python3 install.py --all
