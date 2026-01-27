#!/bin/zsh
#
# 02-mode-detection.zsh - Detect work/personal mode and source configs
#

MODE_FILE="$HOME/.config/dotfiles/mode"

if [[ -f "$MODE_FILE" ]]; then
    MODE=$(cat "$MODE_FILE")
    if [[ "$MODE" == "work" ]]; then
        for _rc in $HOME/.zshrc.d/20-work/*.zsh; do
            [[ -f "$_rc" ]] && source "$_rc"
        done
    else
        for _rc in $HOME/.zshrc.d/30-personal/*.zsh; do
            [[ -f "$_rc" ]] && source "$_rc"
        done
    fi
fi
