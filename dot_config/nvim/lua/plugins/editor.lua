local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'NMAC427/guess-indent.nvim',
  gh 'folke/which-key.nvim',
  gh 'catppuccin/nvim',
  gh 'folke/todo-comments.nvim',
  gh 'nvim-mini/mini.nvim',
  gh 'kylechui/nvim-surround',
  gh 'OXY2DEV/markview.nvim',
}

require('guess-indent').setup {}
require('which-key').setup {
  delay = 0,
  icons = { mappings = true },
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'x' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'x' } },
    { '<leader>d', group = '[D]ebug' },
    { '<leader>g', group = '[G]it' },
  },
}

require('catppuccin').setup {
  flavour = 'mocha',
  background = { dark = 'mocha', light = 'mocha' },
  integrations = { mini = { enabled = true } },
}
vim.cmd.colorscheme 'catppuccin-mocha'

require('todo-comments').setup { signs = false }
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
require('mini.ai').setup { n_lines = 500 }
require('mini.comment').setup()
local statusline = require 'mini.statusline'
statusline.setup { use_icons = true }
statusline.section_location = function() return '%2l:%-2v' end
require('nvim-surround').setup {}
