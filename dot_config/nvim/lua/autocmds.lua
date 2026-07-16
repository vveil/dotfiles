local yank_group = vim.api.nvim_create_augroup('highlight-yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  callback = function() vim.hl.on_yank() end,
  desc = 'Highlight yanked text',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'h', 'hpp' },
  callback = function() vim.opt_local.commentstring = '// %s' end,
  desc = 'Use C-style comments',
})
