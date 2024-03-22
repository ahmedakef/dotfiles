" the first part of the file is copied from Bram Moolenaar <Bram@vim.org>, I didn't verify if they are required or not.


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
" source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

set number
"set ruler
"set is
"set hls

set nobackup
set nowritebackup
set noswapfile
"set swapfile
"set dir=~/tmp



"colorscheme monokai 

" copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

set noundofile
set clipboard=unnamed
set clipboard=unnamedplus

set background=light  " tell vim your terminal has a dark background
set expandtab         " converts tabs to spaces
set smarttab          " helps with expanding tabs to spaces (I think)



set nocompatible              " be iMproved, required
filetype off                  " required

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
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" syntac and color
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
set t_Co=256   " This is may or may not needed.
set background=light
colorscheme PaperColor "also 'night_owl_light'"

" Shortcuts "

" set Y to duplicate lines, works in visual mode as well.
nnoremap <silent> <C-d> :call setreg('+', getline('.'))<CR>o<ESC>p



" Vundle"
nnoremap <C-i> :PluginInstall<CR> :q<CR>


" NERDTree"
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" vim-airline"
let g:airline_theme='solarized' " there is also 'papercolor'
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
