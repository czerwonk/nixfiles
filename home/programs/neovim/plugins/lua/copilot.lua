require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    max_lines = 10,
    keymap = {
      accept = '<Tab>',
      accept_word = '<C-l>',
      accept_line = '<C-k>',
      next = '<M-]>',
      prev = '<M-[>',
      dismiss = '<C-g>',
    },
  },
  panel = {
    enabled = false,
  },
  copilot_node_command = 'node',
})

vim.keymap.set('n', '<leader>C', function()
  require("copilot.suggestion").toggle_auto_trigger()
end, { noremap = true, silent = true, desc = "Toggle Copilot Auto Trigger" })
