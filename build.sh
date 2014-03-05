#!/bin/bash

function build_vim(){
  ln -s ~/workspace/github/my-conf/vim/.vim ~/.vim
  ln -s ~/workspace/github/my-conf/vim/.vimrc ~/.vimrc

  mkdir -p ~/.vim/bundle
  git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  vim +BundleInstall +qa
  git submodule init; git submodule update

  if [[ `which rvm` ]]
  then
       cd ~/.vim/bundle/Command-T/ruby/command-t/
       rvm system do ruby extconf.rb
       make
       cd - 
   fi
}

function build_bash(){
   echo 'build bash' 
}

function usage(){
    echo 'usage'
}

function build_default(){
    echo 'build_default'
}

case $1 in
    vim) build_vim;;
    screen) build_screen;;
    bash) build_bash;;
    *) usage
esac
