set laststatus=2

set tabstop=4 sts=2 sw=2
"python
"
autocmd FileType python setl smartindent cinwords=if,else,elif,while,try,exept,finally,def,class
autocmd FileType python setl tabstop=8 sts=4 sw=4
"verilog
autocmd FileType verilog setl smartindent cinwords=if,else,while
autocmd FIleType verilog setl tabstop=8 sts=3 sw=3

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
set clipboard=unnamed,autoselect

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
" 括弧自動補完
" ------------------------
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap ” “”<LEFT>
inoremap " ""<LEFT>
inoremap ‘ ”<LEFT>
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
" 挿入モードでも移動できるようにする．
" ------------------------
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" ------------------------
" neocomplcacheの色設定
" ------------------------
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" neobundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/neobundle'))
endif

"NeoBundle 'git://github.com/Shougo/clang_complete.git'
"NeoBundle 'git://github.com/Shougo/echodoc.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
" NeoBundle 'git://github.com/Shougo/neocomplcache-snippets-complete.git'
NeoBundle 'git://github.com/Shougo/neosnippet.git'
NeoBundle 'git://github.com/anyakichi/vim-surround.git'
"NeoBundle 'git://github.com/Shougo/vim-vcs.git'
"NeoBundle 'git://github.com/Shougo/vimfiler.git'
"NeoBundle 'git://github.com/Shougo/vimshell.git'
"NeoBundle 'git://github.com/Shougo/vinarise.git'
NeoBundle 'git://github.com/vim-scripts/tComment.git'
NeoBundle 'git://github.com/vim-scripts/Align.git'
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
NeoBundle 'git://github.com/mattn/webapi-vim.git'
NeoBundle 'git://github.com/basyura/twibill.vim.git'
NeoBundle 'git://github.com/tyru/open-browser.vim.git'
NeoBundle 'git://github.com/h1mesuke/unite-outline.git'
NeoBundle 'git://github.com/basyura/bitly.vim.git'
NeoBundle 'git://github.com/basyura/TweetVim.git'
NeoBundle 'othree/eregex.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'git://github.com/mattn/zencoding-vim.git'
NeoBundle 'git://github.com/vim-scripts/VOoM.git'
filetype plugin on
filetype indent on

" PATH
let $PATH="~/.vim:".$PATH

" neocompl
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_underbar_completion = 1
" imap <Tab> <Plug>(neosnippet_expand_or_jump)
" smap <Tab> <Plug>(neosnippet_expand_or_jump)
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" " SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Align
let g:Align_xstrlen = 3

nmap <ESC><ESC> :nohlsearch<CR><ESC>

map <C-Left> <Left>
set cursorline
hi cursorline term=reverse cterm=none ctermbg=242

" Vim-powerline
let g:Powerline_symbols = 'fancy'
set t_Co=256
colorscheme torte
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set t_kD=
set t_kb=

if !exists("g:neosnippet#snippets_directory")
    " let g:neosnippet#snippets_directory=""
    " let g:neosnippet#snippets_directory+="~/.vim/snippets"
endif
let g:neosnippet#snippets_directory="~/.vim/snippets"
