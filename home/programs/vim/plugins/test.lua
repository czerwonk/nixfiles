local neotest = require('neotest')
neotest.setup({
  adapters = {
    require("neotest-go"),
  },
})

local map = function (mode, key, binding, desc)
  vim.keymap.set(mode, key, binding, { desc = desc, noremap = true, silent = true })
end
map('n', '<leader>tr', function() neotest.run.run() end, 'Run Test')
map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand("%")) end, 'Run Tests (File)')
