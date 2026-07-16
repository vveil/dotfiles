local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
}

local ls = require 'luasnip'
local s, t, i = ls.snippet, ls.text_node, ls.insert_node
ls.setup {}
ls.add_snippets('cpp', {
  s('lam', { t '[', i(1, 'capture'), t '](const auto& ', i(2, 'obj'), t ') {', t { '', '\t' }, i(3, '// code here'), t { '', '}' } }),
  s('shp', { t 'SharedPtr<', i(1, 'class'), t '> ', i(2, 'vname'), t ';' }),
  s('mshp', { t 'auto ', i(1, 'vname'), t ' = makeShared<', i(2, 'class'), t '>(', i(3, 'params'), t ');' }),
  s('inc', { t '#include "', i(1, 'file'), t '"' }),
  s('usi', { t 'using namespace ', i(1, 'namespace'), t ';' }),
  s('fds4', { t '#file://', i(1, 'absolute_path'), t '.cpp' }),
})

require('blink.cmp').setup {
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
    per_filetype = { sql = { 'snippets', 'dadbod', 'buffer' } },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
}
