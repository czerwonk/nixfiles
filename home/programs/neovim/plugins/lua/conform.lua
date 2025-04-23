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
    css = { 'prettierd' },
    hcl = { 'hclfmt' },
    html = { 'prettierd' },
    javascript = { 'prettierd' },
    json = { 'prettierd' },
    lua = { 'stylua' },
    markdown = { 'prettierd' },
    python = { 'black' },
    sh = { 'shfmt' },
    typescript = { 'prettierd' },
    yaml = { 'prettierd' },
    ["_"] = { "trim_whitespace" },
  },
  formatters = {
    stylua = {
      prepend_args = {
        "--indent-type", "Spaces",
        "--indent-width", "2",
        "--quote-style","AutoPreferSingle",
      },
    },
    shfmt = {
      prepend_args = {
        "-i", "2",
        "-bn", -- allow binary ops at the begging of a line
        "-ns", -- disable line splitting
      },
    },
  },
}

vim.keymap.set('n', '<leader>F', conform.format, { desc = 'Format'})
