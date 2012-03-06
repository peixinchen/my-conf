" Last Change: 2009-06-28 00:08:09
" mapleader setting
let oldleader=mapleader 
let mapleader= ","
" Buffers
nnoremap <silent> <leader>bp :bprev<cr>
nnoremap <silent> <leader>bn :bnext<cr>
nnoremap <silent> <leader>bl :blast<cr>
nnoremap <silent> <leader>bf :bfirst<cr>
nnoremap <silent> <leader>b3 :b #<cr>
nnoremap <silent> <leader>bd :bdelete<cr>

"nnoremap <leader>mb :MiniBufExplorer<cr>

" Windows
nnoremap <unique> <c-k> <C-W><Up>
nnoremap <unique> <c-j> <C-W><Down>
nnoremap <unique> <c-h> <C-W><Left>
nnoremap <unique> <c-l> <C-W><Right>
nnoremap <unique> <leader>wl <C-W><Right>
nnoremap <unique> <leader>wk <C-W><Up>
nnoremap <unique> <leader>wj <C-W><Down>
nnoremap <unique> <leader>wh <C-W><Left>

inoremap <unique> <c-h> <Left>
inoremap <unique> <c-l> <Right>

nnoremap <unique> <c-x> :q<cr>
nnoremap <c-tab> :bn<cr>
nnoremap <c-s-tab> :bp<cr>
nnoremap  <leader>be :BufExplorer<cr>

" Tabs 
nnoremap <leader>tn   :tabnew <CR>
nnoremap g0 :tabfirst <cr>
nnoremap g$ :tablast <cr>

" Quickfix
nnoremap <silent> <leader>ms :w<cr>:make %<cr>
nnoremap <silent> <leader>qo :cw<cr>
nnoremap <silent> <leader>ql :cl<cr>
nnoremap <silent> <leader>qn :cn<cr>
nnoremap <silent> <leader>qp :cp<cr>



" Paths & File
cnoremap 1 <c-r>=expand('%:p:h').'/'<cr>
cnoremap 2 <c-r>=expand('%:p:t')<cr>
cnoremap 3 <c-r>=expand('%:p')<cr>
cnoremap 4 <c-r>=expand('%:p:t:r')<cr>

nnoremap <leader>ss   :so %<CR>
nnoremap <leader>cd   :cd %:p:h<CR>
nnoremap gf :e <c-r><c-f><cr>
nnoremap <leader>nf :new <c-r><c-f><cr>

nnoremap <leader>zz :x<cr>

nnoremap <silent> <leader>rc :call SwitchToBuf($vim."/.vimrc")<cr>
nnoremap <silent> <leader>ec :call SwitchToBuf($trash.'/scratch.txt')<cr>

nnoremap <silent> <leader>nu :call ToogleOption('nu')<cr>
inoremap <silent> <leader>sw <esc>:set wrap! <cr>0


nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<cr>



nnoremap <F11> :call ToggleFullScreen()<CR>

" Align
vnoremap <leader>al :Align 
nnoremap <leader>ac :AlignCtrl 


" vertically split and generate a previewwindow
"map <leader>w :vert split . \| wincmd p \| set previewwindow \| wincmd p \|
":vert resize 15 \| exec "normal m"<cr>


""""""""""""""""""""""""""""""
".html
""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.html 
            \inoremap <buffer> <s-cr> <br /><cr> |
            \nnoremap <buffer> <leader><Space> i&nbsp;<esc>


"Key mapping
inoremap <C-CR> <C-P>
inoremap <expr> <C-J> pumvisible()?"\<C-N>":"\<C-X><C-O>"
inoremap <expr> <C-K> pumvisible()?"\<C-P>":"\<C-K>"
inoremap <expr> <C-U> pumvisible()?"\<C-E>":"\<C-U>"


"plugins
map <F12> <ESC>:Tlist<CR>^Wh^Ws:VTreeExplore<CR>:set nonu<CR>^Wl
map <leader>tl <ESC>:Tlist<CR>^Wh^Ws:VTreeExplore<CR>:set nonu<CR>^Wl
map <leader>tlr <ESC>:Tlist<CR><ESC>:Tlist<CR>

function! GetFoo()
    call inputsave()
    let g:Foo=getchar()
    if(g:Foo>31&&g:Foo<127)
        let g:Foo=nr2char(g:Foo)
    else
        let g:Foo='';
    endif
    call inputrestore()
endfunction
nnoremap <silent> s :call GetFoo()<cr>:exe "normal a" . Foo<Esc>


" Save & Exit
nnoremap <leader>qf  :q!<cr>
nnoremap <leader>qa  :qa<cr>
nnoremap <leader>wf  :w!<cr>
"autocmd! bufwritepost _vimrc source $vim/_vimrc


nnoremap <leader>vk  :!deplate -m zh-cn %<CR>

" Search
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>


" Spell check
"nnoremap <leader>so :setl spell spelllang=en_us
"nnoremap <leader>sn ]s
"nnoremap <leader>sp [s
"nnoremap <leader>sa zg
"nnoremap <leader>s? z=
"

