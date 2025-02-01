local notify = vim.notify

require('snacks').setup {
  explorer = {},
  input = { enabled = true },
  notifier = {
    enabled = true,
    style = 'fancy',
  },
  picker = {
    sources = {
      explorer = {}
    }
  },
  terminal = {
    win = {
      wo = {
        winbar = ''
      }
    }
  },
  words = { enabled = true },
}
vim.notify = notify

vim.keymap.set('n', '<c-t>', function() Snacks.terminal() end, { desc = 'Terminal (cwd)' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
vim.keymap.set('n', '<C-n>', function() Snacks.explorer() end, { desc = 'Toggle Explorer' })
vim.keymap.set('n', '<leader>u', function() Snacks.picker.undo() end, { desc = 'Undo Picker' })
vim.keymap.set('n', '<leader>i', function() Snacks.picker.icons() end, { desc = 'Icon Picker' })
