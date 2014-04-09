" Last Change: 2009-06-28 12:43:54
""""""""""""""""""""""""""""""
" About Ctags
""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd             = $ctags
"let Tlist_Sort_Type             = "name" "sort by the tags name
"let Tlist_Use_Right_Window      = 1 "show the tags window as right sidebar
"let Tlist_Compart_Format        = 1 "compart type
"let Tlist_Exist_OnlyWindow      = 1 "close the tags with the only buffer
"let Tlist_File_Fold_Auto_Close  = 0 "don't close other file's tags
"let Tlist_Enable_Fold_Column    = 0 "don't show zhedieshu
"let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'
"let Tlist_Show_One_File        = 1
"let Tlist_Auto_Update           = 0
"let tlist_php_settings          = 'php;c:class;d:constant;f:function'

" -- Tagbar
let g:tagbar_width = 25

" -- cscope
if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  ""cnoreabbrev csa cs add
  ""cnoreabbrev csf cs find
  ""cnoreabbrev csk cs kill
  ""cnoreabbrev csr cs reset
  ""cnoreabbrev css cs show
  ""cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

" -- ctags
" $home/ctags.conf
function! CtagsR(language, ...)
    let cmd = $ctags . " -R --exclude=.svn --exclude=.hg --exclude=.git "
    if a:language == 'php'
      let cmd .= " --fields=+ailKSz --extra=+q --languages=".a:language 
    endif
    if a:language == 'c'
      let cmd .= " --fields=+lS --languages=".a:language
    endif
    if a:language == 'java'
      let cmd .= " --fields=+lS --languages=".a:language
    endif
    let i=0
    while i < a:0
      let cmd .= " --exclude=".a:000[i]
      let i = i+1
    endwhile
    exec "!".cmd
endfunc

:command! -nargs=+ Ctags     call CtagsR(<f-args>)
:command! -nargs=* CtagsJs   call CtagsR('javascript',<f-args>)
:command! -nargs=* CtagsPhp  call CtagsR('php',<f-args>)
:command! -nargs=* CtagsJava  call CtagsR('java',<f-args>)


" Php Syntax
" remore cr at end of lines
let PHP_removeCRwhenUnix      = 1
let php_foding                = 0
let php_strict_blocks         = 1
let php_special_vars          = 0
let php_alt_comparisions      = 0
let php_alt_arrays            = 0
let php_oldStyle              = 0
let php_fold_heredoc          = 0
let php_short_tags            = 1
let php_sql_query             = 1
let php_htmlInStrings         = 1
let php_baselib               = 1
"let php_folding               = 1
let php_special_functions     = 0
let php_alt_comparisons       = 0
let php_alt_assignByReference = 0
let php_noShortTags           = 1

" PHPDoc
function! MakePhpdoc(file)
  let cmd = "d:/webroot/cn/weiye/lib/PhpDoc/phpdoc.bat" 
  let args = " -t D:/webroot/cn/weiye/doc -o HTML:default:default"
  if a:0 == 0 || a:file == '%'
    let args .= " -f " . expand("%:p")
  elseif stridx(a:file,'.php') > 0
    let args .= " -f " . a:file
  else 
    let args .= " -d " . a:file
  endif
  exec '!' . cmd . args
endfunction

:command! -nargs=* Phpdoc silent :call MakePhpdoc(<f-args>)


" BufExplorer
let g:BufExplorerDefaultHelp = 0
let g:BufExplorerReverseSort = 1
let g:BufExplorerShowRelativePath = 1


" xml-plugin
"let xml_tag_completion_map = "<C+l>" 
let g:xml_syntax_folding=1 


" Fencview plugin
let g:fencview_autodetect=1
let g:fencview_checklines=20

" SuperTab
let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-X><C-U>"
let g:SuperTabContextFileTypeExclusions = ["wiki","txt" ]
"let g:SuperTabDefaultCompletionTypeDiscovery = [
      "\ "&completefunc:<c-x><c-u>",
      "\ "&omnifunc:<c-x><c-o>",
      "\ ]
let g:SuperTabLongestHighlight = 1

" Netrw plugin

