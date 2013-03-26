#!/bin/bash

install_ruby(){
    curl -L https://get.rvm.io | bash -s stable --autolibs=3 --ruby
    gem install rails
    gem install bundler, rake, sinacha, compass, bootstrap, pry
}

install_python(){
    apt-get install python python-pip python-virtualenv
    pip install ipython
    pip install django<5.0
}

install_php(){
    apt-get install php5 php5-cgi php5-cli php5-fpm php5-pear 
    curl -s http://getcomposer.org/installer | php
}

install_git(){
    apt-get install git git-flow git-svn
}

install_dev(){
    apt-get install build_essential
    install_php
    install_python
    insta_ruby
}

install_db(){
    apt-get install sqlite3 
    apt-get install mysql-cli mysql-server mysql-common
    apt-get install memcache
    apt-get install redis
}

install_nginx(){
    apt-get install nginx
    nginx
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
