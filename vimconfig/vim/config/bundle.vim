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
Bundle 'repeat.vim' 
Bundle 'surround.vim'
Bundle 'matchit.zip'
Bundle 'EasyMotion'
Bundle 'Align'
Bundle 'dimasg/vim-mark'
Bundle "EasyGrep"
Bundle "textobj-user"
Bundle "textobj-line"
Bundle "textobj-indent"



""""""""""""""""""""""""""""""""""""""""""
"" for auto complete
""""""""""""""""""""""""""""""""""""""""""
Bundle "SuperTab"
"YCM can replace others
"Bundle "Valloric/YouCompleteMe"
Bundle "AutoComplPop"
Bundle "neocomplcache"
Bundle "CmdlineComplete"

Bundle 'UltiSnips'

"Bundle 'honza/vim-snippets'
Bundle 'Emmet.vim'
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
"Bundle "vim-coffee-script"
Bundle "JavaScript-Indent"
Bundle 'vim-less'
Bundle 'coffee.vim'
Bundle 'jslint.vim'
Bundle 'vim-javascript'
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
Bundle "The-NERD-Commenter"
Bundle "scrooloose/syntastic"
"Bundle 'camelcasemotion'
"use tagbar to replace taglist
Bundle "Tagbar"

"Bundle "chazy/cscope_maps"
"Bundle 'camelcasemotion'
Bundle "FencView.vim"
Bundle "vcscommand.vim"
Bundle "tpope/vim-fugitive"
"括号显示增强
Bundle 'masukomi/rainbow_parentheses.vim'
Bundle "PDV--phpDocumentor-for-Vim"
Bundle "SingleCompile"


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
Bundle "ctrlp.vim"
Bundle "FuzzyFinder"

"Bundle "Command-T"
Bundle 'The-NERD-tree'
Bundle 'project.tar.gz'
Bundle 'oinksoft/proj.vim'


""""""""""""""""""""""""""""""""""""""""""""""""""
" test
""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'evervim'



""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle "Color-Sampler-Pack"
Bundle "altercation/vim-colors-solarized"
Bundle "molokai"


filetype plugin indent on 
