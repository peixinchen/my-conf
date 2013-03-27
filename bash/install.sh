#!/bin/bash

install_ruby(){
    curl -L https://get.rvm.io | bash -s stable --autolibs=3 --ruby
    gem install rails
    gem install bundler, rake, sinacha, compass, bootstrap, pry
}

install_python(){
    apt-get install -y python python-pip python-virtualenv
    pip install ipython
    pip install django<5.0
}

install_php(){
    apt-get install -y php5 php5-cgi php5-cli php5-fpm php-pear php5-curl php5-dev php5-mysql
    if [[ ! -f /usr/bin/composer ]];then
        curl -s http://getcomposer.org/installer | php
        mv ./composer.phar /usr/bin/composer
    fi
}

install_git(){
    apt-get install -y git 
    apt-get install -y git-flow git-svn
}

install_dev(){
    apt-get install -y build_essential
    install_php
    install_python
    insta_ruby
}

install_db(){
    apt-get install -y sqlite3 
    apt-get install -y mysql-cli mysql-server mysql-common
    apt-get install -y memcache
    apt-get install -y redis-server
}

install_nginx(){
    apt-get install nginx
    nginx
}

install_shell(){
    apt-get install tree, lsof
    apt-get install cscope, exuberant-ctags
    apt-get install wget, curl, openssl, w3m
    apt-get install expect, lrzsz, tcl8.5 tcl8.5-dev
    apt-get install strace
    apt-get install zsh
}

install_front(){
    apt-get install coffeescript
    apt-get install nodejs, npm
}

install_cpp(){
    apt-get install gcc
    apt-get install libboost
}

usage(){
    echo
    echo "  Usage: bash $0 <command> <options>"
    echo "  Avaiable commands:"
    echo "      front"
    echo "      php"
    echo "      python"
    echo "      ruby"
    echo "      front"
    echo "      shell"
    echo "      git"
    echo "      db"
    echo
    exit
}

if [[  $# -eq 1 ]];then
    command=$1
    case $command in
        cpp)
            install_cpp
            ;;
        python)
            install_python
            ;;
        php)
            install_php
            ;;
        ruby)
            install_ruby;;
        shell)
            install_shell;;
        help)
            usage;;
        *)
            echo
            echo "invalid command \"$command\""
            usage
    esac
else
    echo
    echo "invalid parameters \"$@\""
    usage
fi
