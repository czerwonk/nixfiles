local dap = require('dap')
local fzf = require('fzf-lua')

vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Continue' })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Step over' })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Step into' })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Step out' })
vim.keymap.set('n', '<leader>dd', fzf.dap_configurations, { desc = 'Run Configuration' })
vim.keymap.set('n', '<leader>dc', fzf.dap_commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>dv', fzf.dap_variables, { desc = 'Variables' })
vim.keymap.set('n', '<leader>df', fzf.dap_frames, { desc = 'Frames' })
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Breakpoint with message' })
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Run Last' })
vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = 'Terminate' })
vim.keymap.set('n', '<leader>dp', function() dap.pause() end, { desc = 'Pause' })
vim.keymap.set({'n', 'v'}, '<leader>dw', function()
  require('dap.ui.widgets').hover()
end, { desc = 'Widgets' })

vim.fn.sign_define('DapBreakpoint',{ text =' ', texthl ='DiagnosticWarn', linehl ='', numhl =''})
vim.fn.sign_define('DapBreakpointCondition',{ text =' ', texthl ='DiagnosticWarn', linehl ='', numhl =''})
vim.fn.sign_define('DapBreakpointRejected',{ text =' ', texthl ='DiagnosticError', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='󰁕', texthl ='DiagnosticWarn', linehl ='DapStoppedLine', numhl =''})
vim.fn.sign_define('DapLogPoint',{ text ='.>', texthl ='DiagnosticWarn', linehl ='', numhl =''})

local dapui = require('dapui')
dapui.setup() dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

require('dap-go').setup()
