return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      -- background is a CLI tool that I wrote to return what the system
      -- background is set to. It only returns dark or light.
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
      vim.o.background = output

      if output == 'dark' then
        vim.cmd.colorscheme 'cyberdream'
      elseif output == 'light' then
        vim.cmd.colorscheme 'cyberdream-light'
      end
    end,
  },
}
