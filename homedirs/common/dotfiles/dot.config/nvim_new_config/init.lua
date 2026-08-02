-- I like my leader to be space... for reasons
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw from loading, needs to be one of the first things set
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.swapfile = false

-- always include a sign column which stops LSP warnings/errors from
-- reindenting things all the time
vim.opt.signcolumn = 'yes'

-- enable the new loader, I believe this is required to use the built in
-- pluging dependency installer.
vim.loader.enable()

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
