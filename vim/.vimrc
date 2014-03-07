set nocompatible
syntax on

let $vim=$HOME 
let $php=system("whereis -b php|awk '{print $2}'")
let $ctags='/usr/bin/ctags'


set number
set history       =400
set ignorecase
set tags           =./tags,tags,./../tags
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
au FileType * setlocal ff=unix

set hidden
set encoding=utf8
set fileencodings=utf-8,gb2312,ucs-bom,cp936,big5,latin1
set termencoding=utf-8,gb2312
set laststatus=2
set cmdheight=2
set acd
set ff=unix
"set paste
color desert


source $HOME/.vim/config/plugins.vim
source $HOME/.vim/config/keymapping.vim
source $HOME/.vim/config/aucmd.vim
source $HOME/.vim/config/functions.vim
source $HOME/.vim/config/abbreviation.vim


set rtp+=$HOME/.vim/bundle/vundle/ 
call vundle#rc()
Bundle 'gmarik/vundle'


""""""""""""""""""""""""""""""""""""""""""
"" plugins base functions
""""""""""""""""""""""""""""""""""""""""""
Bundle "L9"
Bundle "cecutil"
Bundle "tlib"
Bundle "genutils"
Bundle "DfrankUtil"

""""""""""""""""""""""""""""""""""""""""""
"" plugins that cannot been dropped
""""""""""""""""""""""""""""""""""""""""""
""Bundle "xptemplate"
Bundle "SuperTab"
Bundle "FencView.vim"
Bundle "ZenCoding.vim"
"" more powerful than zencoding written in python
"Bundle "rstacruz/sparkup"
set rtp+=$HOME/.vim/bundle/sparkup/vim/ 
"" syntax check for many program languages
Bundle "scrooloose/syntastic"

Bundle "Align"
Bundle "The-NERD-Commenter"
Bundle "matchit.zip"
Bundle "surround.vim"
Bundle "xml.vim"
Bundle "FuzzyFinder"
Bundle "surround.vim"
Bundle "Lokaltog/vim-powerline"
Bundle "AutoComplPop"

""""""""""""""""""""""""""""""""""""""""""
"" useful plugins
""""""""""""""""""""""""""""""""""""""""""
Bundle "netrw.vim"
Bundle "UltraBlog"
Bundle "vcscommand.vim"
Bundle "Vimball"
Bundle "calendar.vim"
Bundle "vimwiki"
Bundle "snipMate"
Bundle "c.vim"
Bundle "TxtBrowser"
Bundle "neocomplcache"
Bundle "word_complete.vim"
Bundle "Command-T"
Bundle "Tagbar"
Bundle 'project.tar.gz'
Bundle "PDV--phpDocumentor-for-Vim"

""""""""""""""""""""""""""""""""""""""""""
"" test plugins
""""""""""""""""""""""""""""""""""""""""""
Bundle "Color-Sampler-Pack"
Bundle "JavaScript-Indent"
Bundle "CmdlineComplete"

""Bundle "python.vim"
""Bundle "easytags.vim"
""Bundle "undotree.vim"
""Bundle "indentpython.vim"
""Bundle "grep.vim"
""Bundle "taskpaper.vim"
""Bundle 'jslint.vim'
Bundle 'haml.zip'
""Bundle 'vimprj'

"use cp in visual mode directly in macos #Bundle "fakeclip" 
"has vsccommand with same functions 
Bundle "tpope/vim-fugitive"
""Bundle "tagbar-phpctags"
"Bundle "SingleCompile"
"Bundle "EasyMotion"
"Bundle "Proj"
"Bundle "srcExpl"
Bundle "jsbeautify"
"Bundle "chazy/cscope_maps"
"phpvim, vim-signature

"python"
Bundle "vim-django"
""Bundle "kevinw/pyflakes-vim"
Bundle "indentpython.vim"
Bundle "vim-coffee-script"
Bundle 'less'


"colors
"color shine
"color evening
"color darkblue
"color delek

if filereadable($HOME . "/project.vim")
    source $HOME/project.vim
endif
" vim:ts=4:foldmethod=marker
