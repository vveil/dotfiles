# Neovim configuration

Modular Neovim 0.12 configuration based on
[`dam9000/kickstart-modular.nvim`](https://github.com/dam9000/kickstart-modular.nvim)
commit `af4c513`.

## Structure

- `init.lua`: ordered module entry point
- `lua/options.lua`: editor options
- `lua/keymaps.lua`: plugin-independent mappings and diagnostics
- `lua/autocmds.lua`: editor autocommands
- `lua/pack.lua`: `vim.pack` build hooks
- `lua/plugins.lua`: ordered plugin module loader
- `lua/plugins/`: focused plugin configuration
- `lua/custom/`: local debugger helpers

Plugin revisions are tracked in `nvim-pack-lock.json`. Update plugins with
`:lua vim.pack.update()` and apply accepted changes with `:write`.

The previous configuration is preserved at `~/.config/nvim-old`. Start it with
`NVIM_APPNAME=nvim-old nvim`.
