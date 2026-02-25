-- ============================================================================
-- Vim Options/Settings
-- ============================================================================

-- Leader key
vim.g.mapleader = ' '

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Line centering
vim.opt.scrolloff = 999

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = '→ ', space = '·' }

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- UI
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false

-- Window splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Better completion menu
vim.opt.completeopt = 'menu,menuone,noselect'

-- Save undo history to a file
vim.opt.undofile = true

-- Faster updates (for LSP)
vim.opt.updatetime = 250

-- Python path
vim.g.python3_host_prog = vim.fn.exepath('python3')
