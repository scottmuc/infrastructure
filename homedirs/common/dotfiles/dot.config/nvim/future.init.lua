print("Hello from lua config!")

vim.opt.number = true -- Enable line numbers. This is off by default
vim.opt.relativenumber = true
vim.opt.hidden = true -- allows modified buffers to be hidden

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.g.mapleader = ","
