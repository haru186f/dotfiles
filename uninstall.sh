#!/bin/bash

# シンボリックリンクを削除
rm -f $HOME/.bashrc
rm -f $HOME/.bash_profile
rm -f $HOME/.vimrc
rm -f $HOME/.inputrc
rm -f $HOME/.gitconfig

# カラースキーム用のディレクトリを削除
rm -rf $HOME/.vim/colors

# シェルを再起動（その場で全て反映）
exec "$SHELL"
