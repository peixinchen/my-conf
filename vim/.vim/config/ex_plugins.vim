" Last Change: 2009-06-27 13:22:38
au BufNewFile,BufEnter * set cpoptions+=d
nnoremap <unique> <Leader>bd :call exUtility#Kwbd(1)<CR>
"/////////////////////////////////////////////////////////////////////////////
" Plugin Configurations
"/////////////////////////////////////////////////////////////////////////////

" ------------------------------------------------------------------ 
" Desc: exUtility
" ------------------------------------------------------------------ 

" edit current vimentry
nnoremap <unique> <leader>ve :call exUtility#EditVimEntry ()<CR>

" map for quick add special comments
nnoremap <unique> <leader>ws :SEG<CR>
nnoremap <unique> <leader>wd :DEF<CR>
nnoremap <unique> <leader>we :SEP<CR>
nnoremap <unique> <leader>wc :DEC<CR>
nnoremap <unique> <leader>wh :HEADER<CR>

" F9:  Insert/Remove macro extend ("\") after all the lines of the selection
vnoremap <unique> <F9> :call exUtility#InsertRemoveExtend()<CR>

" F12: Insert '#if 0' and '#endif' between the selection
vnoremap <unique> <F12> :call exUtility#InsertIFZero()<CR>
nnoremap <unique> <F12> :call exUtility#RemoveIFZero()<CR>

" switch between edit and ex-plugin window
nnoremap <unique> <silent><Leader><Tab> :call exUtility#SwitchBuffer()<CR>

" close ex-plugin window when in edit window
nmap <unique> <silent><Leader><ESC> :call exUtility#SwitchBuffer()<CR><ESC>

" change the original file jump method to this one
nnoremap <unique> gf :call exUtility#QuickFileJump()<CR>

" VimTip #401: A mapping for easy switching between buffers
" DISABLE: there has a bug, in window (not fullscree) mode, some times the buffer will jump to other display screen ( if you use double screen ). { 
" nmap <silent> <C-Right> :bn!<CR>
" nmap <silent> <C-Left> :bp!<CR>
" } DISABLE end 
nnoremap <unique> <silent> <C-Right> :call exUtility#GotoBuffer('next')<CR>
nnoremap <unique> <silent> <C-Left> :call exUtility#GotoBuffer('prev')<CR>
nnoremap <unique> <silent> <C-Tab> :call exUtility#SwapToLastEditBuffer()<CR>

" map exUtility#Kwbd(1) to \bd will close buffer and keep window
nnoremap <unique> <Leader>bd :call exUtility#Kwbd(1)<CR>
nnoremap <unique> <C-F4> :call exUtility#Kwbd(1)<CR>

" quick highlight
" NOTE: only gui mode can have alt, in terminal we have to use other mapping
if has("gui_running") " gui mode
    nnoremap <unique> <silent> <a-1> :call exUtility#Highlight_Normal(1)<CR>
    nnoremap <unique> <silent> <a-2> :call exUtility#Highlight_Normal(2)<CR>
    nnoremap <unique> <silent> <a-3> :call exUtility#Highlight_Normal(3)<CR>
    nnoremap <unique> <silent> <a-4> :call exUtility#Highlight_Normal(4)<CR>

    vnoremap <unique> <silent> <a-1> :call exUtility#Highlight_Visual(1)<CR>
    vnoremap <unique> <silent> <a-2> :call exUtility#Highlight_Visual(2)<CR>
    vnoremap <unique> <silent> <a-3> :call exUtility#Highlight_Visual(3)<CR>
    vnoremap <unique> <silent> <a-4> :call exUtility#Highlight_Visual(4)<CR>

    nnoremap <unique> <silent> <a-0> :call exUtility#HighlightCancle(0)<CR>
else " terminal mode
    nnoremap <unique> <silent> <leader>h1 :call exUtility#Highlight_Normal(1)<CR>
    nnoremap <unique> <silent> <leader>h2 :call exUtility#Highlight_Normal(2)<CR>
    nnoremap <unique> <silent> <leader>h3 :call exUtility#Highlight_Normal(3)<CR>
    nnoremap <unique> <silent> <leader>h4 :call exUtility#Highlight_Normal(4)<CR>

    vnoremap <unique> <silent> <leader>h1 :call exUtility#Highlight_Visual(1)<CR>
    vnoremap <unique> <silent> <leader>h2 :call exUtility#Highlight_Visual(2)<CR>
    vnoremap <unique> <silent> <leader>h3 :call exUtility#Highlight_Visual(3)<CR>
    vnoremap <unique> <silent> <leader>h4 :call exUtility#Highlight_Visual(4)<CR>

    nnoremap <unique> <silent> <leader>h0 :call exUtility#HighlightCancle(0)<CR>
