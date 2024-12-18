local notify = vim.notify

local highlight = {
    'CursorColumn',
    'Whitespace',
}
require('snacks').setup {
  indent = {
    enabled = true,
    hl = highlight,
    scope = {
      enabled = false
    }
  },
  notifier = {
    enabled = true,
    style = 'fancy',
  },
}
vim.notify = notify

vim.keymap.set('n', '<c-t>', function() Snacks.terminal() end, { desc = 'Terminal (cwd)' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
