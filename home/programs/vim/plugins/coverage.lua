require('coverage').setup()

local map = function (mode, key, binding, desc)
  vim.keymap.set(mode, key, binding, { desc = desc, noremap = true, silent = true })
end
map('n', '<leader>cc', '<cmd>Coverage<CR>', 'Code Coverage Load')
map('n', '<leader>ct', '<cmd>CoverageToggle<CR>', 'Code Coverage Toggle')
