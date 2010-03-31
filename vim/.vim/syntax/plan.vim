" plan plugin
" Author: Aaron Wu
" initial: 2007-06-13 星期三 
" update: 2007-06-15 星期五 
"         1. for partly finished state
"         2. update some color
" OS: windows
" install:
" put two files to the related directory.
" syntax/plan.vim
" ftdetect/plan.vim
"
" usage:
" 1. use the plan suffix of the file like: e:/list.plan
" 2. the list.plan is like that:
" 
"         * total plan                                 
"         ** work
"         [ ]     (w) work more
"         [X]     (w) work
"         ** study
"         [ ]     (s) study more
"         [X]     (s) coding for the script of plan 
"       
"         * day list
"         ** 2007-06-13 星期三 
"         [ ]     (s) stduy
"
" 3. total plan split two parts: work and study.
" use ,w to add a work item.
" use ,s to add a study item.
" use ,<space> to finish or unfinish the item.
" use ,a to partly finish or unfinish the item.
" you can use >> to change an item to sub item too.
"
" 4. day list divided by days.
" use ,d to add today title
"
" 5. the items can be sort.
" select the items, use ,so to sort.
" the unfinished is on the top.
"
" 6. folding
" the file is folded by "total plan" and "day list"
" you can use the common folding commands.
"
syn match head1 "^* .*"
syn match head2 "^*\{2} .*"
syn match head3 "^*\{3} .*"
hi head1 guifg=lightred gui=bold
hi head2 guifg=lightyellow gui=bold
hi head3 guifg=lightgreen gui=bold

setl fdm=expr
setl foldexpr=Myindent(v:lnum)
func! Myindent(lnum)
    if (strlen(matchstr(getline(v:lnum), '^*\{3} ')) != 0)
        return '>3'
    elseif (strlen(matchstr(getline(v:lnum), '^*\{2} ')) != 0)
        return '>2'
    elseif (strlen(matchstr(getline(v:lnum), '^* ')) != 0)
        return '>1'
    else
        return '='
    endif
endf

syn match finish_w "^\s*\[X\]\s\+(w).*"    "finish work plan 
syn match finish_s "^\s*\[X\]\s\+(s).*"    "finish study plan 
syn match plan_w "^\[ \]\s\+(w).*"         "unfinish work plan 
syn match plan_s "^\[ \]\s\+(s).*"         "unfinish study plan 
syn match part_w "^\s*\[-\]\s\+(w).*"      "partly finished work plan
syn match part_s "^\s*\[-\]\s\+(s).*"      "partly finished study plan
syn match sub "^\s\+\[ \].*"               "finish sub plan 
hi plan_w guifg=lightmagenta
hi plan_s guifg=lightgreen
hi finish_w guifg=grey
hi finish_s guifg=white
hi part_w guifg=darkcyan
hi part_s guifg=lightcyan
hi sub guifg=cyan
map ,<space> :call Finish()<CR>
map ,a :call PartFinish()<CR>
vmap ,so :sort<CR>
abb ,w [ ]   (w)
abb ,s [ ]   (s)
abb ,d ** <ESC>:r !date /t<CR>kJ

func! Finish()
    if match(getline('.'), '^\s*\[ \]') == -1
        exe 's/\[X\]/\[ \]/'
    else
        exe 's/\[ \]/\[X\]/'
    endif
endf

func! PartFinish()
    if match(getline('.'), '^\s*\[-\]') == -1
        exe 's/\[ \]/\[-\]/'
    else
        exe 's/\[-\]/\[ \]/'
    endif
endf
