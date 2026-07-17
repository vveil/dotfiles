[[ -r "$ZDOTDIR/.work-secrets.zsh" ]] && source "$ZDOTDIR/.work-secrets.zsh"

if [[ -r "$HOME/devconfig/export_variables.sh" ]]; then
  # devconfig registers a Bash-style completion for Vault.
  if (( ! $+functions[complete] )); then
    if (( $+functions[run-compinit] )); then
      run-compinit
    else
      autoload -Uz compinit
      compinit
    fi
    autoload -Uz bashcompinit
    bashcompinit
  fi
  source "$HOME/devconfig/export_variables.sh"
fi

if [[ -r "$HOME/devconfig/set_aliases.sh" ]]; then
  source "$HOME/devconfig/set_aliases.sh"
fi
