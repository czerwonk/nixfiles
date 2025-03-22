local dap = require('dap')
vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Step Over" })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Step Into" })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Step Out" })
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Breakpoint Condition" })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Run/Continue" })
vim.keymap.set('n', '<leader>dC', dap.run_to_cursor, { desc = "Run to Cursor" })
vim.keymap.set('n', '<leader>dj', dap.down, { desc = "Down" })
vim.keymap.set('n', '<leader>dk', dap.up, { desc = "Up" })
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = "Run Last" })
vim.keymap.set('n', '<leader>dP', dap.pause, { desc = "Pause" })
vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = "Toggle REPL" })
vim.keymap.set('n', '<leader>ds', dap.session, { desc = "Session" })
vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = "Terminate" })

local dapui = require('dapui')
dapui.setup()
vim.keymap.set('n', '<leader>dd', dapui.toggle, { desc = 'Toggle DAP UI' })

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
