set rtp+=~/.vim/bundle/vundle
call vundle#begin()
filetype off
""""""""""""""""""""""""""""""""""""""""""
"" plugins base functions
""""""""""""""""""""""""""""""""""""""""""
Plugin 'L9'
Plugin 'cecutil'
Plugin 'tlib'
Plugin 'genutils'
Plugin 'DfrankUtil'


""""""""""""""""""""""""""""""""""""""""""
"" plugin for core edit
""""""""""""""""""""""""""""""""""""""""""
" -- add repeat.vim to make (.) works for cs,ds,ys
Plugin 'tpope/vim-repeat' 
Plugin 'tpope/vim-surround'
Plugin 'matchit.zip'
Plugin 'Lokaltog/vim-easymotion'

"Plugin 'Align'
"replace algin
"godlygeek/tabular
Plugin 'junegunn/vim-easy-align'

Plugin 'dimasg/vim-mark'
Plugin 'EasyGrep'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-line'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-function'



""""""""""""""""""""""""""""""""""""""""""
"" for auto complete
""""""""""""""""""""""""""""""""""""""""""
Plugin 'ervandew/supertab'
"YCM can replace others
"Plugin 'Valloric/YouCompleteMe'
Plugin 'AutoComplPop'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'CmdlineComplete'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'rizzatti/dash.vim'

Plugin 'mattn/emmet-vim'
"textmate like snipptes AutoComplete plugins
"Plugin 'xptemplate"
"Plugin 'snipMate'
""Plugin 'ZenCoding.vim'
"" more powerful than zencoding written in python
"Plugin "rstacruz/sparkup" {'rtp' : 'vim/'}
Plugin 'word_complete.vim'










""""""""""""""""""""""""""""""""""""""""""
"" for filetype 
""""""""""""""""""""""""""""""""""""""""""
Plugin 'c.vim'
"Plugin 'Markdown'
Plugin 'hallison/vim-markdown'
Plugin 'xml.vim'
Plugin 'JSON.vim'
Plugin 'fatih/vim-go'

"" -- web
Plugin 'JavaScript-Indent'
Plugin 'vim-less'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'jslint.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'haml.zip'
Plugin 'jsbeautify'

"" -- php
"Plugin 'tagbar-phpctags'

"" -- python
"Plugin 'vim-django'
""Plugin 'kevinw/pyflakes-vim'
Plugin 'indentpython.vim'




""""""""""""""""""""""""""""""""""""""""""
"" network tools 
""""""""""""""""""""""""""""""""""""""""""
Plugin 'UltraBlog'
" -- edit encrypted files
Plugin 'openssl.vim'
Plugin 'calendar.vim'
"Plugin 'vimwiki'
Plugin 'TxtBrowser'


""""""""""""""""""""""""""""""""""""""""""
"" for coding
""""""""""""""""""""""""""""""""""""""""""
" -- commentary.vim to replace nerd-commenter
Plugin 'scrooloose/syntastic'
"Plugin 'camelcasemotion'
"use tagbar to replace taglist
Plugin 'majutsushi/tagbar'

"Plugin 'chazy/cscope_maps'
"Plugin 'camelcasemotion'
Plugin 'FencView.vim'
Plugin 'vcscommand.vim'
Plugin 'tpope/vim-fugitive'
"括号显示增强
Plugin 'masukomi/rainbow_parentheses.vim'
Plugin 'xuhdev/SingleCompile'


""""""""""""""""""""""""""""""""""""""""""
"" comment, doxygen {{{
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdcommenter'
Plugin 'DoxygenToolkit.vim'
Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'
"" }}}


""""""""""""""""""""""""""""""""""""""""""
"" for vim native settings
""""""""""""""""""""""""""""""""""""""""""
Plugin 'Lokaltog/vim-powerline'
Plugin 'Vimball'


""""""""""""""""""""""""""""""""""""""""""
"" for file management and  orgnization
""""""""""""""""""""""""""""""""""""""""""
Plugin 'netrw.vim'
" -- user ctrlp to replace FuzzyFinder
Plugin 'kien/ctrlp.vim'
Plugin 'FuzzyFinder'

"Plugin 'Command-T'
Plugin 'scrooloose/nerdtree'
Plugin 'project.tar.gz'
Plugin 'oinksoft/proj.vim'
Plugin 'danro/rename.vim'


""""""""""""""""""""""""""""""""""""""""""""""""""
" test
""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'kakkyz81/evervim'



""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'molokai'


""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
"https://github.com/trending?l=vim&since=weekly
"https://github.com/search?q=stars%3A200+stars%3A%3E200&type=Repositories&ref=advsearch&l=VimL"
"Plugin 'christoomey/vim-tmux-navigator'



call vundle#end()

" vim: fdm=marker
