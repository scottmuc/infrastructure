return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      require 'selected_colorscheme'
    end,
  },
}
