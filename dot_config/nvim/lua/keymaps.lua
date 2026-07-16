vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>tr', '<cmd>set relativenumber!<CR>', { desc = '[T]oggle [R]elative line numbers' })
vim.keymap.set('n', '<leader>tn', function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = '[T]oggle line [N]umbers' })

vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = -1 } end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = 1 } end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

for key, direction in pairs { h = 'Left', j = 'Down', k = 'Up', l = 'Right' } do
  vim.keymap.set('n', '<C-' .. key .. '>', '<cmd>TmuxNavigate' .. direction .. '<CR>', { desc = 'Move focus ' .. direction:lower() })
end

for key, direction in pairs { left = 'h', right = 'l', up = 'k', down = 'j' } do
  vim.keymap.set('n', '<' .. key .. '>', '<cmd>echo "Use ' .. direction .. ' to move!!"<CR>')
end

vim.keymap.set('x', 'p', 'P')
vim.keymap.set('x', 'P', 'p')
vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment numbers' })
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement numbers' })
vim.keymap.set('n', '<leader>cR', '<cmd>LspClangdSwitchSourceHeader<CR>', { desc = 'Switch C/C++ source/header' })

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = { source = 'if_many', spacing = 2 },
}
