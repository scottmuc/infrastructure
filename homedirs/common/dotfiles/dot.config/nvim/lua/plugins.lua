vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-sleuth'
  use 'overcache/NeoSolarized'

  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
end)
