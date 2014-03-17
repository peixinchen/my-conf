" Last Change: 2009-06-28 00:08:09

if exists("g:loaded_keymapping")
    finish
endif
let g:loaded_keymapping = "v100" 

" mapleader setting
if !exists("mapleader")
    let oldleader='\'
    let mapleader=','
else
    let oldleader=mapleader
    let mapleader=','
endif

" Buffers
nnoremap <silent> <leader>bp :bprev<cr>
nnoremap <silent> <leader>bn :bnext<cr>
nnoremap <silent> <leader>bl :blast<cr>
nnoremap <silent> <leader>bf :bfirst<cr>
nnoremap <silent> <leader>b3 :b #<cr>
nnoremap <silent> <leader>bd :bdelete<cr>

" Windows
nnoremap <unique> <c-k> <C-W><Up>
nnoremap <unique> <c-j> <C-W><Down>
nnoremap <unique> <c-h> <C-W><Left>
nnoremap <unique> <c-l> <C-W><Right>
nnoremap <unique> <leader>wl <C-W><Right>
nnoremap <unique> <leader>wk <C-W><Up>
nnoremap <unique> <leader>wj <C-W><Down>
nnoremap <unique> <leader>wh <C-W><Left>


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
cnoremap d <c-r>=expand('%:p:h').'/'<cr>
cnoremap p <c-r>=expand('%:p')<cr>

nnoremap <leader>cd   :cd %:p:h<CR>
"nnoremap gf :e <c-r><c-f><cr>



nnoremap <silent> <leader>rc :call SwitchToBuf($vim."/.vimrc")<cr>
nnoremap <silent> <leader>erb :call SwitchToBuf($vim."/.vim/config/bundle.vim")<cr>
nnoremap <silent> <leader>erk :call SwitchToBuf($vim."/.vim/config/keymapping.vim")<cr>
nnoremap <silent> <leader>erh :call SwitchToBuf($vim."/.vim/config/help.md")<cr>
nnoremap <silent> <leader>es :call SwitchToBuf($tmp.'/scratch.txt')<cr>
nnoremap <silent> <leader>ec :call SwitchToBuf($HOME. '/cheatsheet.md')<cr>

nnoremap <silent> <leader>nu :call ToogleOption('nu')<cr>
nnoremap <silent> <leader>sw <esc>:set wrap! <cr>0


nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<cr>



nnoremap <F11> :call ToggleFullScreen()<CR>

" Align
vnoremap <leader>al :Align 
nnoremap <leader>ac :AlignCtrl 
vnoremap <leader>a= :Align = <cr>
vnoremap <leader>a> :Align => <cr>


" vertically split and generate a previewwindow
"map <leader>w :vert split . \| wincmd p \| set previewwindow \| wincmd p \|
":vert resize 15 \| exec "normal m"<cr>



"plugins
map <leader>tb <ESC>:TagbarToggle<cr>

" Save & Exit
nnoremap <leader>qf  :q!<cr>
nnoremap <leader>qa  :qa<cr>
nnoremap <leader>wf  :w!<cr>
nnoremap <leader>zz :x<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>n :new<cr>
"autocmd! bufwritepost _vimrc source $vim/_vimrc


" Search
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>


" Spell check
nnoremap <leader>sc :setl spell spelllang=en_us

" Search in Files
nnoremap <leader>gr :grep <cword> *<cr>   
nnoremap <leader>Gr :grep <cword> %:p:h/*<cr>   
nnoremap <leader>gR :grep \b<cword>\b *<cr>
nnoremap <leader>GR :grep \b<cword>\b %:p:h/*<cr>





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
nnoremap <silent> <leader>fb :FufBuffer<CR>
nnoremap <silent> <leader>ff :FufFile<CR>
nnoremap <silent> <leader>mr :FufMruFile<CR>
nnoremap <silent> <leader>mc :FufMruCmd<CR>
nnoremap <silent> <leader>mb :FufBookmark<CR>
nnoremap <silent> <leader>ma :FufBookmarkFileAdd<CR>
nnoremap <silent> <C-p>      :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
nnoremap <silent> <C-f><C-d> :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <C-f>d     :FufDirWithFullCwd<CR>
nnoremap <silent> <C-f>D     :FufDir<CR>
nnoremap <silent> <C-f><C-t> :FufTag<CR>
nnoremap <silent> <C-f>t     :FufTag!<CR> noremap  <silent> g]         :FufTagWithCursorWord!<CR>
"nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>
nnoremap <silent> <C-f><C-j> :FufJumpList<CR>
nnoremap <silent> <C-f><C-g> :FufChangeList<CR>
nnoremap <silent> <C-f><C-q> :FufQuickfix<CR>
"vnoremap <silent> <C-f><C-b> :FufAddBookmarkAsSelectedText<CR>
nnoremap <silent> <C-f><C-e> :FufEditInfo<CR>
nnoremap <silent> <C-f><C-r> :FufRenewCache<CR>


" php 
nnoremap <leader>phd :Phpdoc %<cr>
nnoremap <Leader>phr :!php -f <c-r>=expand('%:p')<cr><cr>
nnoremap <leader>cx :Dox<cr>
nnoremap <leader>cw :DoxAuthor<cr>
nnoremap <leader>cp :call PhpDoc()<cr>


" make and run
nnoremap <Leader>pyr :!python <c-r>=expand('%:p')<cr><cr>
nnoremap <Leader>mk :make<cr>

" encode
nnoremap <leader>fv :FencView<cr>
nnoremap <leader>fu :exec "edit! ++enc=utf-8"<cr>
nnoremap <leader>fg :exec "edit! ++enc=gb18030"<cr>
nnoremap <leader>su :set fenc=utf-8<cr>

" paste
nnoremap <Leader>pa :set paste<cr>
nnoremap <Leader>np :set nopaste<cr>

"" surround
nmap <Leader>' ysiw'
nmap <Leader>" ysiw"
nmap <Leader>[ ysiw[
nmap <Leader>]' ysiw]lysiw'


""jslint
noremap <leader>jl :call JsonLint()<cr>

""diff
nnoremap <Leader>dt :diffthis<cr>
nnoremap <Leader>do :diffoff <cr>


nmap <S-CR> O<Esc>j
nnoremap Y y$
nnoremap j gj
cmap w!! %!sudo tee > /dev/null %
" use very magic pattern
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
inoremap jk <esc>
inoremap kj <esc>
cnoremap %s/ %s/\v
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

nnoremap ,hp :help<space> 
nnoremap ,hw :help<space><c-r><c-w>

nnoremap <Leader>ss :SCCompile<cr>
nnoremap <Leader>sr :SCCompileRun<cr>



let mapleader=oldleader

" svn
nnoremap <Leader>ca :VCSAdd<cr>
nnoremap <Leader>cc :VCSCommit<cr>
nnoremap <Leader>cd :VCSDiff<cr>
nnoremap <Leader>cl :VCSLog<cr>
nnoremap <Leader>cs :VCSStatus<cr>
nnoremap <Leader>cn :VCSAnnotate<cr>

vnoremap <c-insert> "*y
vnoremap cp         "*y
vnoremap <bs>  x

nmap + <c-a>
nmap - <c-x>

"" disable arrows
map <up>    <nop>
map <down>  <nop>
map <left>  <nop>
map <right> <nop>
