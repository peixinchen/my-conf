set nocompatible
syntax on

let $vim=$HOME 
let $php=system("whereis -b php|awk '{print $2}'")
let $ctags='/usr/bin/ctags'


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
"set paste


source $HOME/.vim/config/plugins.vim
source $HOME/.vim/config/keymapping.vim
source $HOME/.vim/config/aucmd.vim
source $HOME/.vim/config/functions.vim

set rtp+=$HOME/.vim/bundle/vundle/ 
call vundle#rc()

let plugins=["xptemplate","UltraBlog","SuperTab", "FencView.vim", "taglist-plus", "ZenCoding.vim", "vcscommand.vim", "Vimball", 
      \"Align", "The-NERD-Commenter", "netrw.vim", "php-doc", "matchit.zip", "calendar.vim", "vimwiki", "snipMate", "surround.vim", 
      \"xml.vim", "c.vim", "TxtBrowser", "neocomplcache","L9","FuzzyFinder", "vundle", "templates.vim", "cecutil", "tlib", "genutils",
      \"word_complete.vim", "Command-T"]
for $plugin in plugins
  Bundle $plugin
endfor



"source $HOME/project.vim
"color shine
"color evening
"color darkblue
"color delek


" vim:ts=4:foldmethod=marker
