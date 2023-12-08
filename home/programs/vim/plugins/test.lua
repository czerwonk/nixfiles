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
map('n', '<leader>ts', function() neotest.run.stop() end, 'Stop Test')
map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand("%")) end, 'Run Tests (File)')
map('n', '<leader>ta', function() neotest.run.attach() end, 'Attach Test')
map('n', '<leader>td', function() neotest.run.run({strategy = "dap"}) end, 'Debug Test')
map('n', '<leader>to', '<cmd>Neotest output toggle<CR>', 'Toggle Output')
map('n', '<leader>tO', '<cmd>Neotest output-panel toggle<CR>', 'Toggle Output Panel')
map('n', '<leader>tS', '<cmd>Neotest summary toggle<CR>', 'Toggle Summary')
