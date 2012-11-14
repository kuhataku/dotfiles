#/usr/local/bin/bash

DOTFILES_ROOT=`pwd`
VIM_DOTFILES_ROOT=$DOTFILES_ROOT/vim
MAC_DOTFILES_ROOT=$DOTFILES_ROOT/mac
UBUNTU_DOTFILES_ROOT=$DOTFILES_ROOT/ubuntu

ln -s $VIM_DOTFILES_ROOT/.vimrc ~/
ln -s $VIM_DOTFILES_ROOT/.vim ~/
ln -s $DOTFILES_ROOT/.zsh ~/

if [ `uname` = "Darwin" ]; then
  ln -s $MAC_DOTFILES_ROOT/.tmux.conf ~/
  ln -s $MAC_DOTFILES_ROOT/.zshrc ~/
#mac用のコード
elif [ `uname` = "Linux" ]; then
  ln -s $UBUNTU_DOTFILES_ROOT/.tmux.conf ~/
  ln -s $UBUNTU_DOTFILES_ROOT/.zshrc ~/
#Linux用のコード
fi
