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
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap ” “”<LEFT>
" inoremap " ""<LEFT>
" inoremap ‘ ”<LEFT>
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

" neobundle
filetype off

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/neobundle'))

NeoBundleFetch 'Shougo/neobundle.vim.git'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'basyura/unite-rails.git'
NeoBundle 'Shougo/neocomplcache-rsense.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/neosnippet.git'
NeoBundle 'Shougo/neosnippet-snippets.git'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'tpope/vim-rails.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'vim-scripts/tComment.git'
NeoBundle 'vim-scripts/Align.git'
NeoBundle 'taichouchou2/alpaca_powertabline'
NeoBundle 'tyru/open-browser.vim.git'
" NeoBundle 'othree/eregex.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'mattn/emmet-vim.git'
NeoBundle 'vim-scripts/VOoM.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'vim-scripts/verilog_emacsauto.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'gregsexton/gitv'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/excelview-vim'
NeoBundle 'moznion/hateblo.vim'
NeoBundle 'superbrothers/vim-quickrun-markdown-gfm'
NeoBundle 'w0ng/vim-hybrid' " A dark colour scheme for Vim & gVim
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'vimtaku/hl_matchit.vim.git'
NeoBundle 'cohama/lexima.vim.git'
" NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'dhruvasagar/vim-table-mode'
" 補完用に jedi-vim を追加
let $PATH="~/.anyenv/envs/pyenv/shims:".$PATH
" NeoBundle "davidhalter/jedi-vim"
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" PATH
let $PATH="~/.vim:".$PATH

" neocompl
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
" imap <Tab> <Plug>(neosnippet_expand_or_jump)
" smap <Tab> <Plug>(neosnippet_expand_or_jump)
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_force_overwrite_completefunc = 1

" Plugin key-mappings.
imap <C-q>     <Plug>(neosnippet_expand_or_jump)
smap <C-q>     <Plug>(neosnippet_expand_or_jump)
xmap <C-q>     <Plug>(neosnippet_expand_or_target)

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
set t_Co=256
" colorscheme jellybeans
" colorscheme hybrid
colorscheme solarized
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set t_kD=
set t_kb=

if !exists("g:neosnippet#snippets_directory")
    " let g:neosnippet#snippets_directory=""
    " let g:neosnippet#snippets_directory+="~/.vim/snippets"
endif
let g:neosnippet#snippets_directory="~/.vim/snippets"

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

set number
if version >= 703
  nnoremap  <silent> ,n :<C-u>ToggleNumber<CR>
  command! -nargs=0 ToggleNumber call ToggleNumberOption()

  function! ToggleNumberOption()
    if &number
      set relativenumber
    else
      set number
    endif
  endfunction
endif

" for rails
autocmd BufNewFile,BufRead app/*/*.erb    setlocal ft=eruby fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.rb    setlocal ft=ruby  fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.yml   setlocal ft=ruby  fenc=utf-8
autocmd FileType ruby,haml,eruby,sass,cucumber,mason setlocal ts=2 sts=2 sw=2 et nowrap

" for unite
noremap <C-U><C-B> :Unite buffer<CR>
noremap <C-U><C-C> :UniteWIthBufferDir -buffer-name=files file<CR>
noremap <C-U><C-A> :Unite file file_mru buffer<CR>
noremap <C-U><C-R> :Unite file_mru<CR>
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>

" for vimfiler
nnoremap <silent> <Leader>f :VimFiler -split -simple -winwidth=35 -no-quit<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

" rsense
let g:neocomplcache#sources#rsense#home_directory = '~/.vim/directories/rsense-0.3'
let g:rsenseUseOmniFunc = 1
let g:rsenseHome="~/.vim/directories/rsense-0.3"
if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns={}
endif
let g:neocomplcache_omni_patterns.ruby='[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php='[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c='\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp='\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

set tabstop=4 sts=2 sw=2
"python
autocmd FileType python setl smartindent cinwords=if,else,elif,while,try,exept,finally,def,class
autocmd FileType python setl tabstop=8 sts=4 sw=4
"java
autocmd FileType java setl smartindent cinwords=if,else,while,try,exept,finally,public,class
autocmd FileType java setl tabstop=8 sts=4 sw=4
"verilog
autocmd BufNewFile,BufRead *.sv set filetype=verilog
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
let g:user_zen_expandabbr_key = '<TAB>'

" gitv setting
autocmd FileType gitv call s:my_gitv_settings()
function! s:my_gitv_settings()
  nnoremap <buffer> <Space>rb :<C-u>Git rebase <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> <Space>R :<C-u>Git revert <C-r>=GitvGetCurrentHash()<CR><CR>
  nnoremap <buffer> <Space>h :<C-u>Git cherry-pick <C-r>=GitvGetCurrentHash()<CR><CR>
  nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r>=GitvGetCurrentHash()<CR>

  nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>
endfunction
autocmd FileType git setlocal nofoldenable foldlevel=0
function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction
function! s:gitv_get_current_hash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

let g:quickrun_config = {
\   'markdown': {
\     'type': 'markdown/gfm',
\     'outputter': 'browser'
\   }
\ }
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

let g:quickrun_config["java"] = {
      \ 'exec' : ['javac -J-Dfile.encoding=UTF8 %o %s', '%c -Dfile.encoding=UTF8 %s:t:r %a']
\}

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
source $VIMRUNTIME/macros/matchit.vim

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
" map <Leader> <Plug>(easymotion-prefix)
" map f <Plug>(easymotion-bd-fl)
" map t <Plug>(easymotion-bd-tl)
" map <Space> <Plug>(easymotion-s2)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
au BufNewFile,BufRead *.go set filetype=go
command! E Explore
