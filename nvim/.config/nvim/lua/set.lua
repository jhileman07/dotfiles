-- line numbers and relative
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab length
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.updatetime = 50

vim.opt.colorcolumn = "80"

-- always keep the cursor vertically centered (except near file ends)
vim.opt.scrolloff = 999
-- a little horizontal padding feels nicer when scrolling sideways
vim.opt.sidescrolloff = 8

vim.opt.signcolumn = "yes"

-- file management
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
