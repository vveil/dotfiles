[[ -r "$ZDOTDIR/.work-secrets.zsh" ]] && source "$ZDOTDIR/.work-secrets.zsh"

if [[ -r "$HOME/devconfig/export_variables.sh" ]]; then
  source "$HOME/devconfig/export_variables.sh"
fi
if [[ -r "$HOME/devconfig/set_aliases.sh" ]]; then
  source "$HOME/devconfig/set_aliases.sh"
fi
