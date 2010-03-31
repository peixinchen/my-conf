" Vim compiler file for Adobe Flex 2
" Compiler: Adobe Flex 2 (mxmlc)
" Maintainer: swaroopNOSPAM@swaroopch.info
" Last Change: 2006-12-29 Fri

if exists("current_compiler")
    finish
endif
let current_compiler = "flex"

setlocal makeprg=mxmlc\ %

setlocal errorformat =%E%f(%l):\ col:\ %c\ Error:\ %m,%C,%C%.%#,%C,%Z
                     "\%W%f(%l):\ col:\ %c\ Warning:\ %m,%C,%C%.%#,%C,%Z

" vim: filetype=vim