endif

nnoremap <unique> <silent> <Leader>0 :call exUtility#HighlightCancle(0)<CR>
nnoremap <unique> <silent> <Leader>1 :call exUtility#HighlightCancle(1)<CR>
nnoremap <unique> <silent> <Leader>2 :call exUtility#HighlightCancle(2)<CR>
nnoremap <unique> <silent> <Leader>3 :call exUtility#HighlightCancle(3)<CR>
nnoremap <unique> <silent> <Leader>4 :call exUtility#HighlightCancle(4)<CR>

" copy only full path name
nnoremap <unique> <silent> <leader>y1 :call exUtility#Yank( fnamemodify(bufname('%'),":p:h") )<CR>
" copy only file name
nnoremap <unique> <silent> <leader>y2 :call exUtility#Yank( fnamemodify(bufname('%'),":p:t") )<CR>
" copy full path + filename
nnoremap <unique> <silent> <leader>y3 :call exUtility#Yank( fnamemodify(bufname('%'),":p") )<CR>
" copy path + filename for code
nnoremap <unique> <silent> <leader>yb :call exUtility#YankBufferNameForCode()<CR>
" copy path for code
nnoremap <unique> <silent> <leader>yp :call exUtility#YankFilePathForCode()<CR>

" VimTip 311: Open the folder containing the currently open file
" http://vim.sourceforge.net/tip_view.php?tip_id=
" 
" Occasionally, on windows, I have files open in gvim, that the folder for 
" that file is not open. This key map opens the folder that contains the 
" currently open file. The expand() is so that we don't try to open the 
" folder of an anonymous buffer, we would get an explorer error dialog in 
" that case.
" 
if has("gui_running")
    if has("win32")
        " Open the folder containing the currently open file. Double <CR> at end
        " is so you don't have to hit return after command. Double quotes are
        " not necessary in the 'explorer.exe %:p:h' section.
        " nnoremap <silent> <C-F5> :if expand("%:p:h") != ""<CR>:!start explorer.exe %:p:h<CR>:endif<CR><CR>

        " explore the vimfile directory
        nnoremap <unique> <silent> <C-F5> :call exUtility#Yank( getcwd() . '\' . g:exES_VimfilesDirName )<CR>
        nnoremap <unique> <silent> <A-F5> :call exUtility#Explore( getcwd() . '\' . g:exES_VimfilesDirName )<CR>
        " explore the cwd directory
        nnoremap <unique> <silent> <C-F6> :call exUtility#Yank(getcwd())<CR>
        nnoremap <unique> <silent> <A-F6> :call exUtility#Explore(getcwd())<CR>
        " explore the diretory current file in
        nnoremap <unique> <silent> <C-F7> :call exUtility#Yank(expand("%:p:h"))<CR>
        nnoremap <unique> <silent> <A-F7> :call exUtility#Explore(expand("%:p:h"))<CR>
    endif
endif

" inherit
nnoremap <unique> <silent> <Leader>gv :call exUtility#ViewInheritsImage()<CR>

" mark (special) text
let g:ex_todo_keyword = 'NOTE REF EXAMPLE SAMPLE CHECK'
let g:ex_comment_lable_keyword = 'DELME TEMP MODIFY ADD KEEPME DISABLE ' " for editing
let g:ex_comment_lable_keyword .= 'DEBUG CRASH DUMMY UNUSED TESTME ' " for testing 
let g:ex_comment_lable_keyword .= 'HACK OPTME HARDCODE REFACTORING DUPLICATE REDUNDANCY ' " for refactoring

vnoremap <unique> <Leader>mk :MK 
nnoremap <unique> <Leader>mk :call exUtility#RemoveSpecialMarkText() <CR>

" add plugin we use to prevent them record as edit-buffer
let g:ex_plugin_list = ["-MiniBufExplorer-","__Tag_List__","\[Lookup File\]"] 

