# Path settings #
fpath=(~/.zsh/peco-sources(N-/) $fpath)
fpath=(~/.zsh/zsh-completions.git/src $fpath)
fpath=(~/.zsh/poetry $fpath)
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

# load peco function
autoload peco-select-history
autoload peco-snippets
autoload peco-cdr


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

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias -g g="|grep"
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

case $OSTYPE in
darwin*)
  [ -f ~/.zsh/zshrc/.zshrc.mac ] && source ~/.zsh/zshrc/.zshrc.mac
  ;;
linux*)
  [ -f ~/.zsh/zshrc/.zshrc.linux ] && source ~/.zsh/zshrc/.zshrc.linux
  ;;
esac
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"

    for D in `ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
fi
if [ -d ${HOME}/.rbenv ]; then
  eval "$(rbenv init -)"
fi
if [ -d ${HOME}/.pyenv ]; then
  eval "$(pyenv init -)"
fi
# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

export CLASSPATH=".:/usr/local/Cellar/antlr/4.5.3/antlr-4.5.3-complete.jar:$CLASSPATH"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

source ~/.poetry/env
poetry_activate(){
  source $(dirname $(poetry run which python))/activate
}
export PATH="$HOME/.cargo/bin:$PATH"
