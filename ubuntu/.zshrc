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
autoload colors
colors
case ${UID} in
0)
  PROMPT="%T$ "
  #PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  RPROMPT="%B%{${fg[red]}%}[%/]%{${reset_color}%}%b"
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
  PROMPT="%{${fg[white]}%}${PROMPT}"
  ;;
*)
  PROMPT="%T$ "
  #PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
  RPROMPT="%{${fg[red]}%}[%/]%{${reset_color}%}%b"
  PROMPT="%{${fg[white]}%}${PROMPT}"
  ;;
esac
RPROMPT="%{${fg[red]}%}[%/]%{${reset_color}%}%b"
# auto change directory
#
setopt auto_cd

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
setopt noautoremoveslash

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

## Completion configuration
#
autoload -U compinit;
compinit -u

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
alias sumatra="cygstart ~/programs86/SumatraPDF/SumatraPDF.exe"

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

# set terminal title including current directory
#
case "${TERM}" in
    kterm*|xterm*)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            #                                                                                'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
esac

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    if [ -n "${WINDOW}" ]; then
        preexec () {
            1="$1 "     # deprecated.
            echo -ne "\ek${${(s: :)1}[0]}\e\\"
        }
    fi
    ;;
esac

autoload bashcompinit
bashcompinit

export GIT_EDITOR="vim"
export PATH=~/programs86/Graphviz\ 2.28/bin:$PATH

if [ -r "$HOME/.zshrc.local" ]; then
        source $HOME/.zshrc.local
fi


#if [ "$TERM" = "screen" ]; then
#    chpwd () { echo -n "_`dirs`\\" }
#    preexec() {
#        # see [zsh-workers:13180]
#        # http://www.zsh.org/mla/workers/2000/msg03993.html
#        emulate -L zsh
#        local -a cmd; cmd=(${(z)2})
#        case $cmd[1] in
#            fg)
#                if (( $#cmd == 1 )); then
#                    cmd=(builtin jobs -l %+)
#                else
#                    cmd=(builtin jobs -l $cmd[2])
#                fi
#                ;;
#            %*) 
#                cmd=(builtin jobs -l $cmd[1])
#                ;;
#            cd)
#                if (( $#cmd == 2)); then
#                    cmd[1]=$cmd[2]
#                fi
#                ;&
#            *)
#                echo -n "k$cmd[1]:t\\"
#                return
#                ;;
#        esac
#
#        local -A jt; jt=(${(kv)jobtexts})
#
#        $cmd >>(read num rest
#            cmd=(${(z)${(e):-\$jt$num}})
#            echo -n "k$cmd[1]:t\\") 2>/dev/null
#    }
#    chpwd
#fi
LD_PRELOAD=/opt/Xilinx/13.2/ISE_DS/ISE/lib/lin64/libXst2_Core.so