let g:netrw_winsize         = 25
let g:netrw_altv            = 1
let g:netrw_liststyle       = 1
let g:netrw_list_hide       = "\.bak,\.ecgi"
let g:netrw_menu            = 0
let g:netrw_use_errorwindow = 0
let g:netrw_browse_split    = 2
if has("win32")
  let g:netrw_ftp_cmd         = '"' . $vim . '/program/ftp.exe"'
  let g:netrw_sftp_cmd        = '"' . $vim . '/program/putty/psftp.exe"'
  let g:netrw_scp_cmd         = '"' . $vim . '/program/putty/pscp.exe" -q -batch'
endif
"NerdTree 
map <F10> :NERDTreeToggle<CR>

"DoxygenTookit plugin
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_returnTag="@return "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="weiyezhou (leafboat@foxmail.com)"


" dbext plugin
let g:dbext_default_type   = 'mysql'
let g:dbext_default_host   = 'localhost'
let g:dbext_default_user   = 'root'

" showmark plugin
" visual mark
"
" calenadar plugin
let g:calendar_diary = $vim."/viminfo/diary"


" Showmarks
let g:showmarks_enable     = 1
let showmarks_include      = "123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let showmarks_ignore_type  = "hqm"
let showmarks_hlline_lower = 1
let showmarks_hiline_upper = 1

" vimwiki
let g:vimwiki_list = [{
      \'path':'/Users/zhqm03/workspace/codes/cn/weiye/wiki/cocm/',
      \'path_html':'/Users/zhqm03/workspace/codes/cn/weiye/wiki/cocm_html/',
      \'html_header':'',
      \'html_footer':'',
      \'maxhi':'1',
      \'index':'Index',
      \'gohome':'split',
      \'ext':'.wiki',
      \'folding':'1',
      \'syntax':'default',
      \'css_name':'cocm.css'
      \},
      \{}]
let g:vimwiki_camel_case = 0
" ex
"
let g:ex_usr_name = 'weiye'

" fuzzyfinder
let g:FufOptions = { 'Base':{}, 'Buffer':{}, 'File':{'excluded_path':'\.bak$|\.svn$'}, 'Dir':{},
            \                'MruFile':{}, 'MruCmd':{}, 'Bookmark':{},
            \                'Tag':{}, 'TaggedFile':{},
            \                'GivenFile':{}, 'GivenDir':{},
            \                'CallbackFile':{}, 'CallbackItem':{}, }

" neocomplcache
"let g:NeoComplCache_EnableAtStartup = 1 
"let g:NeoComplCache_DisableAutoComplete = 1
"
""vimpress
let g:vimpress_blog_username = 'reedboat'
let g:vimpress_enable_tags = 1
let g:vimpress_blog_url = 'http://weiye.info/xmlrpc.php'

""xptemplate
let g:xptemplate_brace_complete=1
let g:xptemplate_vars = "SPop=&SParg=&author=reedboat&email=zhqm03@gmail.com&..."

""Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_cache_dir=$tmp 

""Command-t
let g:CommandTMatchWindowAtTop = 1

""surround
""yss-
let g:surround_{char2nr('-')} = "<{\r}>"
let g:surround_{char2nr('=')} = "['\r']"
let g:surround_{char2nr('?')} = "<?php \r ?>"
let g:surround_{char2nr('!')} = "<!-- \r -->"
let g:surround_{char2nr('C')} = "<![CDATA[ \r ]]>"

""vundle
let g:vundle_log_file = $tmp . "/vundle.log"

""ctrlp
let g:ctrlp_map=',,'
set wildignore+=*.swp,*.zip,*.tgz
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git)$',
    \ 'file': '\v\.(log|jpg|png|jpeg)$',
    \}

""django
"let g:project_directory=expand('~/workspace/python-dev')
"let g:django_projects=expand('~/workspace/python-dev')
"
"" project
let g:ProjFileBrowser='off'

"UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["snippets", "bundle/UltiSnips/UltiSnips"]

"rbpt
let g:rbpt_colorpairs = [
    \ ['3',         '808000'],
    \ ['6',         '008080'],
    \ ['202',       'ff5f00'],
    \ ['11',        'ffff00'],
    \ ['13',        'ff00ff'],
    \ ['10',        '00ff00'],
    \ ['45',        '00dfff'],
    \ ['9',         'ff0000'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_bold = 0
let g:rbpt_loadcmd_toggle = 0
"augroup RainbowParentheses
    "au!
    "au VimEnter * RainbowParenthesesToggle
    "au Syntax * RainbowParenthesesLoadRound
    "au Syntax * RainbowParenthesesLoadSquare
    "au Syntax * RainbowParenthesesLoadBraces
"augroup END
