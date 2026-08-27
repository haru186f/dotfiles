#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

# OS判別
detect_os() {
    local os_name="Unknown"

    if [[ -f /etc/redhat-release ]]; then
        os_name="Redhat"
    elif [[ -f /etc/debian_version ]]; then
        os_name="Debian"
    fi

    if [[ -n "$WSL_DISTRO_NAME" ]]; then
        os_name="$os_name (WSL)"
    fi

    echo "$os_name"
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
    if [[ "$file" == ".bash_profile" && "$OS_TYPE" =~ Debian ]]; then
        target="$HOME/.profile"
        backup="$BACKUP_DIR/.profile"
    fi

    # 既存ファイル（または既存リンク）が存在する、かつバックアップが存在しない場合にバックアップ
    if [[ -f "$target" || -L "$target" ]]; then
        if [[ ! -e "$backup" ]]; then
            cp -a "$target" "$backup"
            echo "Backed up: $file -> $backup"
        else
            echo "Backup already exists, skipped: $backup"
        fi
    fi

    # dotfiles側にファイルが存在すればリンク作成
    if [[ -f "$source" ]]; then
        ln -sf "$source" "$target"
        echo "Linked: $source -> $target"
    else
        echo "Warning: $source does not exist. Skipped."
    fi
done

# WSL の場合はシンボリックリンクを作成
if [[ "$OS_TYPE" =~ WSL ]]; then
    WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
    WIN_DIR="/mnt/c/Users/$WIN_USER"

    # Cドライブのリンク作成
    ln -sfn "/mnt/c" "$HOME/C"
    echo "Linked: /mnt/c -> $HOME/C"

    # Windowsフォルダ一覧
    WIN_FOLDERS=(
        "Desktop"
        "Downloads"
        "Documents"
        "Pictures"
        "Videos"
        "Music"
        "Dropbox"
    )

    # Windows 側にフォルダが存在する場合にリンク作成
    for folder in "${WIN_FOLDERS[@]}"; do
        source="$WIN_DIR/$folder"
        target="$HOME/$folder"
        if [[ -d "$source" ]]; then
            ln -sfn "$source" "$target"
            echo "Linked: $source -> $target"
        else
            echo "Warning: $source does not exist. Skipped."
        fi
    done
fi

# Vimカラースキーム用のディレクトリ作成とダウンロード
if [[ ! -f "$HOME/.vim/colors/jellybeans.vim" ]]; then
    mkdir -p "$HOME/.vim/colors"
    curl -fsSL -o "$HOME/.vim/colors/jellybeans.vim" \
    https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
fi

echo "Setup completed successfully!"