" default languages
let g:ex_default_langs = ['c', 'cpp', 'c#', 'java', 'shader', 'python', 'vim', 'uc', 'math', 'wiki', 'ini', 'make', 'sh', 'batch', 'debug' ] 

" set exvim language map
call exUtility#AddLangMap ( 'exvim', 'javascript', ['as'] )

" To let the extension language works correctly, you need to put toolkit/ctags/.ctags into your $HOME directory
" set ctags language map
" call exUtility#AddLangMap ( 'ctags', 'ini', ['ini'] )
" call exUtility#AddLangMap ( 'ctags', 'uc', ['uc'] )
" call exUtility#AddLangMap ( 'ctags', 'math', ['m'] )

" update custom highlights
function g:ex_CustomHighlight()

    " ======================================================== 
    " ShowMarks
    " ======================================================== 

    " For marks a-z
    hi clear ShowMarksHLl
    hi ShowMarksHLl term=bold cterm=none ctermbg=LightBlue gui=none guibg=LightBlue
    " For marks A-Z
    hi clear ShowMarksHLu
    hi ShowMarksHLu term=bold cterm=bold ctermbg=LightRed ctermfg=DarkRed gui=bold guibg=LightRed guifg=DarkRed
    " For all other marks
    hi clear ShowMarksHLo
    hi ShowMarksHLo term=bold cterm=bold ctermbg=LightYellow ctermfg=DarkYellow gui=bold guibg=LightYellow guifg=DarkYellow
    " For multiple marks on the same line.
    hi clear ShowMarksHLm
    hi ShowMarksHLm term=bold cterm=none ctermbg=LightBlue gui=none guibg=SlateBlue

    " ======================================================== 
    " MiniBufExplorer
    " ======================================================== 

    " for buffers that have NOT CHANGED and are NOT VISIBLE.
    hi MBENormal ctermbg=LightGray ctermfg=DarkGray guibg=LightGray guifg=DarkGray
    " for buffers that HAVE CHANGED and are NOT VISIBLE
    hi MBEChanged ctermbg=Red ctermfg=DarkRed guibg=Red guifg=DarkRed
    " buffers that have NOT CHANGED and are VISIBLE
    hi MBEVisibleNormal term=bold cterm=bold ctermbg=Gray ctermfg=Black gui=bold guibg=Gray guifg=Black
    " buffers that have CHANGED and are VISIBLE
    hi MBEVisibleChanged term=bold cterm=bold ctermbg=DarkRed ctermfg=Black gui=bold guibg=DarkRed guifg=Black

    " ======================================================== 
    " TagList
    " ======================================================== 

    " TagListTagName  - Used for tag names
    hi MyTagListTagName term=bold cterm=none ctermfg=Black ctermbg=DarkYellow gui=none guifg=Black guibg=#ffe4b3
    " TagListTagScope - Used for tag scope
    hi MyTagListTagScope term=NONE cterm=NONE ctermfg=Blue gui=NONE guifg=Blue 
    " TagListTitle    - Used for tag titles
    hi MyTagListTitle term=bold cterm=bold ctermfg=DarkRed ctermbg=LightGray gui=bold guifg=DarkRed guibg=LightGray 
    " TagListComment  - Used for comments
    hi MyTagListComment ctermfg=DarkGreen guifg=DarkGreen 
    " TagListFileName - Used for filenames
    hi MyTagListFileName term=bold cterm=bold ctermfg=Black ctermbg=LightBlue gui=bold guifg=Black guibg=LightBlue

    " ======================================================== 
    " special color settings 
    " ======================================================== 

    if g:colors_name == 'ex_lightgray'
        " ex plugins
        hi ex_SynSearchPattern gui=bold guifg=DarkRed guibg=Gray term=bold cterm=bold ctermfg=DarkRed ctermbg=Gray
        hi exMH_GroupNameEnable term=bold cterm=bold ctermfg=DarkRed ctermbg=Gray gui=bold guifg=DarkRed guibg=Gray
        hi exMH_GroupNameDisable term=bold cterm=bold ctermfg=Red ctermbg=DarkGray gui=bold guifg=DarkGray guibg=Gray

        " other plugins
    hi MBEVisibleNormal term=bold cterm=bold ctermbg=DarkGray ctermfg=Black gui=bold guibg=DarkGray guifg=Black
        hi MBENormal ctermbg=Gray ctermfg=DarkGray guibg=Gray guifg=DarkGray
        hi MyTagListTitle term=bold cterm=bold ctermfg=DarkRed ctermbg=Gray gui=bold guifg=DarkRed guibg=Gray 
    endif

