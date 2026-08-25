colorscheme jellybeans

set showmatch
set ruler
set laststatus=2
set showcmd
set wildmenu
set ignorecase
set smartcase
set hlsearch
set incsearch
set number
nnoremap <Space> :nohlsearch<CR>
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

filetype plugin indent on
syntax on
autocmd BufNewFile,BufRead * if &filetype == '' | set filetype=sh | endif

