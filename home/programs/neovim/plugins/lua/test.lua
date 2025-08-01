local neotest = require('neotest')
neotest.setup({
  adapters = {
    require("neotest-go"),
    require("neotest-python"),
    require("neotest-dotnet"),
    require("neotest-rust"),
  },
  output = { open_on_run = true },
})

local map = function (mode, key, binding, desc)
  vim.keymap.set(mode, key, binding, { desc = desc, noremap = true, silent = true })
end
map('n', '<leader>tt', function() neotest.run.run() end, 'Run Test')
map('n', '<leader>tT', function() neotest.run.run({strategy = "dap"}) end, 'Debug Test')
map('n', '<leader>ts', function() neotest.run.stop() end, 'Stop Test')
map('n', '<leader>ta', function() neotest.run.attach() end, 'Attach Test')
map('n', '<leader>tl', function() neotest.run.run_last() end, 'Run Last Test')
map('n', '<leader>tL', function() neotest.run.run_last({strategy = "dap"}) end, 'Debug Last Test')
map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand("%")) end, 'Run Tests (File)')
map('n', '<leader>tF', function() neotest.run.run(vim.fn.expand("%"), {strategy = "dap"}) end, 'Debug Tests (File)')
map('n', '<leader>tw', function() neotest.run.run(vim.fn.getcwd()) end, 'Run Tests (Working Directory)')
map('n', '<leader>tW', function() neotest.run.run(vim.fn.getcwd(), {strategy = "dap"}) end, 'Debug Tests (Working Directory)')
map('n', '<leader>tS', function() neotest.summary.toggle() end, 'Toggle Summary')
map('n', '<leader>to', function () neotest.output.open({ enter = true, auto_close = true }) end, 'Show Output')
map('n', '<leader>tO', function () neotest.output_panel.toggle() end, 'Toggle Output Panel')
