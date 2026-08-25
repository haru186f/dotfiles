#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

# OS判別
detect_os() {
    if [[ -f /etc/redhat-release ]]; then
        echo "Redhat"
    elif [[ -f /etc/debian_version ]]; then
        echo "Debian"
    else
        echo "Unknown"
    fi
}

OS_TYPE=$(detect_os)
echo "Detected OS: $OS_TYPE"

# 管理対象ファイル一覧
FILES=(
    ".bashrc"
    ".vimrc"
    ".bash_profile"
    ".inputrc"
    ".gitconfig"
)

# バックアップディレクトリ作成
mkdir -p "$BACKUP_DIR"

# バックアップとシンボリックリンク作成
for file in "${FILES[@]}"; do
    target="$HOME/$file"
    source="$DOTFILES_DIR/$file"
    backup="$BACKUP_DIR/$file"

    # Debianの場合は .bash_profile を .profile に変更
    if [[ "$file" == ".bash_profile" && "$OS_TYPE" == "Debian" ]]; then
        target="$HOME/.profile"
        backup="$BACKUP_DIR/.profile"
    fi

    # 既存ファイル（または既存リンク）が存在する場合はバックアップ
    if [[ -f "$target" || -L "$target" ]]; then
        cp -a "$target" "$backup"
        echo "Backed up: $file -> $backup"
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
