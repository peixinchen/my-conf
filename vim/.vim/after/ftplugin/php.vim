if exists("loaded_matchit")
    let b:match_ignorecase=0
    let b:match_words =
     \  '<?:?>,'.
     \  '<?php:?>,' .
     \  '\<switch\>:\<endswitch\>,' .
     \  '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
     \  '\<while\>:\<endwhile\>,' .
     \  '\<do\>:\<while\>,' .
     \  '\<for\>:\<endfor\>,' .
     \  '\<foreach\>:\<endforeach\>,' .
     \  '(:),' .
     \  '[:],' .
     \  '{:},' .
     \  '<:>,' .
     \  '<\@<=!\[CDATA\[:]]>,'.
     \  '<\@<=!--:-->,'.
     \  '<\@<=?\k\+:?>,'.
     \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
     \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>' 
endif 
