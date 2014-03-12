#!/bin/bash

basedir=`pwd`

function build_vim(){
  [[ ! -d ~/.vim ]] && ln -s $basedir/vimconfig/vim ~/.vim
  [[ ! -f ~/.vimrc ]] && ln -s $basedir/vimconfig/vimrc ~/.vimrc

  [[ ! -d ~/.vim/bundle ]] && mkdir -p ~/.vim/bundle
  [[ ! -d ~/.vim/bundle/vundle ]] && git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  vim +BundleInstall +qa
  git submodule init; 
  git submodule update

  if [[ `which rvm` &&  -d "~/.vim/bundle/Command-T" ]]
  then
      cd ~/.vim/bundle/Command-T/ruby/command-t/
      rvm system do ruby extconf.rb
      make
      cd - 
  fi
}

function build_bash(){
   echo 'build bash' 
   echo "create links"
   [[ ! -f ~/.bash_profile ]] && ln -s $basedir/bash/bash_profile ~/.bash_profile
   [[ ! -f ~/.bash_alias ]] && ln -s $basedir/bash/bash_alias ~/.bash_alias
   [[ ! -f ~/.markrc ]] && ln -s $basedir/bash/markrc ~/.markrc
   [[ ! -f ~/.zshrc ]] && ln -s $basedir/bash/zshrc ~/.zshrc
   [[ ! -f ~/.screenrc ]] && ln -s $basedir/screen/screenrc ~/.screenrc
   [[ ! -f ~/.gitconfig ]] && ln -s $basedir/git/gitconfig ~/.gitconfig
   echo "install zsh"
   # install zsh
   cd ~
   if [[ ! -d .oh-my-zsh ]]
   then
       git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
   fi
   [[ ! -d ~/bin ]] && mkdir ~/bin
   cp $basedir/bash/*.exp ~/bin/
   cp $basedir/bash/*.sh ~/bin/
   chmod +x ~/bin/*.sh ~/bin/*.exp
}


case $1 in
    vim) build_vim;;
    bash) build_bash;;
    *) usage
esac
