local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  default_format_opts = { lsp_format = 'fallback' },
  format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
  formatters_by_ft = {
    lua = { 'stylua' },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
    h = { 'clang_format' },
    hpp = { 'clang_format' },
  },
}
vim.keymap.set({ 'n', 'x' }, '<leader>f', function() require('conform').format { async = true, lsp_format = 'fallback' } end, { desc = '[F]ormat buffer' })
