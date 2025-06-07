require('llm').setup {
  backend = 'ollama',
  model = 'hf.co/JetBrains/Mellum-4b-base-gguf:Q8_0',
  url = 'http://localhost:11434',
  request_body = {
    parameters = {
      temperature = 0.1,
      top_p = 0.95,
    },
  },
  accept_keymap = '<Tab>',
  dismiss_keymap = '<C-g>',
}

vim.keymap.set('i', '<S-Tab>', '<Tab>', { remap = false })

vim.keymap.set('n', '<leader>as', function()
  vim.cmd('LLMToggleAutoSuggest')
end, { noremap = true, silent = true, desc = 'Toggle LLM Suggestions' })
