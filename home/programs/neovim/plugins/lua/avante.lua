require('avante').setup {
  provider = 'copilot',
  auto_suggestions_provider = 'copilot',
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
  selector = {
    provider = 'snacks',
  },
  file_selector = {
    provider = 'snacks',
  },
  hints = {
    enabled = false,
  },
  system_prompt = function()
    ---@diagnostic disable-next-line: undefined-global
    load_mcphub()
    local hub = require('mcphub').get_hub_instance()
    return hub and hub:get_active_servers_prompt() or ''
  end,
  custom_tools = function()
    ---@diagnostic disable-next-line: undefined-global
    load_mcphub()
    return {
      require('mcphub.extensions.avante').mcp_tool(),
    }
  end,
}

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
