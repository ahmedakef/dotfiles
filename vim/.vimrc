" Vundle Configuration
set nocompatible              " be iMproved, required for Vundle
filetype off                  " required, required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

source ~/.vim/plugins.vim

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


set rtp+=/usr/local/opt/fzf


" General
set number relativenumber
set encoding=UTF-8
set scrolloff=5
set hidden " allow to switch buffers without saving

" search
set incsearch "incremental search
set ignorecase "ignore case when searching
set hlsearch "highlight search results

" backup
set nobackup
set nowritebackup
set undofile
set undodir=~/.vim/undodir
set noswapfile

" copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" writing
set background=light  " tell vim your terminal has a dark background
set expandtab         " converts tabs to spaces
set smarttab          " helps with expanding tabs to spaces (I think)
set autoindent
set backspace=indent,eol,start


" syntax and color
if (has("termguicolors"))
        set termguicolors
endif
syntax enable
set t_Co=256   " This is may or may not needed.
set background=light
colorscheme PaperColor "also I liked 'night_owl_light'"

" Shortcuts "

let mapleader="."

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <leader>q :call ToggleQuickFix()<cr>


nnoremap <silent> <leader>m :make<CR>:redraw<CR>:copen<CR>

" next and previous buffer "
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>

" Formatting "
noremap <C-f> :Autoformat<CR>

" set ctrl-d to duplicate lines, works in visual mode as well.
"nnoremap <silent> <C-d> yyp


" Vundle"
nnoremap <C-i> :PluginInstall<CR> :q<CR>


" NERDTree"
nnoremap <C-t> :NERDTreeToggle<CR>
set guifont=JetBrainsMono_Nerd_Font:h11


" vim-airline"
let g:airline_theme='solarized' " there is also 'papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z = 'Ln %l, Col %v'


" fzf"
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>p :History<CR>
nnoremap <Space>/ :Rg<Space>
