require('render-markdown').setup {
  completions = {
    blink = {
      enabled = true
    },
    lsp = {
      enabled = true
    }
  },
  file_types = { 'markdown' },
};
