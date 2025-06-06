---@diagnostic disable: undefined-global
require('snacks').setup {
  bigfile = {
    enabled = true,
    size = 10 * 1024 * 1024, -- 10MB
  },
  explorer = { enabled = true },
  quickfile = { enabled = true },
  input = { enabled = true },
  notifier = {
    enabled = true,
    style = 'fancy',
  },
  picker = {
    ui_select = true,
  },
  terminal = {
    win = {
      wo = {
        winbar = ''
      },
    },
  },
  words = { enabled = true },
}

vim.keymap.set('n', '<c-t>', function() Snacks.terminal() end, { desc = 'Terminal (cwd)' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
vim.keymap.set('n', '<C-n>', function() Snacks.explorer() end, { desc = 'Toggle Explorer' })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
vim.keymap.set('n', '<leader>u', function() Snacks.picker.undo() end, { desc = 'Undo Picker' })
vim.keymap.set('n', '<leader>i', function() Snacks.picker.icons() end, { desc = 'Icon Picker' })
vim.keymap.set('n', '<leader>mm', function() Snacks.picker.marks() end, { desc = 'Mark Picker' })
vim.keymap.set('n', '<leader>ft', function() Snacks.picker.todo_comments() end, { desc = 'TODO Comments' })
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fc', function() Snacks.picker.commands() end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Files' })
vim.keymap.set('n', '<leader>fF', function() Snacks.picker.git_files() end, { desc = 'Files (git)' })
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.grep() end, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fj', function() Snacks.picker.jumps() end, { desc = 'Jumplist' })
vim.keymap.set('n', '<leader>fk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fq', function() Snacks.picker.qflist() end, { desc = 'Quickfix' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Files (recent)' })
vim.keymap.set('n', '<leader>fG', function() Snacks.picker.git_log() end, { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>.', function() Snacks.scratch({ win = { width = 0.99, height = 0.99 } }) end, { desc = 'Toggle Scratch Buffer' })
vim.keymap.set('n', '<leader>s', function() Snacks.scratch.select() end, { desc = 'Scratch Buffers' })
