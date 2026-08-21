#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

# 管理対象ファイル一覧
FILES=(
    ".bashrc"
    ".bash_profile"
    ".vimrc"
    ".inputrc"
    ".gitconfig"
)

# バックアップディレクトリ作成
mkdir -p "$BACKUP_DIR"

# バックアップとシンボリックリンク作成
for file in "${FILES[@]}"; do
    target="$HOME/$file"
    source="$DOTFILES_DIR/$file"

    # 既存ファイル（または既存リンク）が存在する場合はバックアップ
    if [[ -f "$target" || -L "$target" ]]; then
        cp -a "$target" "$BACKUP_DIR/$file"
        echo "Backed up: $file -> $BACKUP_DIR/$file"
    fi

    # dotfiles側にファイルが存在すればリンク作成
    if [[ -f "$source" ]]; then
        ln -sf "$source" "$target"
        echo "Linked: $source -> $target"
    else
        echo "Warning: $source does not exist. Skipped."
    fi
done

# Vimカラースキーム用のディレクトリ作成とダウンロード
mkdir -p "$HOME/.vim/colors"
curl -fsSL -o "$HOME/.vim/colors/jellybeans.vim" \
    https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim

echo "Setup completed successfully!"
exec "$SHELL"
