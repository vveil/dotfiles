local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'zbirenbaum/copilot.lua' }
require('copilot').setup {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = { accept = '<M-y>', accept_word = false, accept_line = false, next = '<M-]>', prev = '<M-[>', dismiss = '<C-]>' },
  },
  filetypes = { javascript = true, typescript = true, cpp = true, hpp = true, ['*'] = false },
}
