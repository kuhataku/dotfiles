# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

# Default shell configuration
#
# set prompt
#
autoload -Uz colors
colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
# 下のformatsの値をそれぞれの変数に入れてくれる機能の、変数の数の最大。
# デフォルトだと2くらいなので、指定しておかないと、下のformatsがほぼ動かない。
zstyle ':vcs_info:*' max-exports 7

# 左から順番に、vcs_info_msg_{n}_ という名前の変数に格納されるので、下で利用する
zstyle ':vcs_info:*' formats '%R' '%s' '%b' '%s'
# 状態が特殊な場合のformats
zstyle ':vcs_info:*' actionformats '%R' '%s' '%b|%a' '%s'

# 4.3.10以上の場合は、check-for-changesという機能を使う。
autoload -Uz is-at-least
if is-at-least 4.3.10; then
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' formats '%R' '%S' '%b' '%s' '%c' '%u'
    zstyle ':vcs_info:*' actionformats '%R' '%S' '%b|%a' '%s' '%c' '%u'
fi

# zshのPTOMPTに渡す文字列は、可読性がそんなに良くなくて、読み書きしたり、つまりデバッグが
# 大変なため、文字列を組み立てるのは関数でやることにする。
# そのほうが分岐などを追加するのが楽。
# この先、追加で表示させたい情報はいろいろでてくるとおもうし。
function echo_rprompt () {
    local repos branch st color
    LANG=ja_JP.UTF-8 vcs_info

    if [[ -n "$vcs_info_msg_2_" ]]; then
        # if [[ -n "$vcs_info_msg_2_" ]]; then
            branch="$vcs_info_msg_2_"
        # else
        #     branch=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        # fi

        if [[ -n "$vcs_info_msg_4_" ]]; then # staged
            branch="%F{196}$branch%f"
        elif [[ -n "$vcs_info_msg_5_" ]]; then # unstaged
            branch="%F{blue}$branch%f"
        else
            branch="%F{165}$branch%f"
        fi
        # print -n "[%25<..<"
        # print -n "%F{yellow}$vcs_info_msg_1_%F"
        # print -n "%<<]"

        # print -n "[%15<..<"
        print -n "%B["
        print -nD "%F{green}%60<..<%~%<<%f"
        print -n "]"
        print -n "["
        print -n "$branch"
        # print -nD "%F{yellow}$repos%f"
        # print -n "@$branch"
        # print -n "%<<]"
        print -n "]%b"

    else
        print -nD "[%F{green}%60<..<%~%<<%f]"
    fi
}
function echo_trueface() {
  print "%F{red}<^L^>%f$ "
}

function echo_falseface() {
  print "%F{blue}<*L*>%f$ "
}
setopt prompt_subst
case ${UID} in
0)
  PROMPT='`echo_rprompt`%(?.`echo_trueface`.`echo_falseface`)'
  # PROMPT="`echo_rprompt`%(?.`echo_trueface`.`echo_falseface`)"
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
  ;;
*)
  PROMPT='`echo_rprompt`%(?.`echo_trueface`.`echo_falseface`)'
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
  ;;
esac
RPROMPT="%B[%{${fg[yellow]}%}%n@%m%{${reset_color}%}%B]%b"
# auto change directory
#
setopt auto_cd

## Completion configuration
#
autoload -U compinit
compinit

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt autoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w"
        ;;
    linux*)
        alias ls="ls --color"
        ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
# alias less="/usr/share/vim/vimcurrent/macros/less.sh"
alias g="|grep"
alias du="du -h"
alias df="df -h"

alias su="su -l"

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
    xterm)
        export TERM=xterm-color
        ;;
    kterm)
        export TERM=kterm-color
        # set BackSpace control character
        stty erase
        ;;
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            #                                                            'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
esac

source ~/.zsh/z/z.sh
function precmd () {
  z --add "$(pwd -P)"
}
source ~/.zsh/auto-fu.zsh/auto-fu.zsh
function zle-line-init(){
    auto-fu-init
}
afu+cancel-and-accept-line() {
    ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
    zle afu+accept-line
}
zle -N afu+cancel-and-accept-line
zle -N zle-line-init
alias peep='~/.zsh/peep/peep'
export BROWSER=w3m

function chpwd() { ls }
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

fpath=(~/.zsh/zsh-completions.git/src $fpath)
# source ~/.vim/neobundle/powerline/powerline/bindings/zsh/powerline.zsh
zstyle ':auto-fu:var' postdisplay
