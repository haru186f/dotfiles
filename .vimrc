colorscheme jellybeans

set showmatch                   " 対応する括弧を表示
set ruler                       " ステータス行にカーソル位置表示
set laststatus=2                " 常にステータスライン表示
set showcmd                     " 入力中のコマンドを表示
set wildmenu                    " コマンド補完をわかりやすく表示

set ignorecase            " 大文字小文字を無視
set smartcase             " ただし大文字が含まれていれば区別
set hlsearch              " 検索結果をハイライト
set incsearch             " 入力中に検索開始
nnoremap <Space> :nohlsearch<CR> " Spaceでハイライト解除

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

