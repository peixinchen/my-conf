" Last Change: 2009-06-28 12:43:54
""""""""""""""""""""""""""""""
" About Ctags
""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd             = $ctags
let Tlist_Sort_Type             = "name" "sort by the tags name
let Tlist_Use_Right_Window      = 1 "show the tags window as right sidebar
let Tlist_Compart_Format        = 1 "compart type
let Tlist_Exist_OnlyWindow      = 1 "close the tags with the only buffer
let Tlist_File_Fold_Auto_Close  = 0 "don't close other file's tags
let Tlist_Enable_Fold_Column    = 0 "don't show zhedieshu
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'
let Tlist_Show_One_File        = 1
let Tlist_Auto_Update           = 0
let tlist_php_settings          = 'php;c:class;d:constant;f:function'
if exists('loaded_taglist')
  nmap <silent><F8> :TagbarToggle<cr>
endif

" Tagbar
let g:tagbar_width = 25

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

" ctags
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
" mru plugin
let MRU_File = $vim.'/viminfo/_vim_mru_files'
let MRU_Max_Entries = 50
let MRU_Exclude_Files = ''
cnoremap mru MRU

" GetLatestViewScript plugin
let g:GetLatestVimScripts_allowautoinstall=1

" Autoloadtemplate plugin
let g:TemplatePath=$vim."/vimfiles/template"

" Fencview plugin
let g:fencview_autodetect = 1
let g:fencview_checklines=20

" SuperTab
"let g:SuperTabDefaultCompletionType="context"
"let g:SuperTabContextDefaultCompletionType="<c-p>"
let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-X><C-U>"
let g:SuperTabContextFileTypeExclusions = ["wiki","txt" ]
"let g:SuperTabDefaultCompletionTypeDiscovery = [
      "\ "&completefunc:<c-x><c-u>",
      "\ "&omnifunc:<c-x><c-o>",
      "\ ]
let g:SuperTabLongestHighlight = 1

"let g:SuperTabMappingBackward='<c-/>'
" Project plugin
" plugin modified by weiye at 2008-01-08
let g:ProjectFile = $vim."/viminfo/.vimprojects"

" Netrw plugin

"let g:netrw_uid = 'apache'
"let g:netrw_passwd = 'snIhesn82*'
let g:netrw_winsize         = 25
let g:netrw_altv            = 1
let g:netrw_liststyle       = 1
let g:netrw_list_hide       = "\.bak,\.ecgi"
let g:netrw_menu            = 0
let g:netrw_use_errorwindow = 0
let g:netrw_browse_split    = 3
if has("win32")
  let g:netrw_ftp_cmd         = '"' . $vim . '/program/ftp.exe"'
  let g:netrw_sftp_cmd        = '"' . $vim . '/program/putty/psftp.exe"'
  let g:netrw_scp_cmd         = '"' . $vim . '/program/putty/pscp.exe" -q -batch'
endif
"NerdTree 
map <F10> :NERDTreeToggle<CR>

" WinMangager
let g:winManagerWindowLayout="FileExplorer,TagList|Buffer"
"let g:winManagerWidth = 25
"let g:defaultExplorer = 0
"nmap <C-w><C-b> :BottomExplorerWindow<cr> " 切换到最下面一个窗格
"nmap <C-w><C-f> :FirstExplorerWindow<cr>   " 切换到最上面一个窗格

"DoxygenTookit plugin
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_returnTag="@return "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="weiyezhou (leafboat@foxmail.com)"

" Vimtips plugin
"let g:vimtips_file="/plugins/vimtips/vimtips.txt"
"


" WebPreview plugin
""""""""""""""""""""""""""""""
let g:WebList = [
            \ {'domain' : 'http://my.weiye.cn','rootdir' : $webroot.'/cn/weiye/my'},
            \ ]
let g:BrowserList = {
            \'second'  : 'c:\Program Files\Maxthon2\Maxthon.exe' ,
            \'default' : 'c:\Program Files\Mozilla Firefox\firefox.exe' ,
            \'ie'      : 'c:\Program Files\Internet Explorer\iexplore.exe' ,
            \'ff'      : 'c:\Program Files\Mozilla Firefox\firefox.exe' ,
            \'mt'      : 'c:\Program Files\Maxthon2\Maxthon.exe'
            \}
let g:exES_WebBrowser = 'c:\\Program\\ Files\\Mozilla\\ Firefox\\firefox.exe'

" echofunc plugin
let g:loaded_echofunc = 1

" dbext plugin
let g:dbext_default_type   = 'mysql'
let g:dbext_default_host   = 'localhost'
let g:dbext_default_user   = 'weiye'
let g:dbext_default_dbname = 'jquery'

" lookupfile plugin
let g:LookupFile_MinPatLength           = 2 "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern    = 0 "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1 "保存查找历史
let g:LookupFile_AlwaysAcceptFirst      = 1 "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles          = 0 "不允许创建不存在的文件
let mapleader = ','
nnoremap <silent> <leader>lk :LookupFile<cr>
nnoremap <silent> <leader>ll :LUBufs<cr>
nnoremap <silent> <leader>lw :LUWalk<cr>
let mapleader = ''  
" lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    " Show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'
if filereadable("./filenametags")                "设置tag文件的名字
    let g:LookupFile_TagExpr = '"./filenametags"'
endif

" showmark plugin
" visual mark
"
" Tohtml plugin
let html_use_css=1
let use_xhtml=1

" Viki plugin
let g:vikiNameSuffix = ".viki"
"
" calenadar plugin
let g:calendar_diary = $vim."/viminfo/diary"

" Java Complete
autocmd Filetype java inoremap <buffer><c-s-space> <c-x><c-u><c-p>

" Vjde
let g:vjde_cfu_java_para = 0
let g:vjde_show_preview  = 0
let g:vjde_cfu_java_dot  = 0
let g:vjde_preview_gui   = 1
let g:vjde_iab_exts      = '.cpp;.c;.vim;.rb'

" Twitter

let twitvim_login_b64 = "d2VpeWV6aG91QHFxLmNvbTo0NzEyMDM = "
if has("win32")
let twitvim_curl      = $vim."\/program\/curl\/curl.exe"
endif
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

" cvim
if has("win32")
  let g:C_CCompiler     = "gcc-3.exe"
  let g:C_CplusCompiler = "g++-3.exe"
endif

" neocomplcache
"let g:NeoComplCache_EnableAtStartup = 1 
"let g:NeoComplCache_DisableAutoComplete = 1
"
""vimpress
let g:vimpress_blog_username = 'reedboat'
let g:vimpress_enable_tags = 1
let g:vimpress_blog_url = 'http://weiye.info/xmlrpc.php'

""zencoding
"let g:user_zen_expandabbr_key = '<c-a-e>' 
let g:user_zen_leader_key = '<c-y>'
let g:use_zen_complete_tag = 1 
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
let g:surround_45 = "<{\r}>"
""yss=
let g:surround_61 = "['\r']"

""vundle
let g:vundle_log_file = $tmp . "/vundle.log"

""django
"let g:project_directory=expand('~/workspace/python-dev')
"let g:django_projects=expand('~/workspace/python-dev')
