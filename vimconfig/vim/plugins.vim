if 0 | endif
if has('vim_starting')
    if &compatible 
        set nocompatible 
    endif
endif

call plug#begin(expand('~/.vim/bundle/'))
filetype off

"""install vim-plug
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

""""""""""""""""""""""""""""""""""""""""""
"" plugins base functions
""""""""""""""""""""""""""""""""""""""""""
Plug 'L9'
Plug 'cecutil'
Plug 'tlib'
Plug 'genutils'
Plug 'DfrankUtil'


""""""""""""""""""""""""""""""""""""""""""
"" plugin for core edit
""""""""""""""""""""""""""""""""""""""""""
" -- add repeat.vim to make (.) works for cs,ds,ys
Plug 'tpope/vim-repeat' 
Plug 'tpope/vim-surround'
Plug 'matchit.zip'
Plug 'Lokaltog/vim-easymotion'

"Plug 'Align'
"replace algin
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'

Plug 'dimasg/vim-mark'
Plug 'EasyGrep'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'

Plug 'ag.vim'
Plug 'mhinz/vim-grepper'



""""""""""""""""""""""""""""""""""""""""""
"" for auto complete
""""""""""""""""""""""""""""""""""""""""""
Plug 'ervandew/supertab'
"YCM can replace others
"Plug 'Valloric/YouCompleteMe'
Plug 'AutoComplPop'
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'CmdlineComplete'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rizzatti/dash.vim'

Plug 'mattn/emmet-vim'
"textmate like snipptes AutoComplete plugins
"Plug 'xptemplate"
"Plug 'snipMate'
""Plugin 'ZenCoding.vim'
"" more powerful than zencoding written in python
"Plug "rstacruz/sparkup" {'rtp' : 'vim/'}
Plug 'word_complete.vim'


""""""""""""""""""""""""""""""""""""""""""
"" for filetype 
""""""""""""""""""""""""""""""""""""""""""
Plug 'c.vim'
Plug 'plasticboy/vim-markdown'
Plug 'xml.vim'
Plug 'JSON.vim'
Plug 'fatih/vim-go'
"android development plugin for vim 
"
" android development
Plug 'hsanson/vim-android' 
let g:android_adb_tool=$ANDROID_HOME"/platform-tools/adb"
Plug 'artur-shaik/vim-javacomplete2' 
Plug 'airblade/vim-rooter' 


"Plug 'shawncplus/phpcomplete.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
"Plug 'm2mdas/phpcomplete-extended'
Plug 'spf13/PIV'

"" -- web
Plug 'JavaScript-Indent'
Plug 'vim-less'
Plug 'kchmck/vim-coffee-script'
"Plug 'jslint.vim'
Plug 'pangloss/vim-javascript'
Plug 'haml.zip'
Plug 'jsbeautify'

"" -- php
"Plug 'tagbar-phpctags'

"" -- python
"Plug 'vim-django'
""Plugin 'kevinw/pyflakes-vim'
Plug 'indentpython.vim'




""""""""""""""""""""""""""""""""""""""""""
"" network tools 
""""""""""""""""""""""""""""""""""""""""""
" -- edit encrypted files
Plug 'openssl.vim'
Plug 'calendar.vim'
"Plug 'vimwiki'
Plug 'TxtBrowser'


""""""""""""""""""""""""""""""""""""""""""
"" for coding
""""""""""""""""""""""""""""""""""""""""""
" -- commentary.vim to replace nerd-commenter
Plug 'scrooloose/syntastic'
"Plug 'camelcasemotion'
"use tagbar to replace taglist
Plug 'majutsushi/tagbar'
"Plug 'xolox/vim-easytags'
Plug 'oepn/vim-easytags' " fix dectection for universe-ctags
Plug 'xolox/vim-misc'

"Plug 'chazy/cscope_maps'
"Plug 'camelcasemotion'
Plug 'FencView.vim'
Plug 'vcscommand.vim'
Plug 'tpope/vim-fugitive'
"括号显示增强
Plug 'masukomi/rainbow_parentheses.vim'
Plug 'xuhdev/SingleCompile'
Plug 'bling/vim-airline'
Plug 'metakirby5/codi.vim'


""""""""""""""""""""""""""""""""""""""""""
"" comment, doxygen {{{
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'
Plug 'DoxygenToolkit.vim'
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
"" }}}


""""""""""""""""""""""""""""""""""""""""""
"" for vim native settings
""""""""""""""""""""""""""""""""""""""""""
Plug 'Lokaltog/vim-powerline'
Plug 'Vimball'


""""""""""""""""""""""""""""""""""""""""""
"" for file management and  orgnization
""""""""""""""""""""""""""""""""""""""""""
Plug 'netrw.vim'
" -- user ctrlp to replace FuzzyFinder
Plug 'kien/ctrlp.vim'
Plug 'FuzzyFinder'

"Plug 'Command-T'
Plug 'scrooloose/nerdtree'
Plug 'danro/rename.vim'

"project
Plug 'reedboat/project.tar.gz'
Plug 'Proj'

""""""""""""""""""""""""""""""""""""""""""""""""""
" test
""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'kakkyz81/evervim'
" 快速启用/禁用 箭头/hjkl/pageuppagedown/
"Plug 'wikitopian/hardmode' 
Plug 'takac/vim-hardtime' 
Plug 'Shougo/vimshell.vim'



""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'thinkpixellab/flatland'


""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
"https://github.com/trending?l=vim&since=weekly
"https://github.com/search?q=stars%3A200+stars%3A%3E200&type=Repositories&ref=advsearch&l=VimL"
"Plug 'christoomey/vim-tmux-navigator'



call plug#end()
filetype plugin indent on

" vim: fdm=marker
