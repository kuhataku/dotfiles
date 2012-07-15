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


" ----------------------------------
" クリップボードとヤンクを共有
" ----------------------------------
set clipboard=unnamed

" --------------------------------
" 補完候補表示中はShiftEnterで改行
" --------------------------------
inoremap <S-CR> <C-p><CR>

" ------------------------------------------
" 挿入モード時、ステータスラインの色を変更
" ------------------------------------------
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

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
vnoremap { “zdi^V{z}<LEFT>
vnoremap [ “zdi^V[z]<LEFT>
vnoremap ( “zdi^V(z)<LEFT>
vnoremap ” “zdi^V”z^V”<LEFT>
vnoremap ‘ “zdi’z’<LEFT>
" ------------------------
" ShiftUPDOWNで進みすぎないようにする
" ------------------------
noremap <S-Down> <Down>
noremap <S-UP> <UP>
noremap j gj
noremap k gk

" ------------------------
" 挿入モードでも移動できるようにする．
" ------------------------
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

hi StatusLine  term=BOLD cterm=NONE ctermfg=White   ctermbg=DarkBlue

" pathogen
call pathogen#runtime_append_all_bundles()

" ref.vim
nmap ,ra :<C-u>Ref alc<Space>
let g:ref_alc_start_linenumber = 39
let g:ref_alc_encoding = 'Shift-JIS'
let g:ref_alc_cmd='lynx -dump -nonumbers %s'

" PATH
let $PATH="/home/takuya/.vim:".$PATH

" neocompl
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_underbar_completion = 1
imap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" Align
let g:Align_xstrlen = 3

nmap <ESC><ESC> :nohlsearch<CR><ESC>

map <C-Left> <Left>
set cursorline
hi cursorline term=reverse cterm=none ctermbg=242
set t_Co=256
