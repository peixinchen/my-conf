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
"" plugin for core functions
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

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsSnippetDirectories=["snippets", "bundle/ultisnips/UltiSnips"]
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
"" for coding and project
""""""""""""""""""""""""""""""""""""""""""
" -- commentary.vim to replace nerd-commenter
Bundle 'tpope/vim-commentary'
Bundle "The-NERD-Commenter"
Bundle "scrooloose/syntastic"
"Bundle 'camelcasemotion'
"use tagbar to replace taglist
Bundle "Tagbar"
Bundle 'vimprj'
"Bundle "chazy/cscope_maps"







""""""""""""""""""""""""""""""""""""""""""
"" for filetype 
""""""""""""""""""""""""""""""""""""""""""
Bundle "c.vim"
Bundle 'Markdown'
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
Bundle "vimwiki"
Bundle "TxtBrowser"


""""""""""""""""""""""""""""""""""""""""""
"" for coding
""""""""""""""""""""""""""""""""""""""""""
Bundle "The-NERD-Commenter"
Bundle "scrooloose/syntastic"
"Bundle 'camelcasemotion'
Bundle "FencView.vim"
Bundle "vcscommand.vim"
Bundle "tpope/vim-fugitive"
"括号显示增强
Bundle 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0



""""""""""""""""""""""""""""""""""""""""""
"" for vim native settings
""""""""""""""""""""""""""""""""""""""""""
Bundle "Lokaltog/vim-powerline"
Bundle "Vimball"


""""""""""""""""""""""""""""""""""""""""""
"" for file structure
""""""""""""""""""""""""""""""""""""""""""
Bundle "netrw.vim"
" -- user ctrlp to replace FuzzyFinder
Bundle "ctrlp.vim"
Bundle "FuzzyFinder"

"Bundle "Command-T"
"Bundle "Tagbar"
Bundle 'project.tar.gz'
Bundle "PDV--phpDocumentor-for-Vim"


""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle "Color-Sampler-Pack"
Bundle "altercation/vim-colors-solarized"
Bundle "molokai"


filetype plugin indent on 
