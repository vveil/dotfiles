local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'folke/snacks.nvim' }

local source_opts = { hidden = true, ignored = true, exclude = { '.git', 'build', '.cache', 'StaticSourceList.cmake' } }
local sources = {}
for _, name in ipairs { 'files', 'explorer', 'grep', 'grep_word', 'grep_buffers' } do
  sources[name] = source_opts
end

require('snacks').setup {
  bigfile = { enabled = false },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = false },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
  input = { enabled = false },
  image = { enabled = false },
  scratch = { enabled = false },
  terminal = { enabled = false },
  picker = { enabled = true, sources = sources },
  notifier = { enabled = true, timeout = 2000 },
  quickfile = { enabled = true },
  words = { enabled = true },
}

local picker_maps = {
  { '<leader><space>', function() Snacks.picker.buffers() end, 'Buffers' },
  { '<leader>ssf', function() Snacks.picker.smart() end, 'Smart find files' },
  { '<leader>s.', function() Snacks.picker.recent() end, 'Recent files' },
  { '<leader>sb', function() Snacks.picker.lines() end, 'Buffer lines' },
  { '<leader>sf', function() Snacks.picker.files() end, 'Find files' },
  { '<leader>sg', function() Snacks.picker.grep() end, 'Grep' },
  { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, 'Find config file' },
  { '<leader>sr', function() Snacks.picker.resume() end, 'Resume picker' },
  { '<leader>ssg', function() Snacks.picker.grep_buffers() end, 'Grep open buffers' },
  { 'gd', function() Snacks.picker.lsp_definitions() end, 'Goto definition' },
  { 'gD', function() Snacks.picker.lsp_declarations() end, 'Goto declaration' },
  { 'gr', function() Snacks.picker.lsp_references() end, 'References' },
  { 'gI', function() Snacks.picker.lsp_implementations() end, 'Goto implementation' },
  { 'gy', function() Snacks.picker.lsp_type_definitions() end, 'Goto type definition' },
  { '<leader>sss', function() Snacks.picker.lsp_symbols() end, 'LSP symbols' },
  { '<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end, 'Workspace symbols' },
  { '<leader>gb', function() Snacks.picker.git_branches() end, 'Git branches' },
  { '<leader>gl', function() Snacks.picker.git_log() end, 'Git log' },
  { '<leader>gL', function() Snacks.picker.git_log_line() end, 'Git line log' },
  { '<leader>gs', function() Snacks.picker.git_status() end, 'Git status' },
  { '<leader>gS', function() Snacks.picker.git_stash() end, 'Git stash' },
  { '<leader>gd', function() Snacks.picker.git_diff() end, 'Git diff' },
  { '<leader>gf', function() Snacks.picker.git_log_file() end, 'Git file log' },
  { '<leader>sc', function() Snacks.picker.command_history() end, 'Command history' },
  { '<leader>sC', function() Snacks.picker.commands() end, 'Commands' },
  { '<leader>sD', function() Snacks.picker.diagnostics() end, 'Diagnostics' },
  { '<leader>sd', function() Snacks.picker.diagnostics_buffer() end, 'Buffer diagnostics' },
  { '<leader>sh', function() Snacks.picker.help() end, 'Help pages' },
  { '<leader>sH', function() Snacks.picker.highlights() end, 'Highlights' },
  { '<leader>si', function() Snacks.picker.icons() end, 'Icons' },
  { '<leader>sj', function() Snacks.picker.jumps() end, 'Jumps' },
  { '<leader>sk', function() Snacks.picker.keymaps() end, 'Keymaps' },
  { '<leader>sl', function() Snacks.picker.loclist() end, 'Location list' },
  { '<leader>sm', function() Snacks.picker.marks() end, 'Marks' },
  { '<leader>sM', function() Snacks.picker.man() end, 'Man pages' },
  { '<leader>n', function() Snacks.notifier.show_history() end, 'Notification history' },
}
for _, map in ipairs(picker_maps) do
  vim.keymap.set('n', map[1], map[2], { desc = map[3], nowait = map[1] == 'gr' })
end
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Visual selection or word' })
vim.keymap.set({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next reference' })
vim.keymap.set({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Previous reference' })
