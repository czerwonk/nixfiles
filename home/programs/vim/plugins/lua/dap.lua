local dap = require('dap')
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Breakpoint Condition" })
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = "Run/Continue" })
vim.keymap.set('n', '<leader>dC', function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set('n', '<leader>dg', function() dap.goto_() end, { desc = "Go to Line (No Execute)" })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set('n', '<leader>dj', function() dap.down() end, { desc = "Down" })
vim.keymap.set('n', '<leader>dk', function() dap.up() end, { desc = "Up" })
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = "Run Last" })
vim.keymap.set('n', '<leader>do', function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set('n', '<leader>dO', function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set('n', '<leader>dP', function() dap.pause() end, { desc = "Pause" })
vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set('n', '<leader>ds', function() dap.session() end, { desc = "Session" })
vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = "Terminate" })

local dapui = require('dapui')
dapui.setup()
vim.keymap.set('n', '<leader>dd', function() dapui.toggle() end, { desc = 'Toggle DAP UI' })

vim.fn.sign_define('DapBreakpoint',{ text =' ', texthl ='DiagnosticWarn', linehl ='', numhl =''})
vim.fn.sign_define('DapBreakpointCondition',{ text =' ', texthl ='DiagnosticWarn', linehl ='', numhl =''})
vim.fn.sign_define('DapBreakpointRejected',{ text =' ', texthl ='DiagnosticError', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='󰁕', texthl ='DiagnosticWarn', linehl ='DapStoppedLine', numhl =''})
vim.fn.sign_define('DapLogPoint',{ text ='.>', texthl ='DiagnosticWarn', linehl ='', numhl =''})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
