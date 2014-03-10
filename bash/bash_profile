alias ..='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."

alias ll='ls -l'
alias lp='ls -p'

alias jl='jobs -l'

alias apti='apt-get install'
alias apts='apt-cache search'

export EDITOR=vim
export PYTHONDONTWRITEBYTECODE=1
export PATH=$PATH:~/bin
export PAGER='less'
export PS1="\u@\h:\w$ "

function run_cmd_with_password {
    expect -c "\
    set timeout 90
    set env(TERM)
    spawn $1
    expect \"password:\"
    send $2\r
    expect eof
  "
}

function interact_cmd_with_password {
    expect -c "\
    set timeout 90
    set env(TERM)
    spawn $1
    expect \"password:\"
    send $2\r
    interact
  "
}


export PAGER='less'
export PS1="\u@\h:\w$ "

