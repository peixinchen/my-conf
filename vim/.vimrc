set nocompatible
syntax on

let $vim=$HOME 
let $php=system("whereis -b php|awk '{print $2}'")

set runtimepath+=~/vim-plugins/vim-addon-manager
set runtimepath+=~/vim-plugins/FuzzyFinder

set number
set history       =400
set ignorecase
set tags           =./tags,tags,./../tags,./**/tags;
set sessionoptions -=curdir
set sessionoptions +=sesdir
set cul

filetype plugin indent on
set autoindent
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set smarttab
set smartindent
au FileType html,python,vim,javascript setlocal shiftwidth=2
au FileType * setlocal ff=unix

set hidden
set encoding=utf8
set fileencodings=utf-8,gb2312,ucs-bom,cp936,big5,latin1
set termencoding=utf-8,gb2312
set laststatus=2
set cmdheight=2
set acd
set ff=unix


source $HOME/.vim/config/plugins.vim
source $HOME/.vim/config/keymapping.vim
source $HOME/.vim/config/aucmd.vim
source $HOME/.vim/config/functions.vim


"source $HOME/project.vim
"color shine
"color evening
"color darkblue
"color delek
color torte


" vim:ts=4:foldmethod=marker
