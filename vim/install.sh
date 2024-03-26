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


vim +PluginInstall +qall


cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
