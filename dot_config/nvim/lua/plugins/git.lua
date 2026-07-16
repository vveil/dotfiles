local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'lewis6991/gitsigns.nvim', gh 'akinsho/git-conflict.nvim' }
require('gitsigns').setup {
  signs = { add = { text = '+' }, change = { text = '~' }, delete = { text = '_' }, topdelete = { text = '‾' }, changedelete = { text = '~' } },
  on_attach = function(bufnr)
    local gs = require 'gitsigns'
    local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gs.nav_hunk 'next'
      end
    end, 'Next git change')
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gs.nav_hunk 'prev'
      end
    end, 'Previous git change')
    map('n', '<leader>hs', gs.stage_hunk, 'Git stage hunk')
    map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Git stage hunk')
    map('n', '<leader>hr', gs.reset_hunk, 'Git reset hunk')
    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Git reset hunk')
    map('n', '<leader>hS', gs.stage_buffer, 'Git stage buffer')
    map('n', '<leader>hu', gs.undo_stage_hunk, 'Git undo stage hunk')
    map('n', '<leader>hR', gs.reset_buffer, 'Git reset buffer')
    map('n', '<leader>hp', gs.preview_hunk, 'Git preview hunk')
    map('n', '<leader>hb', gs.blame_line, 'Git blame line')
    map('n', '<leader>hd', gs.diffthis, 'Git diff index')
    map('n', '<leader>hD', function() gs.diffthis '@' end, 'Git diff last commit')
    map('n', '<leader>tb', gs.toggle_current_line_blame, 'Toggle git blame')
    map('n', '<leader>tD', gs.preview_hunk_inline, 'Toggle deleted hunk preview')
  end,
}

require('git-conflict').setup { default_mappings = false, default_commands = true, disable_diagnostics = false, list_opener = 'copen' }
for lhs, action in pairs { ['<leader>go'] = 'ours', ['<leader>gt'] = 'theirs', ['<leader>g2'] = 'both', ['<leader>g0'] = 'none' } do
  vim.keymap.set('n', lhs, '<Plug>(git-conflict-' .. action .. ')', { desc = 'Git conflict: ' .. action })
end
vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Previous conflict' })
vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = 'Next conflict' })
