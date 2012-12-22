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
  PROMPT="{${fg[red]}%}<^L^>$ "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  RPROMPT="%B%{${fg[green]}%}[%/]%{${reset_color}%}%b"
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
  PROMPT="%{${fg[white]}%}${PROMPT}"
  ;;
*)
  PROMPT="%(?.%F{blue}<^L^><%f.%F{red}<.L.><%f) "
  # PROMPT="{${fg[red]}%}<^L^>$ "
  # PROMPT="%{${fg[white]}%}[ %{${fg[blue]}%}%T%{${fg[white]}%} ] $ "
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
  RPROMPT="%{${fg[green]}%}[%/]%{${reset_color}%}%b"
  PROMPT="%{${fg[white]}%}${PROMPT}"
  ;;
esac
RPROMPT="%{${fg[green]}%}[%/]%{${reset_color}%}%b"
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
export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export PATH="/Applications/UpTeX.app/teTeX/bin:$PATH"

alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=/usr/local/bin:$PATH

. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
  z --add "$(pwd -P)"
}
source ~/.zsh/auto-fu.zsh/auto-fu.zsh
function zle-line-init(){
    auto-fu-init
}
zle -N zle-line-init
alias peep='~/.zsh/peep/peep'
export BROWSER=w3m

tmux_localworks(){
    tmux new-window -n splitwindow;
    tmux send-keys -t:splitwindow "cd ~/Works/ISDL" C-m;
    tmux split-window -w;
    tmux new-window -n twitter;
    tmux send-keys -t:twitter "vim -c TweetVimHomeTimeline" C-m;
    tmux new-window -n peep;
    tmux send-keys -t:peep  "peep" C-m
}

tmux_kappaworks(){
    tmux new-session -s works;
    tmux new-window -a -n splitwindow;
    tmux send-keys -t splitwindow "cd ~/Works/ISDL" C-m
    tmux new-window -a -n kappa;
    tmux send-keys -t kappa "ssh takuya@kappa" C-m
    tmux new-window -a -n twitter;
    tmux send-keys -t twitter "vim -c TweetVimHomeTimeline" C-m
    tmux new-window -a -n peep;
    tmux send-keys -t peep  "peep" C-m
}

function chpwd() { ls }
