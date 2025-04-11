require('avante').setup {
  provider = 'copilot',
  auto_suggestions_provider = 'copilot',
  copilot = {
    model = 'claude-3.7-sonnet',
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<Tab>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
  },
  ollama = {
    model = 'gemma3',
  },
  file_selector = {
    provider = 'snacks',
  },
  hints = {
    enabled = false,
  },
  web_search_engine = {
    provider = 'google',
  },
}

require('which-key').add({
  { '<leader>a', group = 'AI' },
});

local blink = require('blink.cmp')
blink.add_source_provider('avante_commands', {
  name = 'avante_commands',
  module = 'blink.compat.source',
  score_offset = 90, -- show at a higher priority than lsp
  opts = {},
})
blink.add_source_provider('avante_files', {
  name = 'avante_files',
  module = 'blink.compat.source',
  score_offset = 100, -- show at a higher priority than lsp
  opts = {},
})
blink.add_source_provider('avante_mentions', {
  name = 'avante_mentions',
  module = 'blink.compat.source',
  score_offset = 1000, -- show at a higher priority than lsp
  opts = {},
})
