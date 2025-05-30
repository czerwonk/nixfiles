require('avante').setup {
  provider = 'copilot',
  hints = {
    enabled = false,
  },
  selector = {
    provider = 'snacks',
  },
  file_selector = {
    provider = 'snacks',
  },
  copilot = {
    model = 'gemini-2.5-pro',
  },
  gemini = {
    model = 'gemini-2.5-flash-preview-05-20',
  },
  openai = {
    model = 'o4-mini',
  },
  ollama = {
    model = 'gemma3',
  },
  custom_tools = function()
    ---@diagnostic disable-next-line: undefined-global
    load_mcphub()
    return {
      require('mcphub.extensions.avante').mcp_tool(),
    }
  end,
  system_prompt = function()
    ---@diagnostic disable-next-line: undefined-global
    load_mcphub()
    local hub = require('mcphub').get_hub_instance()
    return hub and hub:get_active_servers_prompt() or ''
  end,
}

local prefill_edit_window = function(request)
  require('avante.api').edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then
    return
  end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  -- Optionally set the cursor position to the end of the input
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  -- Simulate Ctrl+S keypress to submit
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-s>', true, true, true), 'v', true)
end

local avante_optimize_code = 'Optimize the following code'
local avante_summarize = 'Summarize the following text'
local avante_add_docstring = 'Add docstring to the following code'
local avante_fix_bugs = 'Fix the bugs inside the following codes if any'
local avante_add_tests = 'Implement tests for the following code'

vim.keymap.set('v', '<leader>aC', function()
  prefill_edit_window(avante_add_docstring)
end, { desc = 'Avante: Add docstring' })
vim.keymap.set('v', '<leader>aO', function()
  prefill_edit_window(avante_optimize_code)
end, { desc = 'Avante: Optimize code' })
vim.keymap.set('v', '<leader>aS', function()
  prefill_edit_window(avante_summarize)
end, { desc = 'Avante: Summarize code' })
vim.keymap.set('v', '<leader>aF', function()
  prefill_edit_window(avante_fix_bugs)
end, { desc = 'Avante: Fix bugs' })
vim.keymap.set('v', '<leader>aT', function()
  prefill_edit_window(avante_add_tests)
end, { desc = 'Avante: Add tests' })

require('which-key').add {
  { '<leader>a', group = 'AI' },
}

local blink = require('blink.cmp')
blink.add_source_provider('avante_commands', {
  name = 'avante_commands',
  module = 'blink.compat.source',
  score_offset = 90, -- show at a higher priority than lsp
  opts = {},
})
blink.add_filetype_source('AvanteInput', 'avante_commands')

blink.add_source_provider('avante_files', {
  name = 'avante_files',
  module = 'blink.compat.source',
  score_offset = 100, -- show at a higher priority than lsp
  opts = {},
})
blink.add_filetype_source('AvanteInput', 'avante_files')

blink.add_source_provider('avante_mentions', {
  name = 'avante_mentions',
  module = 'blink.compat.source',
  score_offset = 1000, -- show at a higher priority than lsp
  opts = {},
})
blink.add_filetype_source('AvanteInput', 'avante_mentions')

blink.add_source_provider('avante_prompt_mentions', {
  name = 'avante_prompt_mentions',
  module = 'blink.compat.source',
  score_offset = 1000, -- show at a higher priority than lsp
  opts = {},
})
blink.add_filetype_source('AvantePromptInput', 'avante_prompt_mentions')
