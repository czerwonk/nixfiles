local mini_bufremove = require('mini.bufremove')
mini_bufremove.setup {
  silent = true
}
vim.keymap.set('n', '<leader>w', function() mini_bufremove.delete(0, false) end, { desc = 'Close current buffer' })
