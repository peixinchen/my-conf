#!/bin/bash
alias apti='apti'
install_ruby(){
    curl -L https://get.rvm.io | bash -s stable --autolibs=3 --ruby
    gem install rails
    gem install bundler, rake, sinacha, compass, bootstrap, pry
}

install_python(){
    apti python python-pip python-virtualenv
    pip install ipython
    pip install django<5.0
}

install_php(){
    apti php5 php5-cgi php5-cli php5-fpm php5-pear php5-curl php5-dev php5-mysql
    curl -s http://getcomposer.org/installer | php
}

install_git(){
    apti git git-flow git-svn
}

install_dev(){
    apti build_essential
    install_php
    install_python
    insta_ruby
}

install_db(){
    apti sqlite3 
    apti mysql-cli mysql-server mysql-common
    apti memcache
    apti redis-server
}

install_nginx(){
    apti nginx
    nginx
}

install_operate(){
    apti tree, lsof
    apti cscope, exuberant-ctags
    apti wget, curl, openssl, w3m
    apti expect, lrzsz, tcl8.5 tcl8.5-dev
    apti strace
    apti zsh
}

install_front(){
    apti coffeescript
    apti nodejs, npm
}

install_cpp(){
    apti gcc
    apti libboost
}

usage(){
    cat > '/tmp/a.txt' << EOF
    Usage: bash $0 <command> <options>
EOF
exit;
}

if [[  $# -eq 2 ]];then
    install_nginx
else
    usage
fi
