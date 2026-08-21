#!/bin/bash

DOTFILES=$HOME/dotfiles

# シンボリックリンクを作成
ln -sf $DOTFILES/.bashrc $HOME/.bashrc
ln -sf $DOTFILES/.bash_profile $HOME/.bash_profile
ln -sf $DOTFILES/.vimrc $HOME/.vimrc
ln -sf $DOTFILES/.inputrc $HOME/.inputrc
ln -sf $DOTFILES/.gitconfig $HOME/.gitconfig

# カラースキーム用のディレクトリを作成
mkdir -p $HOME/.vim/colors

# jellybeans カラースキームをダウンロード
curl -fs -o $HOME/.vim/colors/jellybeans.vim \
https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim

# シェルを再起動（その場で全て反映）
exec "$SHELL"
