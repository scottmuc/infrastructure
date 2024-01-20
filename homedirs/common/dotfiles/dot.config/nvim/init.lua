--[[
This neovim configuration a scattering of influences and I'll attempt to over
explain like my previous .vimrc:

  https://github.com/scottmuc/infrastructure/blob/cb3bb16cf30e2b431af2ff13b90e382e58f47260/homedirs/common/dotfiles/dot.config/nvim/init.vim

This configuration was bootstrapped from the 0 to LSP stuff and was documented
via this video: https://www.youtube.com/watch?v=UPyNOw1_z-U

Now it's pretty far from that configuration.

I'm going to stick with a single file for as long as I can. Until I can recite
the order of operations in a clear and understandable way, I don't feel like
separating things into separate files makes sense for me at the moment.

--]]

-- some inspiration for these settings are comming from:
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
vim.g.mapleader = " "

-- use netrw as a NerdTree replacement
-- https://shapeshed.com/vim-netrw/
vim.keymap.set("n", "<C-n>", vim.cmd.Vexplore)
vim.g.netrw_banner = 0

-- usually ends up being ~/.local/share/nvim/lazy/lazy.nvim
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

-- https://neovim.io/doc/user/options.html#'rtp'
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "overcache/NeoSolarized",
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
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

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "vimdoc",
    "javascript",
    "lua",
    "terraform",
    "bash",
    "html",
    "go",
    "gomod",
    "gowork",
    "gosum",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local lsp = require("lsp-zero")

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ansiblels',
    'bashls',
    'gopls',
  },
  handlers = {
    lsp.default_setup,
  }
})

vim.diagnostic.config({
    virtual_text = false
})

-- shorcuts for editing and loading NeoVim configuration
vim.keymap.set("n", "<leader>ec", ":edit ~/.config/nvim/init.lua<CR>")
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
