#!/bin/bash

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

# run_cmd_with_password "scp filename user@ip:/path" "password"
# interact_cmd_with_password "ssh user@ip" "password"
