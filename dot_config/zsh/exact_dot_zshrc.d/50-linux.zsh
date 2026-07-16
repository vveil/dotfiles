# Linux-wide interactive shell configuration belongs here. Package-manager
# differences should stay in provisioning scripts rather than shell startup.
if [[ -n "$SSH_CONNECTION" ]]; then
  export BROWSER="${BROWSER:-false}"
fi
