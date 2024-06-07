return {
  'folke/tokyonight.nvim',

  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-moon'
      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
