" Vim color file
" Maintainer:	Hans Fugal <hans@fugal.net>
" Last Change:	$Date: 2004/06/13 19:30:30 $
" Last Change:	$Date: 2004/06/13 19:30:30 $
" URL:		http://hans.fugal.net/vim/colors/desert.vim
" Version:	$Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="desert"

hi Normal	guifg=White guibg=grey20


" syntax highlighting groups
hi Comment        term=italic    cterm=italic    gui=italic
hi Constant       term=bold      cterm=bold      gui=bold
hi Identifier       term=bold      cterm=bold      gui=bold
hi Functions       term=bold      cterm=bold      gui=bold
hi Statement       term=bold       cterm=bold      gui=bold
hi Type       term=bold       cterm=bold      gui=bold

"vim: sw=4
