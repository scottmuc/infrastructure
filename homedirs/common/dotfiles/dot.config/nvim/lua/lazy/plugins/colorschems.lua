return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'cyberdream-light'
    end,
  },
}
