require("obsidian").setup({
  workspaces = {
    {
      name = 'work',
      path = '~/notes/work',
    },
    {
      name = 'personal',
      path = '~/notes/personal',
    },
  },
  mappings = {
    ['<leader>nc'] = {
      action = function()
        return require('obsidian').util.toggle_checkbox()
      end,
      opts = { buffer = true, desc = 'Toggle Checkbox' },
    },
  },
})

vim.keymap.set('n', '<Leader>n[', [[:ObsidianYesterday<CR>]], { desc = 'Open notes for yesterday' })
vim.keymap.set('n', '<Leader>nn', [[:ObsidianToday<CR>]], { desc = 'Open notes for today' })
vim.keymap.set('n', '<Leader>n]', [[:ObsidianTomorrow<CR>]], { desc = 'Open notes for tomorrow' })
vim.keymap.set('n', '<Leader>fn', [[:ObsidianSearch<CR>]], { desc = 'Search in notes' })
vim.keymap.set('n', '<Leader>ns', [[:ObsidianQuickSwitch<CR>]], { desc = 'Notes quick switch' })
