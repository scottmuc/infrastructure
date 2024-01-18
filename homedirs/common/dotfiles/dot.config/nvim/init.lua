-- some inspiration for these settings are comming from:
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "overcache/NeoSolarized",
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  },
})

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
