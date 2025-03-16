require('avante').setup {
  provider = 'copilot',
  auto_suggestions_provider = 'copilot',
  copilot = {
    model = 'claude-3.7-sonnet',
  },
  ollama = {
    model = 'qwen2.5-coder',
  },
  file_selector = {
    provider = 'snacks',
  },
  hints = {
    enabled = false,
  },
}

require('which-key').add({
  { '<leader>a', group = 'AI' },
});

local blink = require('blink.cmp')
blink.add_provider('avante_commands', {
  name = 'avante_commands',
  module = 'blink.compat.source',
  score_offset = 90, -- show at a higher priority than lsp
  opts = {},
})
blink.add_provider('avante_files', {
  name = 'avante_files',
  module = 'blink.compat.source',
  score_offset = 100, -- show at a higher priority than lsp
  opts = {},
})
blink.add_provider('avante_mentions', {
  name = 'avante_mentions',
  module = 'blink.compat.source',
  score_offset = 1000, -- show at a higher priority than lsp
  opts = {},
})
