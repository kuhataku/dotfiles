# Path settings #
fpath=(~/.zsh/peco-sources(N-/) $fpath)
fpath=(~/.zsh/zsh-completions.git/src $fpath)
## go path
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export BROWSER=w3m

#
# users generic .zshrc file for zsh(1)
# LANG
export LANG=ja_JP.UTF-8

# Default shell configuration
#
# auto change directory
setopt auto_cd

## Completion configuration
#
autoload -U compinit
compinit

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# compacked complete list display
setopt list_packed

# no remove postfix slash of command line
setopt autoremoveslash

# no beep sound when complete list displayed
setopt nolistbeep

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

# Load script
#
# load prompt function
source ~/.zsh/configuration/prompt/prompt-config

# load ls function
source ~/.zsh/configuration/ls/ls-config

# load cdr function
source ~/.zsh/configuration/cdr/cdr

source ~/.zsh/z/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# load peco function
autoload peco-select-history
autoload peco-snippets
autoload peco-cdr

function chpwd() { ls }

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
# to end of it)
#
bindkey -e
# bindkey "^S" history-incremental-search-forward
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


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
alias g="|grep"
alias du="du -h"
alias df="df -h"

alias su="su -l"
alias fcd='source /usr/local/bin/fcd.sh'
autoload zmv
alias zmv='noglob zmv -W'
setopt noflowcontrol

## peco keybind
zle -N peco-snippets
bindkey "^s" peco-snippets
zle -N peco-cdr
bindkey "^x^r" peco-cdr
zle -N peco-select-history
bindkey '^R' peco-select-history
source ~/.zsh/auto-fu.zsh/auto-fu.zsh
source ~/.zsh/configuration/auto-fu/auto-fu-config
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
