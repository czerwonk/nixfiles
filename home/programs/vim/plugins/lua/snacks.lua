local notify = vim.notify

require('snacks').setup {
  input = { enabled = true },
  notifier = {
    enabled = true,
    style = 'fancy',
  },
  words = { enabled = true },
  terminal = {
    win = {
      wo = {
        winbar = ''
      }
    }
  }
}
vim.notify = notify

vim.keymap.set('n', '<c-t>', function() Snacks.terminal() end, { desc = 'Terminal (cwd)' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
