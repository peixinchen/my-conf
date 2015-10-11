if 0 | endif
if has('vim_starting')
    if &compatible 
        set nocompatible 
    endif
    set rtp+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/.bundle/'))
filetype off
 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'


""""""""""""""""""""""""""""""""""""""""""
"" plugins base functions
""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'L9'
NeoBundle 'cecutil'
NeoBundle 'tlib'
NeoBundle 'genutils'
NeoBundle 'DfrankUtil'


""""""""""""""""""""""""""""""""""""""""""
"" plugin for core edit
""""""""""""""""""""""""""""""""""""""""""
" -- add repeat.vim to make (.) works for cs,ds,ys
NeoBundle 'tpope/vim-repeat' 
NeoBundle 'tpope/vim-surround'
NeoBundle 'matchit.zip'
NeoBundle 'Lokaltog/vim-easymotion'

"NeoBundle 'Align'
"replace algin
"godlygeek/tabular
NeoBundle 'junegunn/vim-easy-align'

NeoBundle 'dimasg/vim-mark'
NeoBundle 'EasyGrep'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-function'



""""""""""""""""""""""""""""""""""""""""""
"" for auto complete
""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'ervandew/supertab'
"YCM can replace others
"NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'AutoComplPop'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'CmdlineComplete'

NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'rizzatti/dash.vim'

NeoBundle 'mattn/emmet-vim'
"textmate like snipptes AutoComplete plugins
"NeoBundle 'xptemplate"
"NeoBundle 'snipMate'
""Plugin 'ZenCoding.vim'
"" more powerful than zencoding written in python
"NeoBundle "rstacruz/sparkup" {'rtp' : 'vim/'}
NeoBundle 'word_complete.vim'










""""""""""""""""""""""""""""""""""""""""""
"" for filetype 
""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'c.vim'
"NeoBundle 'Markdown'
NeoBundle 'hallison/vim-markdown'
NeoBundle 'xml.vim'
NeoBundle 'JSON.vim'
NeoBundle 'fatih/vim-go'
"android development plugin for vim 
"
" android development
NeoBundle 'hsanson/vim-android' 
let g:android_sdk_path = '/usr/local/var/lib/android-sdk'


"NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'm2mdas/phpcomplete-extended'

"" -- web
NeoBundle 'JavaScript-Indent'
NeoBundle 'vim-less'
NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'jslint.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'haml.zip'
NeoBundle 'jsbeautify'

"" -- php
"NeoBundle 'tagbar-phpctags'

"" -- python
"NeoBundle 'vim-django'
""Plugin 'kevinw/pyflakes-vim'
NeoBundle 'indentpython.vim'




""""""""""""""""""""""""""""""""""""""""""
"" network tools 
""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'UltraBlog'
" -- edit encrypted files
NeoBundle 'openssl.vim'
NeoBundle 'calendar.vim'
"NeoBundle 'vimwiki'
NeoBundle 'TxtBrowser'


""""""""""""""""""""""""""""""""""""""""""
"" for coding
""""""""""""""""""""""""""""""""""""""""""
" -- commentary.vim to replace nerd-commenter
NeoBundle 'scrooloose/syntastic'
"NeoBundle 'camelcasemotion'
"use tagbar to replace taglist
NeoBundle 'majutsushi/tagbar'

"NeoBundle 'chazy/cscope_maps'
"NeoBundle 'camelcasemotion'
NeoBundle 'FencView.vim'
NeoBundle 'vcscommand.vim'
NeoBundle 'tpope/vim-fugitive'
"括号显示增强
NeoBundle 'masukomi/rainbow_parentheses.vim'
NeoBundle 'xuhdev/SingleCompile'


""""""""""""""""""""""""""""""""""""""""""
"" comment, doxygen {{{
NeoBundle 'tpope/vim-commentary'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'DoxygenToolkit.vim'
NeoBundle 'tobyS/vmustache'
NeoBundle 'tobyS/pdv'
"" }}}


""""""""""""""""""""""""""""""""""""""""""
"" for vim native settings
""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Vimball'


""""""""""""""""""""""""""""""""""""""""""
"" for file management and  orgnization
""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'netrw.vim'
" -- user ctrlp to replace FuzzyFinder
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'FuzzyFinder'

"NeoBundle 'Command-T'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'danro/rename.vim'

"project
NeoBundle 'reedboat/project.tar.gz'
NeoBundle 'Proj'

""""""""""""""""""""""""""""""""""""""""""""""""""
" test
""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'kakkyz81/evervim'



""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'thinkpixellab/flatland'


""""""""""""""""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""""""""""""""""
"https://github.com/trending?l=vim&since=weekly
"https://github.com/search?q=stars%3A200+stars%3A%3E200&type=Repositories&ref=advsearch&l=VimL"
"NeoBundle 'christoomey/vim-tmux-navigator'



call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" vim: fdm=marker
