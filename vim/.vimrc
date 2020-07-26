set laststatus=2

" タブをスペースに展開しない (expandtab:展開する)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
"  バックスペースでインデントや改行を削除できるようにする
set backspace=2
"  検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch

" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" ---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup

syntax on

" ----------------------------------
" クリップボードとヤンクを共有
" ----------------------------------
set clipboard=unnamed

" --------------------------------
" 補完候補表示中はShiftEnterで改行
" --------------------------------
inoremap <S-CR> <C-p><CR>

" ------------------------
" ノーマルモードでも改行
" ------------------------
noremap <CR> i<CR><ESC>
noremap <S-CR> o<ESC>

" ------------------------
" ShiftUPDOWNで進みすぎないようにする
" ------------------------
noremap <S-Down> <Down>
noremap <S-UP> <UP>


" ------------------------
" 見た目で移動
" ------------------------
noremap j gj
noremap k gk

" ------------------------
" neocomplcacheの色設定
" ------------------------
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

if &compatible
  set nocompatible
endif

let s:cache_home = empty($CACHE_HOME) ? expand('~/.cache') : $CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/.repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let $PATH="~/.anyenv/envs/pyenv/shims:".$PATH
let $PYTHONHOME='~/.pyenv/versions/3.8.5'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy':0})

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable
if dein#check_install()
  call dein#install()
endif

nmap <ESC><ESC> :nohlsearch<CR><ESC>

map <C-Left> <Left>
set cursorline
hi cursorline term=reverse cterm=none ctermbg=242

" Vim-powerline
set t_Co=256
" colorscheme jellybeans
colorscheme hybrid
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set t_kD=
set t_kb=

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" for rails
autocmd BufNewFile,BufRead app/*/*.erb    setlocal ft=eruby fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.rb    setlocal ft=ruby  fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.yml   setlocal ft=ruby  fenc=utf-8
autocmd FileType ruby,haml,eruby,sass,cucumber,mason setlocal ts=2 sts=2 sw=2 et nowrap

set tabstop=4 sts=2 sw=2
"python
autocmd FileType python setl smartindent cinwords=if,else,elif,while,try,exept,finally,def,class
autocmd FileType python setl tabstop=8 sts=4 sw=4
"java
autocmd FileType java setl smartindent cinwords=if,else,while,try,exept,finally,public,class
autocmd FileType java setl tabstop=8 sts=4 sw=4
"verilog
"autocmd BufNewFile,BufRead *.sv set filetype=verilog
autocmd FileType verilog setl smartindent cinwords=if,else,while
autocmd FIleType verilog setl tabstop=8 sts=3 sw=3
set noshowmode
" ------------------------
" 挿入モードでも移動できるようにする．
" ------------------------
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

vnoremap * "zy:let @/ = @z<CR>n


function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
source $VIMRUNTIME/macros/matchit.vim

autocmd BufNewFile,BufRead *.go set filetype=go
autocmd BufNewFile,BufRead *.rdl set filetype=systemrdl
command! E Explore
set hlsearch
set undofile
set completeopt=menuone,noinsert
