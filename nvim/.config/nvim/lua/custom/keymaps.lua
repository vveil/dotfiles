local uuid = require 'uuid-nvim'

-- Swap the p and P to not mess up the clipbard with replaced text
-- but leave the ability to paste the text
vim.keymap.set('x', 'p', 'P', {})
vim.keymap.set('x', 'P', 'p', {})

vim.keymap.set('n', '<leader>cR', '<cmd>LspClangdSwitchSourceHeader<CR>', { desc = 'Switch Source/FileHeader C/C++', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ut', uuid.toggle_highlighting, { desc = '[U]uid highlight [t]oggle' })
vim.keymap.set('n', '<leader>ui', uuid.insert_v4, { desc = '[U]uid [i]nsert' })

vim.keymap.set('n', '<leader>rn', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { desc = '[R]e[n]ame symbol', expr = true })

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment numbers", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement numbers", noremap = true })
