-- :use :help <option> to see what these things do
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.signcolumn = 'yes'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig', },
	{ src = 'https://github.com/nvim-mini/mini.nvim', },
	{ src = 'https://github.com/scottmckendry/cyberdream.nvim', },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
vim.lsp.enable({
	'ansiblels',
	'bashls',
	'lua_ls',
	'nixd',
})

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

local handle = io.popen 'background'
if not handle then
  return
end

local output = handle:read '*a'
handle:close()

if not output then
  return
end

output = output:gsub('%s+', '')
vim.opt.background = output

require('cyberdream').setup({
	variant = 'auto',
	extensions = { mini = true, },
})

vim.cmd("colorscheme cyberdream")

require('mini.comment').setup {}
require('mini.completion').setup {}
require('mini.diff').setup {}
require('mini.files').setup {}
require('mini.pick').setup {}

local minifiles_toggle = function(...)
	if not MiniFiles.close() then MiniFiles.open(...) end
end

vim.keymap.set('n', '\\', minifiles_toggle)
