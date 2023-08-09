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

vim.cmd([[
:silent! colorscheme NeoSolarized

" Adds a bit of complexity, but the `background` tool reads the OS level theme
" and returns "light" or "dark" accordingly.
let output=system("background")
execute "set background=".escape(output, ' ')

]])
