local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'christoomey/vim-tmux-navigator',
  gh 'stevearc/oil.nvim',
  gh 'Bekaboo/dropbar.nvim',
  gh 'mg979/vim-visual-multi',
  gh 'TrevorS/uuid-nvim',
  gh 'smjonas/inc-rename.nvim',
  gh 'saecki/crates.nvim',
}

require('oil').setup {
  view_options = { show_hidden = true, natural_order = 'fast' },
  float = { preview_split = 'right', padding = 1, max_width = 120, max_height = 32 },
}
vim.keymap.set('n', '<leader>oo', '<cmd>Oil<CR>', { desc = 'Open [O]il' })
vim.keymap.set('n', '<leader>of', '<cmd>Oil --float<CR>', { desc = 'Open [O]il [F]loat' })

local default_dropbar_enable = require('dropbar.configs').opts.bar.enable
require('dropbar').setup {
  bar = {
    enable = function(buf, win, info)
      if vim.tbl_contains({ 'dap-view', 'dap-view-term', 'dap-view-hover', 'dap-view-help' }, vim.bo[buf].filetype) then return false end
      return default_dropbar_enable(buf, win, info)
    end,
  },
}
local dropbar = require 'dropbar.api'
vim.keymap.set('n', '<leader>;', dropbar.pick, { desc = 'Pick symbols in winbar' })
vim.keymap.set('n', '[;', dropbar.goto_context_start, { desc = 'Context start' })
vim.keymap.set('n', '];', dropbar.select_next_context, { desc = 'Next context' })

require('uuid-nvim').setup { case = 'lower' }
vim.keymap.set('n', '<leader>ut', require('uuid-nvim').toggle_highlighting, { desc = '[U]UID highlight [T]oggle' })
vim.keymap.set('n', '<leader>ui', require('uuid-nvim').insert_v4, { desc = '[U]UID [I]nsert' })
require('inc_rename').setup {}
vim.keymap.set('n', '<leader>rn', function() return ':IncRename ' .. vim.fn.expand '<cword>' end, { desc = '[R]e[N]ame symbol', expr = true })
require('crates').setup()
