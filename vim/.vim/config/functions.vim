" Last Change: 2009-06-28 13:01:53
function! TimeStamp(...)
    let sbegin = ''
    let send = ''
    if a:0 >= 1
        let sbegin = a:1.' '
    endif
    if a:0 >= 2
        let send = ' '.a:2
    endif
    let pattern = sbegin . 'Last Change: .\+'
        \. send
    let pattern = '^\s*' . pattern . '\s*$'
    let row = search(pattern, 'n')
    let now = strftime('%Y-%m-%d %H:%M:%S',
        \localtime())
    let now = sbegin . 'Last Change: '
        \. now . send
    if row == 0
        call append(0, now)
    else
        call setline(row, now)
    endif
endfunction

au BufWritePre _vimrc         call TimeStamp('"')
"au BufWritePre *.c,*.h        call TimeStamp('//')
"au BufWritePre *.cpp,*.hpp    call TimeStamp('//')
"au BufWritePre *.cxx,*.hxx    call TimeStamp('//')
"au BufWritePre *.java         call TimeStamp('//')
"au BufWritePre *.rb           call TimeStamp('#')
"au BufWritePre *.py           call TimeStamp('#')
"au BufWritePre Makefile       call TimeStamp('#')
"au BufWritePre *.php
    "\call TimeStamp('<?php //', '?>')

function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

function! CHANGE_CURR_DIR() 
    let _dir = expand("%:p:h") 
    exec "cd " . _dir 
    unlet _dir 
endfunction 

"fun LastModified() let l = line("$")
"
"    exe "1," . l . "s/[L]astModified: .*/LastModified:" .  \ strftime(" %Y %b %d %X")
"
"endfun
"
" Switch to buffer according to file name

function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "e " . a:filename
    endif
endfunction
"
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! SmartTOHtml()
    TOhtml
    try
     %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
     %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
     %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
    catch
    endtry
    exe ":write!"
    exe ":bd"
   endfunction

 function! DoMyPrint(args)
    let colorsave=g:colors_name
    color print
    exec "hardcopy ".a:args
    exec 'color '.colorsave
 endfunction

 let g:fullscreened = 1

 function! ToggleFullScreen()
    if g:fullscreened == 0
      simalt ~x
      let g:fullscreened = 1
    else 
      simalt ~r
     let g:fullscreened = 0
    endif
 endfunction


function! ToogleOption(option)
  exec "set inv" . a:option
endfunction

function! ProjectTagUpdateLookupFile()
  echo "generate lookupfile.tag"
  if filereadable(g:project_lookup_file)
    call delete(g:project_lookup_file)
  endif
  execute "cd " .  g:this_project_base_dir
  let l:lookup_tags = ["!_TAG_FILE_SORTED\t2\t\/2=foldcase\/"]

  "if has("win32")
    "let l:this_project_base_dir = substitute(g:this_project_base_dir, "/", "\\", "g") . "\\"
  "else
    let l:this_project_base_dir = g:this_project_base_dir
  "endif
  "let l:lookup_tags_file_string = system(g:project_find_program . " " .  l:this_project_base_dir . " " . g:project_find_param)
  let l:lookup_tags_file_string = system(g:project_find_program . " " .  g:project_find_param)
  let l:lookup_tags_file_list = split(l:lookup_tags_file_string, '\n')
  let l:lookup_tags_file_list = sort(l:lookup_tags_file_list)

  let l:item = ""
  let l:count = 0
  for l:item in l:lookup_tags_file_list
    let l:item = fnamemodify(l:item, ':t') . "\t" . l:item . "\t" . "1"
    let l:lookup_tags_file_list[l:count] = l:item
    let l:count = l:count + 1
  endfor
  call extend(l:lookup_tags, l:lookup_tags_file_list)
  call writefile(l:lookup_tags, g:project_lookup_file)
  echo "generate lookupfile tag done"
endfunction

"dir /B /S /A-D /ON *.fnc *.prc *.trg *.pck *.typ *.spc *.bdy *.tps *.tpb *.txt *.sql > filenametags
"dir /B /S /A-D /ON | findstr /V ".class$ .xls$ .doc$ .ppt$ .pdf$ .jpg$ .gif$ .zip$ .rar$ .jar$ .dat$ .mdb$ .dmp$ " > filenametags
let g:project_lookup_file = "./filenametags"
let g:project_find_program = "dir /B /S /A-D /ON"
let g:project_find_param = "*.php *.tpl *.html *.js *.css *.txt *.sql"
let g:this_project_base_dir = "./"
let g:LookupFile_TagExpr = '"./filenametags"'


function! g:ex_CustomHighlight()

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

endfunction

"function! SqlKeywordToUpper()
  "let keywords = [
  "'int', 'varchar', 'timestamp', 'char', 'bigint', 'tinyint',
  "'index', 'primary key', 'unique',
  "'not null', 'default', 'commment',
  "'select', 'from', 'table', 'where', 'group by', 'order by', 'limit',
  "'update', 'delete', 'insert', 'into', 'alter'
  "];
  "exec "%s/str"
"endfunction
