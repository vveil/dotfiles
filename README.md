# Dotfiles

Cross-platform dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Bootstrap

The repository is public, so a new machine can run:

```sh
sh -c "$(curl -fsLS https://raw.githubusercontent.com/vveil/dotfiles/main/bootstrap)"
```

This installs chezmoi and runs `chezmoi init --apply`. The equivalent direct
command is `sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply vveil`.

Initialization asks for two independent choices:

- Profile: `personal` or `work`
- Role: `desktop`, `server`, or `container`

The operating system and Linux distribution are detected by chezmoi. Personal
and work profiles are supported on macOS, Ubuntu, and Fedora.
Work-machine hostnames are stored only in the local chezmoi configuration.

## Zsh layers

Zsh loads fragments in lexical order from `~/.config/zsh/.zshrc.d`:

- `10`-`45`: shared configuration
- `50`: macOS or Linux configuration
- `55`: Ubuntu or Fedora overrides
- `60`: personal or work overlay

Work machines conditionally source `~/devconfig/export_variables.sh` and
`~/devconfig/set_aliases.sh`. A missing private repository does not break shell
startup.

## Validation

```sh
chezmoi diff
chezmoi apply --dry-run --verbose
zsh -n ~/.zshenv ~/.config/zsh/.zshrc ~/.config/zsh/.zshrc.d/*.zsh
```

## Managed software

- macOS: Homebrew CLI tools and the selected desktop applications
- Ubuntu/Fedora: native CLI packages
- mise: Neovim, Atuin, delta, Go, Node.js, Python, and zoxide
- OpenCode: Homebrew on macOS and the official installer on Linux
- chezmoi externals: Antidote and the Oh My Tmux base configuration
