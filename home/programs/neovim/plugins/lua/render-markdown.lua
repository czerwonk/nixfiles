require('render-markdown').setup {
  completions = {
    lsp = {
      enabled = true
    }
  },
  file_types = { 'markdown', 'Avante' },
};

local blink = require('blink.cmp')
blink.add_source_provider('markdown', {
  name = 'RenderMarkdown',
  module = 'render-markdown.integ.blink',
  fallbacks = { 'lsp' },
})
blink.add_filetype_source('markdown', 'markdown')