endfunction

" ------------------------------------------------------------------ 
" Desc: exTagSelect
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>ts :ExtsSelectToggle<CR>
nnoremap <unique> <silent> <Leader>tg :ExtsGoDirectly<CR>

nnoremap <unique> <silent> <Leader>] :ExtsGoDirectly<CR>

let g:exTS_backto_editbuf = 0
let g:exTS_close_when_selected = 1
let g:exTS_window_direction = 'bel'

" ------------------------------------------------------------------ 
" Desc: exGlobalSearch
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>gs :ExgsSelectToggle<CR>
nnoremap <unique> <silent> <Leader>gq :ExgsQuickViewToggle<CR>
nnoremap <unique> <silent> <Leader>gg :ExgsGoDirectly<CR>
nnoremap <unique> <silent> <Leader>n :ExgsGotoNextResult<CR>
nnoremap <unique> <silent> <Leader>N :ExgsGotoPrevResult<CR>
nnoremap <unique> <Leader><S-f> :GS 

let g:exGS_backto_editbuf = 0
let g:exGS_close_when_selected = 0
let g:exGS_window_direction = 'bel'
let g:exGS_auto_sort = 1
let g:exGS_lines_for_autosort = 200

" ------------------------------------------------------------------ 
" Desc: exSymbolTable
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>ss :ExslSelectToggle<CR>
nnoremap <unique> <silent> <Leader>sq :ExslQuickViewToggle<CR>
nnoremap <unique> <silent> <Leader>sg :ExslGoDirectly<CR>
" NOTE: the / can be mapped to other script ( for example exSearchComplete ), so here use nmap instead of nnoremap 
nmap <unique> <A-S-l> :ExslQuickSearch<CR>/

let g:exSL_SymbolSelectCmd = 'TS'

" ------------------------------------------------------------------ 
" Desc: exJumpStack 
" ------------------------------------------------------------------ 

"nnoremap <unique> <silent> <Leader>tt :ExjsToggle<CR>
nnoremap <unique> <silent> <Leader>tb :BackwardStack<CR>
nnoremap <unique> <silent> <Leader>tf :ForwardStack<CR>

" ------------------------------------------------------------------ 
" Desc: exCscope
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <F2> :CSIC<CR>
nnoremap <unique> <silent> <Leader>ci :CSID<CR>
nnoremap <unique> <silent> <F3> :ExcsParseFunction<CR>
nnoremap <unique> <silent> <Leader>cd :CSDD<CR>
nnoremap <unique> <silent> <Leader>cc :CSCD<CR>
nnoremap <unique> <silent> <Leader>cs :ExcsSelectToggle<CR>
nnoremap <unique> <silent> <Leader>cq :ExcsQuickViewToggle<CR>

let g:exCS_backto_editbuf = 0
let g:exCS_close_when_selected = 0
let g:exCS_window_direction = 'bel'
let g:exCS_window_width = 48

" ------------------------------------------------------------------ 
" Desc: exQuickFix
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <leader>qf :ExqfSelectToggle<CR>
nnoremap <unique> <silent> <leader>qq :ExqfQuickViewToggle<CR>

let g:exQF_backto_editbuf = 0
let g:exQF_close_when_selected = 0
let g:exQF_window_direction = 'bel'

" ------------------------------------------------------------------ 
" Desc: exMacroHighlight
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>aa :ExmhSelectToggle<CR>
nnoremap <unique> <silent> <Leader>ae :ExmhHL 1 <CR>
nnoremap <unique> <silent> <Leader>ad :ExmhHL 0 <CR>

" ------------------------------------------------------------------ 
" Desc: exProject
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <A-S-p> :EXProject<CR>
" NOTE: the / can be mapped to other script ( for example exSearchComplete ), so here use nmap instead of nnoremap 
nmap <unique> <A-S-o> :EXProject<CR>:redraw<CR>/
nnoremap <unique> <leader>ff :EXProject<CR>:redraw<CR>/\[[^\CF]*\]\c.*
nnoremap <unique> <leader>fd :EXProject<CR>:redraw<CR>/\[\CF\]\c.*
nnoremap <unique> <leader>fc :ExpjGotoCurrentFile<CR>

