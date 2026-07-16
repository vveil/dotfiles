if (( $+commands[brew] )); then
  eval "$(brew shellenv)"
fi

alias gconfig='${EDITOR:-nvim} "$HOME/Library/Application Support/com.mitchellh.ghostty/config"'

_lima_docker_socket="$HOME/.lima/default/sock/docker.sock"
if [[ -S "$_lima_docker_socket" ]]; then
  export DOCKER_HOST="unix://$_lima_docker_socket"
fi
unset _lima_docker_socket
