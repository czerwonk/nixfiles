local dap = require('dap')
local dapui = require('dapui')

vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Continue' })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Step over' })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Step into' })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Step out' })
vim.keymap.set('n', '<leader>dd', function() dapui.toggle() end, { desc = 'Toggle DAP UI' })
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Breakpoint with message' })
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Run Last' })
vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = 'Terminate' })
vim.keymap.set('n', '<leader>dp', function() dap.pause() end, { desc = 'Pause' })

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

require('dap-go').setup()
