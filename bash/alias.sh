alias v='vim'
alias vp='vim +Project'
alias py='python'
alias ipy='ipython'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .4="cd ../../../.."
alias aliyun='ssh reedboat@www.hiweiye.com'
alias ll='ls -al'

alias iconvgu='iconv -f gbk -t utf-8'  #两种类型编码转换
alias iconvug='iconv -f utf-8 -t gbk'

alias tf='tail -f'  #动态查看文件变化
alias t100='tail -n 100'
alias pong='ping -c 5 '   #ping，限制
alias myip='curl ifconfig.me'

alias ls='ls --color'
alias grep="grep -nE --color"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias mkdir="mkdir -pv"
alias df="df -h"
alias free='free -m'
alias bc='bc -l'

alias gc="git commit"
alias ga="git add"
alias gs="git status"

used(){
    if [ $1 ]
    then
        history | awk '{print $2,$3,$4}' | sort | uniq -c | sort -nr | head -n $1
    else
        history | awk '{print $2,$3,$4}' | sort | uniq -c | sort -nr | head -n 10
    fi
}

goto(){ [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; } 

