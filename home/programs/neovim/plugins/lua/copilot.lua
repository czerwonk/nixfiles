require('copilot').setup {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    max_lines = 10,
    keymap = {
      accept = '<Tab>',
      accept_word = false,
      accept_line = '<C-l>',
      next = '<C-j>',
      prev = '<C-k>',
      dismiss = '<C-g>',
    },
  },
  panel = {
    enabled = false,
  },
  copilot_node_command = 'node',
}

vim.keymap.set('i', '<S-Tab>', '<Tab>', { remap = false })

vim.keymap.set('n', '<leader>as', function()
  require('copilot.suggestion').toggle_auto_trigger()
end, { noremap = true, silent = true, desc = 'Toggle Copilot Suggestions' })
