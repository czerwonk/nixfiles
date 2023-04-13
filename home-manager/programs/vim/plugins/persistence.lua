require('persistence').setup {
  options = { "buffers", "curdir", "tabpages", "winsize", "help" }
}
vim.keymap.set('n', '<leader>qs', function() require('persistence').load() end, { desc = "Restore Session" })
vim.keymap.set('n', '<leader>ql', function() require('persistence').load({ last = true }) end, { desc = "Restore Last Session" })
vim.keymap.set('n', '<leader>qd', function() require('persistence').stop() end,  { desc = "Don't Save Current Session"})
