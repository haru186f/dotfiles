# .bashrc

DOTFILES=$HOME/dotfiles

if [[ -f $DOTFILES/exports ]]; then
    source $DOTFILES/exports
fi

if [[ -f $DOTFILES/options ]]; then
    source $DOTFILES/options
fi

if [[ -f $DOTFILES/aliases ]]; then
    source $DOTFILES/aliases
fi
