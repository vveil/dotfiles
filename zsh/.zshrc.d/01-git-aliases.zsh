#!/bin/zsh
#
# 01-git-aliases.zsh - Git aliases (shared between work and personal)
#

alias gti="git"
alias gst="git status"
alias gsw="git switch"
alias gswc="git switch -C"
alias gup="git fetch --all --prune && git rebase --autostash"
alias gsu="git submodule update"
alias gsui="gsu --init"
alias gsta="git stash"
alias gstp="git stash pop"
alias gaa="git add ."
alias gc="git commit"
alias shortlog='git shortlog -sn --all --no-merges --since="1 year ago"'
alias gba="git branch --all"
alias gsn="git show --name-only"
alias gstu="git stash --include-untracked"
alias gfa="git fetch --all --prune"
