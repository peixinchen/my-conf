alias ..='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."
alias tmuxt='tmux attach -t'
alias ll='ls -l'
alias lp='ls -p'
alias jl='jobs -l'
alias jslint='~/.npm/jslint/0.1.9/package/bin/jslint.js'
alias apti='apt-get install'
alias apts='apt-cache search'
export EDITOR=vim
export PATH=~/bin:~/local/bin:$PATH
export PYTHONDONTWRITEBYTECODE=1
export PATH=$PATH:~/bin

export ONEPAGECMS_RUNMODE='devel'

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
