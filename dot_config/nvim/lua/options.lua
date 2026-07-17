vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.db_ui_use_nerd_fonts = 1

if vim.fn.executable 'rg' == 0 then
  local mise_rg = vim.fs.joinpath(vim.env.HOME, '.local', 'share', 'mise', 'installs', 'ripgrep', 'latest', 'bin')
  if vim.uv.fs_stat(vim.fs.joinpath(mise_rg, 'rg')) then vim.env.PATH = mise_rg .. ':' .. (vim.env.PATH or '') end
end

local opt = vim.opt
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 20
opt.confirm = true
opt.shiftwidth = 4
opt.smarttab = true
opt.swapfile = false
opt.shell = '/bin/zsh'
opt.winborder = 'rounded'
opt.foldmethod = 'indent'
opt.foldlevel = 99
opt.diffopt = { 'internal', 'filler', 'closeoff', 'linematch:60' }

vim.schedule(function() opt.clipboard = 'unnamedplus' end)