let g:exPJ_backto_editbuf = 1
let g:exPJ_close_when_selected = 0
let g:exPJ_window_width_increment = 50

" ------------------------------------------------------------------ 
" Desc: exMarksBrowser 
" ------------------------------------------------------------------ 

nnoremap <unique> <leader>ms :ExmbToggle<CR>

let g:exMB_backto_editbuf = 0
let g:exMB_close_when_selected = 0
let g:exMB_window_direction = 'bel'

" ------------------------------------------------------------------ 
" Desc: exEnvironmentSetting
" NOTE: The exEnvironmentSetting must put at the end of the plugin 
"       settings. It may update the default settings of plugin above
" ------------------------------------------------------------------ 

"
let g:exES_project_cmd = 'EXProject'

" NOTE: if you have different programme path and settings, pls create your own vimrc under $HOME, and define these variables by yourself.
"       And don't forget sourced this rc at the end. 
"       web browser option: 'c:\Documents\ and\ Settings\Johnny\Local\ Settings\Application Data\Google\Chrome\Application\chrome.exe'
if has("gui_running")
    if has("win32")
        let g:exES_WebBrowser = 'c:\Program Files\Mozilla Firefox\firefox.exe'
        let g:exES_ImageViewer = 'd:\exDev\IrfanView\i_view32.exe'
    elseif has("unix")
        let g:exES_WebBrowser = 'firefox'
    endif
endif

" exEnvironmentSetting post update
" NOTE: this is a post update environment function used for any custom environment update 
function g:exES_PostUpdate()

    " set lookup file plugin variables
	if exists( 'g:exES_LookupFileTag' )
        let g:LookupFile_TagExpr='"'.g:exES_LookupFileTag.'"'
    endif

	" set visual_studio plugin variables
	if exists( 'g:exES_vsTaskList' )
		let g:visual_studio_task_list = g:exES_vsTaskList
	endif
	if exists( 'g:exES_vsOutput' )
		let g:visual_studio_output = g:exES_vsOutput
	endif
	if exists( 'g:exES_vsFindResult1' )
		let g:visual_studio_find_results_1 = g:exES_vsFindResult1
	endif
	if exists( 'g:exES_vsFindResult2' )
		let g:visual_studio_find_results_2 = g:exES_vsFindResult2
	endif

    " set vimwiki
    if exists( 'g:exES_wikiHome' )
        " clear the list first
        if exists( 'g:vimwiki_list' ) && !empty(g:vimwiki_list)
            silent call remove( g:vimwiki_list, 0, len(g:vimwiki_list)-1 )
        endif

        " assign vimwiki pathes, 
        " NOTE: vimwiki need full path.
        let g:vimwiki_list = [ { 'path': fnamemodify(g:exES_wikiHome,":p"), 
                    \ 'path_html': fnamemodify(g:exES_wikiHomeHtml,":p"),
                    \ 'html_header': fnamemodify(g:exES_wikiHtmlHeader,":p") } ]

        " create vimwiki files
        call exUtility#CreateVimwikiFiles ()
    endif
endfunction

" ------------------------------------------------------------------ 
" Desc: TagList
" ------------------------------------------------------------------ 

" F4:  Switch on/off TagList
nnoremap <unique> <silent> <F4> :TlistToggle<CR>

"let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool 
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself 
let Tlist_Use_Right_Window = 1 " split to the right side of the screen 
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 0 " Close the taglist window when a file or tag is selected.
let Tlist_BackToEditBuffer = 0 " If no close on select, let the user choose back to edit buffer or not
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 40
let Tlist_Compact_Format = 1 " do not show help
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber]

" let taglist support shader language as c-like language
let tlist_hlsl_settings = 'c;d:macro;g:enum;s:struct;u:union;t:typedef;v:variable;f:function'

" ------------------------------------------------------------------ 
" Desc: MiniBufExpl
" ------------------------------------------------------------------ 

let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines) 
let g:miniBufExplModSelTarget = 1 " If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer. 
let g:miniBufExplMaxSize = 1 " <max lines: default 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers. 
" comment out this, when we open a single file by we, we don't need minibuf opened. Minibu always open in exDev mode, in EnvironmentUpdate 
" let g:miniBufExplorerMoreThanOne = 0 " Setting this to 0 will cause the MBE window to be loaded even

