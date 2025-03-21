-- Neovim options

-- Basic settings
vim.wo.relativenumber = true
vim.opt.showtabline = 0
vim.opt.colorcolumn = "88"

-- Tab and indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.breakindent = true

-- Search settings
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

-- Line numbers
vim.wo.number = true

-- Mouse and clipboard
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'

-- File and buffer management
vim.o.undofile = true
vim.wo.signcolumn = 'yes'

-- Performance and timing
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Completion
vim.o.completeopt = 'menuone,noselect'

-- Appearance
vim.o.termguicolors = true
