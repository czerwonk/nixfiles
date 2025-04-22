local conform = require('conform')
conform.setup {
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    ansible = { 'ansible-lint' },
    css = { 'dprint' },
    dockerfile = { 'dprint' },
    hcl = { "hclfmt" },
    html = { 'dprint' },
    javascript = { 'dprint' },
    json = { 'dprint' },
    lua = { 'stylua' },
    markdown = { 'dprint' },
    python = { 'black' },
    typescript = { 'dprint' },
    yaml = { 'dprint' },
    ["_"] = { "trim_whitespace" },
  },
}

vim.keymap.set('n', '<leader>F', conform.format, { desc = 'Format'})