"let g:miniBufExplForceSyntaxEnable = 1 " There is a VIM bug that can cause buffers to show up without their highlighting. The following setting will cause MBE to
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplMapWindowNavArrows = 1

" ------------------------------------------------------------------ 
" Desc: OmniCppComplete
" ------------------------------------------------------------------ 

" set Ctrl+j in insert mode, like VS.Net
imap <unique> <C-]> <C-X><C-O>
" :inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>" 

" set completeopt as don't show menu and preview
set completeopt=menuone

" use global scope search
let OmniCpp_GlobalScopeSearch = 1

" 0 = namespaces disabled
" 1 = search namespaces in the current buffer
" 2 = search namespaces in the current buffer and in included files
let OmniCpp_NamespaceSearch = 1

" 0 = auto
" 1 = always show all members
let OmniCpp_DisplayMode = 1

" 0 = don't show scope in abbreviation
" 1 = show scope in abbreviation and remove the last column
let OmniCpp_ShowScopeInAbbr = 0

" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
" 0 = don't display prototype in abbreviation
" 1 = display prototype in abbreviation
let OmniCpp_ShowPrototypeInAbbr = 1

" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
" 0 = hide access
" 1 = show access
let OmniCpp_ShowAccess = 1

" This option can be use if you don't want to parse using namespace declarations in included files and want to add namespaces that are always used in your project.
let OmniCpp_DefaultNamespaces = ["std"]

" Complete Behaviour
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0

" When 'completeopt' does not contain "longest", Vim automatically select the first entry of the popup menu. You can change this behaviour with the OmniCpp_SelectFirstItem option.
let OmniCpp_SelectFirstItem = 0

" ------------------------------------------------------------------ 
" Desc: EnhCommentify
" ------------------------------------------------------------------ 

let g:EnhCommentifyFirstLineMode='yes'
let g:EnhCommentifyRespectIndent='yes'
let g:EnhCommentifyUseBlockIndent='yes'
let g:EnhCommentifyAlignRight = 'yes'
let g:EnhCommentifyPretty = 'yes'
let g:EnhCommentifyBindInNormal = 'no'
let g:EnhCommentifyBindInVisual = 'no'
let g:EnhCommentifyBindInInsert = 'no'

" NOTE: VisualComment,Comment,DeComment are plugin mapping(start with <Plug>), so can't use remap here
vmap <unique> <F11> <Plug>VisualComment
nmap <unique> <F11> <Plug>Comment
imap <unique> <F11> <ESC><Plug>Comment
vmap <unique> <C-F11> <Plug>VisualDeComment
nmap <unique> <C-F11> <Plug>DeComment
imap <unique> <C-F11> <ESC><Plug>DeComment

" ======================================================== 
"  add new languages for comment
" ======================================================== 

function EnhCommentifyCallback(ft)
    " add hlsl
    if a:ft == 'hlsl'
        let b:ECcommentOpen = '//'
        let b:ECcommentClose = ''
    endif
endfunction
let g:EnhCommentifyCallbackExists = 'Yes'

" ------------------------------------------------------------------ 
" Desc: ShowMarks
" ------------------------------------------------------------------ 

let g:showmarks_enable = 1
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 0 

" quick remove mark
" nmap <F9> \mh

" ------------------------------------------------------------------ 
" Desc: LookupFile 
" ------------------------------------------------------------------ 

nnoremap <unique> <A-S-i> :LUTags<CR>
nnoremap <unique> <leader>lf :LUTags<CR>
nnoremap <unique> <leader>lb :LUBufs<CR>
nnoremap <unique> <silent> <Leader>lg :LUCurWord<CR>
let g:LookupFile_TagExpr = ''
let g:LookupFile_MinPatLength = 3
let g:LookupFile_PreservePatternHistory = 0
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_AllowNewFiles = 0
let g:LookupFile_smartcase = 1
let g:LookupFile_EscCancelsPopup = 1

" ------------------------------------------------------------------ 
" Desc: VimWiki 
" ------------------------------------------------------------------ 

map <silent><unique> <Leader>wt <Plug>VimwikiTabGoHome
map <silent><unique> <Leader>wq <Plug>VimwikiUISelect
map <silent><unique> <Leader>ww <Plug>VimwikiGoHome

" vimwiki file process
au FileType vimwiki command! W call exUtility#SaveAndConvertVimwiki(0)
au FileType vimwiki command! WA call exUtility#SaveAndConvertVimwiki(1)

