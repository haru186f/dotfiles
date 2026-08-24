#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

# OS判別
detect_os() {
    if [[ -f /etc/redhat-release ]]; then
        echo "redhat"
    elif [[ -f /etc/debian_version ]]; then
        echo "debian"
    else
        echo "unknown"
    fi
}

OS_TYPE=$(detect_os)
echo "Detected OS: $OS_TYPE"


# 管理対象ファイル一覧
FILES=(
    ".bashrc"
    ".vimrc"
    ".inputrc"
    ".gitconfig"
)

case "$OS_TYPE" in
    redhat)
        FILES+=(".bash_profile")
        ;;
    debian)
        FILES+=(".profile")
        ;;
    *)
        echo "Warning: Unknown OS. Adding both .bash_profile and .profile to check list."
        FILES+=(".bash_profile" ".profile")
        ;;
esac


# バックアップディレクトリ作成
mkdir -p "$BACKUP_DIR"

# バックアップとシンボリックリンク作成
for file in "${FILES[@]}"; do
    target="$HOME/$file"
    source="$DOTFILES_DIR/$file"

    # Debianの場合は .bash_profile を .profile に変更
    if [[ "$file" == ".bash_profile" && "$OS_TYPE" == "debian" ]]; then
        target="$HOME/.profile"
    fi

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
