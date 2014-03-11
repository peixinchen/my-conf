#!/bin/bash
basedir=`pwd`

function build_vim(){
  ln -s $basedir/vimfiles/vim ~/.vim
  ln -s $basedir/vimfiles/vimrc ~/.vimrc

  mkdir -p ~/.vim/bundle
  git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  vim +BundleInstall +qa
  git submodule init; 
  git submodule update

  if [[ `which rvm` ]]
  then
      if [[ -d "~/.vim/bundle/Command-T" ]]
       cd ~/.vim/bundle/Command-T/ruby/command-t/
       rvm system do ruby extconf.rb
       make
       cd - 
   fi
}

function build_bash(){
   echo 'build bash' 
   ln -s $basedir/bash/bash_profile ~/.bash_profile
   ln -s $basedir/bash/bash_alias ~/.bash_alias
   ln -s $basedir/bash/markrc ~/.markrc
   # install zsh
   cd ~
   git clone https://github.com/robbyrussell/oh-my-zsh.git 
   ln -s $basedir/bash/zshrc ~/.zshrc
   ln -s $basedir/screen/screenrc ~/.screenrc
   mkdir ~/bin
   cp $basedir/ssh.exp ~/bin/
   cp $basedir/*.sh ~/bin/
   chown +x ~/bin/*.sh ~/bin/*.exp
}


case $1 in
    vim) build_vim;;
    bash) build_bash;;
    *) usage
esac
