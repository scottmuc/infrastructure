return {
  {
    'github/copilot.vim',
    config = function()
      -- Disable copilot autocompletion text from appearing all the time. Use the default <M-\> to
      -- request a Copilot suggestion.
      vim.g.copilot_enabled = false
      -- Disable TAB from accepting a completion.
      vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, noremap = true, silent = true })
      vim.g.copilot_no_tab_map = true
    end,
  },
}
