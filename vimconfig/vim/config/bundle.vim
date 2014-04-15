filetype off
""""""""""""""""""""""""""""""""""""""""""
"" plugins base functions
""""""""""""""""""""""""""""""""""""""""""
Bundle "L9"
Bundle "cecutil"
Bundle "tlib"
Bundle "genutils"
Bundle "DfrankUtil"


""""""""""""""""""""""""""""""""""""""""""
"" plugin for core edit
""""""""""""""""""""""""""""""""""""""""""
" -- add repeat.vim to make (.) works for cs,ds,ys
Bundle 'tpope/vim-repeat' 
Bundle 'tpope/vim-surround'
Bundle 'matchit.zip'
Bundle 'Lokaltog/vim-easymotion'

"Bundle 'Align'
"replace algin
"godlygeek/tabular
Bundle 'junegunn/vim-easy-align'

Bundle 'dimasg/vim-mark'
Bundle "EasyGrep"
Bundle "kana/vim-textobj-user"
Bundle "kana/vim-textobj-line"
Bundle "kana/vim-textobj-indent"
Bundle "kana/vim-textobj-function"



""""""""""""""""""""""""""""""""""""""""""
"" for auto complete
""""""""""""""""""""""""""""""""""""""""""
Bundle "ervandew/supertab"
"YCM can replace others
"Bundle "Valloric/YouCompleteMe"
Bundle "AutoComplPop"
"Bundle "Shougo/neocomplete.vim"
Bundle "Shougo/neocompletecache.vim"
Bundle "CmdlineComplete"

Bundle 'SirVer/ultisnips'

"Bundle 'honza/vim-snippets'
Bundle 'mattn/emmet-vim'
"textmate like snipptes AutoComplete plugins
"Bundle "xptemplate"
"Bundle "snipMate"
""Bundle "ZenCoding.vim"
"" more powerful than zencoding written in python
"Bundle "rstacruz/sparkup" {'rtp' : 'vim/'}
Bundle "word_complete.vim"










""""""""""""""""""""""""""""""""""""""""""
"" for filetype 
""""""""""""""""""""""""""""""""""""""""""
Bundle "c.vim"
"Bundle 'Markdown'
Bundle "hallison/vim-markdown"
Bundle "xml.vim"
Bundle 'JSON.vim'

"" -- web
Bundle "JavaScript-Indent"
Bundle 'vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jslint.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'haml.zip'
Bundle "jsbeautify"

"" -- php
"Bundle 'tagbar-phpctags'

"" -- python
"Bundle "vim-django"
""Bundle "kevinw/pyflakes-vim"
Bundle "indentpython.vim"




""""""""""""""""""""""""""""""""""""""""""
"" network tools 
""""""""""""""""""""""""""""""""""""""""""
Bundle "UltraBlog"
" -- edit encrypted files
Bundle 'openssl.vim'
Bundle "calendar.vim"
"Bundle "vimwiki"
Bundle "TxtBrowser"


""""""""""""""""""""""""""""""""""""""""""
"" for coding
""""""""""""""""""""""""""""""""""""""""""
" -- commentary.vim to replace nerd-commenter
Bundle 'tpope/vim-commentary'
Bundle "scrooloose/nerdcommenter"
Bundle "scrooloose/syntastic"
"Bundle 'camelcasemotion'
"use tagbar to replace taglist
Bundle "majutsushi/tagbar"

"Bundle "chazy/cscope_maps"
"Bundle 'camelcasemotion'
Bundle "FencView.vim"
Bundle "vcscommand.vim"
Bundle "tpope/vim-fugitive"
"括号显示增强
Bundle 'masukomi/rainbow_parentheses.vim'
"Bundle "PDV--phpDocumentor-for-Vim"
Bundle "tobyS/pdv"
Bundle "xuhdev/SingleCompile"


""""""""""""""""""""""""""""""""""""""""""
"" for vim native settings
""""""""""""""""""""""""""""""""""""""""""
Bundle "Lokaltog/vim-powerline"
Bundle "Vimball"


""""""""""""""""""""""""""""""""""""""""""
"" for file management and  orgnization
""""""""""""""""""""""""""""""""""""""""""
Bundle "netrw.vim"
" -- user ctrlp to replace FuzzyFinder
Bundle "kien/ctrlp.vim"
Bundle "FuzzyFinder"

"Bundle "Command-T"
Bundle 'scrooloose/nerdtree'
Bundle 'project.tar.gz'
Bundle 'oinksoft/proj.vim'


""""""""""""""""""""""""""""""""""""""""""""""""""
" test
""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'kakkyz81/evervim'



""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle "flazz/vim-colorschemes"
Bundle "altercation/vim-colors-solarized"
Bundle "molokai"


""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
"https://github.com/trending?l=vim&since=weekly
"https://github.com/search?q=stars%3A200+stars%3A%3E200&type=Repositories&ref=advsearch&l=VimL"
"Bundle "christoomey/vim-tmux-navigator"



filetype plugin indent on 
