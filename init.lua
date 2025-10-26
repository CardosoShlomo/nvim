-- Neovim init.lua

-- Basic Settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.termguicolors = true
vim.opt.swapfile = false

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Load configurations
require("config.keymaps")
require("config.lsp")
require("config.autocmd")
require("config.lazy")

-- Folding (treesitter)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false
vim.opt.foldminlines = 2
-- Save folds per file
vim.opt.viewoptions:append("folds")
