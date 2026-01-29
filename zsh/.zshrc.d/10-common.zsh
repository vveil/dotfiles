#!/bin/zsh
#
# 10-common.zsh - Common settings (both work and personal)
#

eval "$(fzf --zsh)"
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

if [[ "$(uname)" == "Darwin" ]]; then
    eval "$($HOME/.local/bin/mise activate zsh)"
fi

setopt AUTO_CD

export PATH="$HOME/.local/bin:$PATH"
export GIT_EDITOR=nvim
export VISUAL=nvim
export EDITOR="$VISUAL"

alias config="nvim ~/.config/zsh/.zshrc"
alias gconfig="nvim $HOME/Library/Application\ Support/com.mitchellh.ghostty/config"
alias l="ls -la"
