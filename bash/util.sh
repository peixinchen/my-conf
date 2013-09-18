#!/bin/bash

function expect_password {
    expect -c "\
    set timeout 90
    set env(TERM)
    spawn $1
    expect \"password:\"
    send \"$password\r\"
    expect eof
  "
}
