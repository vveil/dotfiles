# AGENTS.md - Dotfiles Development Guide

This repository manages dotfiles using [dotbot](https://github.com/anishathalye/dotbot) and includes custom scripts for Neovim installation and configuration.

## Build, Lint, and Test Commands

### Bootstrap Script
```bash
./bootstrap                    # Run full setup (prompts for mode if not set)
./bootstrap --help             # Show usage
./bootstrap --personal         # Set and run as personal device
./bootstrap --work             # Set and run as work device

# Mode is stored in ~/.config/dotfiles/mode
cat ~/.config/dotfiles/mode    # Check current mode
```

### Lua Formatting (Neovim Config)
```bash
stylua --check .              # Check Lua files for formatting compliance
stylua .                      # Auto-format Lua files in place
```

### Dotbot
```bash
./dotbot/bin/dotbot -c install.conf.yaml    # Run dotbot manually
```

### Shell Scripts
```bash
bash -n bootstrap             # Syntax check bash script (no execution)
shellcheck bootstrap          # Run shellcheck for best practices (install via brew)
```

## Code Style Guidelines

### Bash (bootstrap script)
- Use `#!/usr/bin/env bash` shebang
- Always use `set -euo pipefail` for strict error handling
- Use `local` for function-scoped variables
- Use `snake_case` for variables and functions
- Use `uppercase` for constants (prefixed with type, e.g., `NVIM_VERSION_MIN`)
- Quote all variable expansions: `"$variable"` not `$variable`
- Use `[[ ]]` for conditionals, not `[ ]`
- Use `printf` for output, avoid `echo` with variables
- Use descriptive function names with `log()` and `error()` helpers
- Wrap `git` commands in error handling

### Bash Error Handling Patterns
```bash
# Check if command exists
if ! command -v nvim &> /dev/null; then
    echo "not installed"
    return 1
fi

# Check exit status with &&
./dotbot/bin/dotbot -c install.conf.yaml || error "dotbot failed"

# Use set -e for automatic exit on error
set -e

# Version comparison helper
version_gte() {
    printf '%s\n%s\n' "$2" "$1" | sort -V -C
}
```

### YAML (install.conf.yaml)
- Use 2-space indentation
- List items with `-` followed by space
- Align colons in mappings
- Use lowercase with underscores for keys
- Add blank line between major sections
- Group related items under defaults/clean/link/shell sections

### YAML Example Structure
```yaml
- defaults:
    link:
      relink: true
      force: true

- clean: ['~']

- link:
    ~/.config/nvim: nvim/.config/nvim
    ~/.tmux.conf: tmux/.tmux/.tmux.conf

- shell:
    - [git submodule update --init --recursive, Initialize submodules]
```

### Lua (Neovim config)
- Follow stylua formatting (4-space indent, compact tables)
- Use `snake_case` for variables and functions
- Use `PascalCase` for module names and tables acting as classes
- Use `ALL_CAPS` for constants
- Prefer `local` over global variables
- Use `vim.api.nvim_set_keymap` for mappings
- Use `vim.cmd` for Ex commands
- Group related configurations into tables
- Use `require()` for module imports

### Lua Patterns
```lua
-- Local module pattern
local M = {}

-- Constants
local NVIM_VERSION_MIN = "0.11"

-- Keymaps with vim.api.nvim_set_keymap
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })

-- Grouped config
M.lsp = function()
    -- LSP configuration
end

return M
```

### Tmux Configuration
- Use `#` comments for section headers
- Order: options, keybindings, status line, plugins
- Source local overrides in `tmux.conf.local`
- Use `set -g` for global options, `set -w` for window options
- Prefix key should be `C-a` (custom) or `C-b` (default)
- Source plugin files at the end

### Tmux Configuration Order
```bash
# 1. Options
set -g status-position top
set -g mouse on

# 2. Keybindings
bind C-a send-prefix
unbind C-b

# 3. Status line
set -g status-left "#[fg=green]#S #[fg=blue]#I #[fg=cyan]#P"

# 4. Plugins (at the end)
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
run '~/.tmux/plugins/tpm/tpm'
```

## General Principles

1. **Idempotency**: All scripts should be safe to run multiple times
2. **Error handling**: Fail fast with clear error messages
3. **Cross-platform**: Detect OS (Darwin/Linux) and adapt
4. **Dependencies**: Check prerequisites before operations
5. **Logging**: Use consistent `[dotfiles]` prefix for all output
6. **Git submodules**: Keep synchronized with `git submodule update --init --recursive`

## Work/Personal Mode

The bootstrap script supports two modes:
- **Personal**: Standard dotfiles setup
- **Work**: Additionally clones `git@gitlab.damp.local:niklas.werner/devconfig.git` to `~/devconfig`

Mode is stored in `~/.config/dotfiles/mode` and persists across runs.

```bash
# First run prompts interactively
./bootstrap

# Or specify explicitly
./bootstrap --work
./bootstrap --personal

# Change mode
./bootstrap --work  # Overwrites ~/.config/dotfiles/mode
```

## Git Submodule Management

Submodules are used for dotbot and tmux plugins. Always initialize recursively:
```bash
git submodule update --init --recursive

# After pulling with new submodule changes
git submodule update --init --recursive && git submodule update --remote
```

## Directory Structure

```
dotfiles/
├── bootstrap              # Main installation script
├── install.conf.yaml      # Dotbot configuration
├── .gitmodules           # Git submodule definitions
├── nvim/.config/nvim/    # Neovim configuration
│   ├── .github/
│   │   └── workflows/    # CI/CD for Lua formatting
│   └── ...
├── tmux/
│   ├── .tmux/           # tmux plugin (submodule)
│   ├── .tmux.conf.local # Local tmux overrides
│   └── tmux.conf.local  # Main tmux local config
└── dotbot/              # Dotbot tool (submodule)
```

## Common Tasks

### Adding a New Dotfile
1. Create the file in the appropriate subdirectory
2. Add a link entry to `install.conf.yaml`
3. Run `./dotbot/bin/dotbot -c install.conf.yaml`

### Updating Neovim
1. The bootstrap script handles Neovim installation
2. Minimum version is defined as `NVIM_VERSION_MIN` constant
3. Version check runs automatically on bootstrap

### Testing Changes
```bash
# Test bootstrap script syntax
bash -n bootstrap

# Check dotbot config
./dotbot/bin/dotbot -c install.conf.yaml --dry-run

# Verify Lua formatting
stylua --check nvim/.config/nvim/
```

