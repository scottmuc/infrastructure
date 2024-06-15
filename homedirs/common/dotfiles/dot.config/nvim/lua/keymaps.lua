local k = vim.keymap

k.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
k.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
k.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
k.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

k.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

k.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
k.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
k.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
k.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

k.set('n', '\\', ':NvimTreeToggle<cr>', { silent = true, noremap = true })
