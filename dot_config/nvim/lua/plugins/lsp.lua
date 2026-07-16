local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'j-hui/fidget.nvim',
  gh 'folke/lazydev.nvim',
}

require('fidget').setup {}
require('lazydev').setup { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = 'LSP: ' .. desc }) end
    map({ 'n', 'x' }, 'ga', vim.lsp.buf.code_action, 'Code action')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local group = vim.api.nvim_create_augroup('lsp-highlight-' .. event.buf, { clear = true })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, { group = group, buffer = event.buf, callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, { group = group, buffer = event.buf, callback = vim.lsp.buf.clear_references })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = group,
        buffer = event.buf,
        once = true,
        callback = function() vim.lsp.buf.clear_references() end,
      })
    end
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('n', '<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle inlay hints')
    end
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
  clangd = {
    cmd = { 'clangd', '--header-insertion=never', '--fallback-style=llvm', '--offset-encoding=utf-16' },
  },
  jsonls = {},
  gopls = {},
  lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
}

require('mason').setup {}
require('mason-tool-installer').setup { ensure_installed = { 'clangd', 'json-lsp', 'gopls', 'lua-language-server', 'stylua' } }
for name, config in pairs(servers) do
  config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
