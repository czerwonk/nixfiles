require('copilot').setup {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    max_lines = 10,
    keymap = {
      accept = '<C-y>',
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

vim.keymap.set('i', '<Tab>', function()
  if require('copilot.suggestion').is_visible() then
    require('copilot.suggestion').accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
  end
end, { silent = true })

vim.keymap.set('i', '<S-Tab>', '<Tab>', { remap = false })

vim.keymap.set('n', '<leader>C', function()
  require('copilot.suggestion').toggle_auto_trigger()
end, { noremap = true, silent = true, desc = 'Toggle Copilot Auto Trigger' })
