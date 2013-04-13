#/usr/local/bin/bash

DOTFILES_ROOT=$(cd $(dirname $0); pwd)
VIM_DOTFILES_ROOT=$DOTFILES_ROOT/vim
MAC_DOTFILES_ROOT=$DOTFILES_ROOT/mac
UBUNTU_DOTFILES_ROOT=$DOTFILES_ROOT/ubuntu

cd $DIR
git submodule init
git submodule update
rm ~/.vimrc
rm -rf ~/.vim
rm -rf ~/.zsh
rm ~/.tmux.conf
rm -rf ~/.zshrc
ln -s $VIM_DOTFILES_ROOT/.vimrc ~/
ln -s $VIM_DOTFILES_ROOT/.vim ~/
ln -s $DOTFILES_ROOT/.zsh ~/

if [ `uname` = "Darwin" ]; then
  ln -s $MAC_DOTFILES_ROOT/.tmux.conf ~/
  ln -s $MAC_DOTFILES_ROOT/.zshrc ~/
#mac用のコード
elif [ `uname` = "Linux" ]; then
  ln -s $UBUNTU_DOTFILES_ROOT/.tmux.conf ~/
  ln -s $MAC_DOTFILES_ROOT/.zshrc ~/
#Linux用のコード
fi
ln -s $VIM_DOTFILES_ROOT/.vim/neobundle/neosnippet/autoload/neosnippet/snippet/* $DOTFILES_ROOT/vim/.vim/snippets/