" Search in Files
nnoremap <leader>gr :grep <cword> *<cr>   
nnoremap <leader>Gr :grep <cword> %:p:h/*<cr>   
nnoremap <leader>gR :grep \b<cword>\b *<cr>
nnoremap <leader>GR :grep \b<cword>\b %:p:h/*<cr>



"Comments
nnoremap <leader>cx :Dox<cr>
nnoremap <leader>cw :DoxAuthor<cr>
nnoremap <leader>cp :call PhpDoc()<cr>

" Visual Block
nnoremap <leader>b1 :silent !"%"<cr> 

vnoremap <unique> < <gv
vnoremap <unique> > >gv

" Move
cnoremap <m-b> <s-Left>
cnoremap <m-f> <s-Right>

" map Up & Down to gj & gk, helpful for wrap text edit
noremap <unique> <Up> gk
noremap <unique> <Down> gj

" CamelCase
nnoremap <leader>gu gUw
nnoremap <silent><C-Left> :<C-u>cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><C-Right> :<C-u>cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><C-Left> <C-o>:cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><C-Right> <C-o>:cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%$','W')<CR>

" expand the abbrev 

nnoremap <leader>ef :call EchoFunc("<cword>")<cr>
nnoremap <leader>tr :tag <c-r>"<cr>

" vimwiki
nnoremap <leader>wo :Vimwiki2HTML<cr>
nnoremap <leader>wa :VimwikiAll2HTML<cr>
nnoremap <leader>ww :VimwikiGoHome<cr>
nnoremap <leader>wp :VimwikiGoBackWord<cr>

"fuzzyFinder
  let g:fuf_modesDisable = []
  let g:fuf_abbrevMap = {
        \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
        \   '^m0:' : [ '/mnt/d/0/', '/mnt/j/0/' ],
        \ }
let g:fuf_mrufile_maxItem = 300
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> <C-n>      :FufBuffer<CR>
nnoremap <silent> <leader>fb :FufBuffer<CR>
nnoremap <silent> <C-p>      :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
nnoremap <silent> <leader>ff :FufFile<CR>
nnoremap <silent> <C-f><C-d> :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <C-f>d     :FufDirWithFullCwd<CR>
nnoremap <silent> <C-f>D     :FufDir<CR>
nnoremap <silent> <leader>mr :FufMruFile<CR>
nnoremap <silent> <leader>mc :FufMruCmd<CR>
nnoremap <silent> <leader>mb :FufBookmark<CR>
nnoremap <silent> <leader>ma: FufAddBookmark<CR>
nnoremap <silent> <C-f><C-t> :FufTag<CR>
nnoremap <silent> <C-f>t     :FufTag!<CR>
noremap  <silent> g]         :FufTagWithCursorWord!<CR>
"nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>
nnoremap <silent> <C-f><C-j> :FufJumpList<CR>
nnoremap <silent> <C-f><C-g> :FufChangeList<CR>
nnoremap <silent> <C-f><C-q> :FufQuickfix<CR>
"vnoremap <silent> <C-f><C-b> :FufAddBookmarkAsSelectedText<CR>
nnoremap <silent> <C-f><C-e> :FufEditInfo<CR>
nnoremap <silent> <C-f><C-r> :FufRenewCache<CR>

" pdv 
nnoremap <leader>pd :Phpdoc %<cr>

inoremap jj <esc> 

" make and run
nnoremap <Leader>ru :!php -f <c-r>=expand('%:p')<cr><cr>
nnoremap <Leader>mk :make<cr>

" paste
nnoremap <Leader>pa :set paste<cr>
nnoremap <Leader>np :set nopaste<cr>

nnoremap <Leader>ne :new<cr>

" encode
nnoremap <leader>fv :FencView<cr>
nnoremap <leader>fu :exec "edit! ++enc=utf-8"<cr>
nnoremap <leader>fg :exec "edit! ++enc=gb18030"<cr>
nnoremap <leader>su :set fenc=utf-8<cr>


let mapleader=oldleader

" svn
nnoremap <Leader>ca :VCSAdd<cr>
nnoremap <Leader>cc :VCSCommit<cr>
nnoremap <leader>cf :VCSCommit!<cr>
nnoremap <Leader>cd :VCSDiff<cr>
nnoremap <Leader>cl :VCSLog<cr>
nnoremap <Leader>cu :VCSUpdate<cr>
nnoremap <Leader>cv :VCSVimDiff<cr>
nnoremap <Leader>cs :VCSStatus<cr>
nnoremap <Leader>cn :VCSAnnotate<cr>
nnoremap <Leader>cD :VCSDelete<cr>
nnoremap <Leader>cg :VCSGotoOriginal<cr>
nnoremap <Leader>cG :VCSGotoOriginal!<cr>
nnoremap <Leader>ci :VCSInfo<cr>
nnoremap <Leader>cL :VCSLock<cr>
nnoremap <Leader>cr :VCSReview<cr>
nnoremap <Leader>cU :VCSUnlock<cr>

vnoremap <c-insert> "*y


""
