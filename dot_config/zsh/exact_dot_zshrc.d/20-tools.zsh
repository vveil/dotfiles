if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

if [[ -r "$HOME/.atuin/bin/env" ]]; then
  source "$HOME/.atuin/bin/env"
fi
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh)"
fi

if [[ -r "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
elif (( $+commands[fzf] )); then
  eval "$(fzf --zsh 2>/dev/null)"
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
