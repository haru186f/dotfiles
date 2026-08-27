# .bashrc

#==============================================================#
#           Aliases & Functions                                #
#==============================================================#

# common
alias ls='ls -aF --color=auto'
alias ll='ls -alF --color=auto'
alias ld='ls -dlF --color=auto'
alias li='ls -aliF --color=auto'
alias lr='ls -altrF --color=auto'
alias rm='rm -i'
alias cp='cp -ir'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep -E --color=auto'
alias v='vim'
alias vi='vim'
alias l='less'
alias cl='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git
alias g='git'
alias gm='git switch main && git pull origin main'
alias ga='git add --all'
alias gc='git commit -m'
alias gac='git add --all && git commit -m'
alias gpl='git pull'
alias gps='git push'
alias gs='git status'
alias gb='git branch'
alias gbc='git switch -c'
alias gsw='git switch'
alias gr='git remote -v'
alias gra='git remote add origin "https://github.com/haru186f/$(basename "$PWD").git"'
alias grs='git remote set-url origin "git@github.com:haru186f/$(basename "$PWD").git"'
gacp() { git add --all && git commit -m "$*" && git push; }

# Django
alias py='python'
alias activate='[ -d venv ] || python3 -m venv venv; source venv/bin/activate'
alias run='source venv/bin/activate && python manage.py runserver'
alias shell='python manage.py shell_plus 2>/dev/null || python manage.py shell'
alias startproject='django-admin startproject config .'
alias require='python -m pip install -r requirements.txt'
alias freeze='python -m pip freeze > requirements.txt'
alias runcommands='python manage.py run_all_custom_commands'
alias setup='python manage.py migrate && python manage.py run_all_custom_commands && python manage.py createsuperuser'
alias dcron='python manage.py crontab'
migrate() { python manage.py makemigrations "$@" && python manage.py migrate "$@"; }
createsuperuser() { python manage.py createsuperuser "$@"; }
startapp() { python manage.py startapp "$@"; }

#==============================================================#
#           Options                                            #
#==============================================================#

# set
set -o emacs
set -o ignoreeof
set -o histexpand
set -o history

# shopt
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s histappend
shopt -s cmdhist
shopt -s nullglob
shopt -s globstar
shopt -s nocaseglob
shopt -s checkwinsize
shopt -u sourcepath
