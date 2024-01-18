-- some inspiration for these settings are comming from:
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
vim.g.mapleader = " "

require('plugins')

-- use netrw as a NerdTree replacement
vim.keymap.set("n", "<C-n>", vim.cmd.Ex)

-- shorcuts for editing and loading NeoVim configuration
vim.keymap.set("n", "<leader>ec", ":edit ~/.config/nvim/<CR>")
vim.keymap.set("n", "<leader>sc", ":source $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>cs", ":vs ~/GlobalShare/Obsidian/Scott's World/NeoVim Cheat Sheet.md<CR>")

-- move blocks of text visually
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- when joining, don't change where the cursor sits
vim.keymap.set("n", "J", "mzJ`z")

-- replace without entering the replaced text in the default register
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.opt.number = true -- Enable line numbers. This is off by default
vim.opt.relativenumber = true
vim.opt.hidden = true -- allows modified buffers to be hidden

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

vim.cmd([[
:silent! colorscheme NeoSolarized

" Adds a bit of complexity, but the `background` tool reads the OS level theme
" and returns "light" or "dark" accordingly.
let output=system("background")
execute "set background=".escape(output, ' ')

]])
