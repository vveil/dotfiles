local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'mfussenegger/nvim-dap',
  gh 'igorlfs/nvim-dap-view',
  gh 'jay-babu/mason-nvim-dap.nvim',
  gh 'Joakker/lua-json5',
}

local function set_dap_highlights()
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#FF1A23' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })
  vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#9BFF7E' })
  vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#A5A6A8' })
end
set_dap_highlights()
vim.api.nvim_create_autocmd('ColorScheme', { callback = set_dap_highlights, desc = 'Restore DAP highlights' })

for name, sign in pairs {
  DapBreakpoint = { text = '', texthl = 'DapBreakpoint' },
  DapBreakpointCondition = { text = '', texthl = 'DapBreakpoint' },
  DapBreakpointRejected = { text = '', texthl = 'DapBreakpointRejected' },
  DapStopped = { text = '󰜴', texthl = 'DapStopped' },
  DapLogPoint = { text = '●', texthl = 'DapLogPoint' },
} do
  vim.fn.sign_define(name, sign)
end

local dap = require 'dap'
dap.defaults.fallback.switchbuf = 'usevisible,usetab,newtab'
require('dap.ext.vscode').json_decode = require('json5').parse
dap.adapters.codelldb = { type = 'executable', command = 'codelldb' }
dap.adapters.lldb = { type = 'executable', command = 'codelldb' }
dap.listeners.on_config.local_lldb_formatters = function(config)
  if config.type ~= 'codelldb' and config.type ~= 'lldb' then return config end
  config.initCommands = config.initCommands or {}
  local formatter = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'ds4_lldb_formatters.py')
  local command = 'command script import ' .. vim.fn.shellescape(formatter)
  if not vim.tbl_contains(config.initCommands, command) then table.insert(config.initCommands, command) end
  return config
end

require('dap-view').setup { auto_toggle = true }
require('mason-nvim-dap').setup { automatic_installation = false, ensure_installed = { 'codelldb' } }

vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = '[D]AP [T]erminate' })
vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[D]AP [R]estart' })
vim.keymap.set('n', '<leader>dn', '<cmd>DapNew<CR>', { desc = '[D]AP [N]ew' })
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP continue' })
vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'DAP step over' })
vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'DAP step into' })
vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'DAP step out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'DAP toggle breakpoint' })
vim.keymap.set('n', '<leader>dB', dap.clear_breakpoints, { desc = 'DAP clear breakpoints' })
vim.keymap.set('n', '<leader>td', '<cmd>DapViewToggle<CR>', { desc = '[T]oggle [D]AP' })
vim.keymap.set('n', '<space>?', function() require('dap-view').hover(nil, true) end, { desc = 'DAP hover' })
