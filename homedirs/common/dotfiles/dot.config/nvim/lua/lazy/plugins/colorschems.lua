return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      require 'selected_colorscheme'

      vim.cmd [[
        " Adds a bit of complexity, but the `background` tool reads the OS
        " level theme and returns "light" or "dark" accordingly.
        let output=system("background")
        execute "set background=".escape(output, ' ')
      ]]
    end,
  },
}
