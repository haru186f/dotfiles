set nocompatible
syntax enable
colorscheme jellybeans
filetype plugin indent on

" 基本
set showmatch
set ruler
set laststatus=2
set showcmd
set wildmenu
set number
noremap <F12> <ESC>:set number!<CR> 

" 検索
set ignorecase
set smartcase
set hlsearch
set noincsearch
set nowrapscan
nnoremap <Space> :nohlsearch<CR>

" 文字コード
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp

" インデント
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set cindent

" その他
set nobackup
set noswapfile
autocmd BufNewFile,BufRead * if &filetype == '' | set filetype=sh | endif
