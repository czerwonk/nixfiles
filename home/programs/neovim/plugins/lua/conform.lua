local conform = require('conform')
conform.setup {
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    css = { 'prettierd' },
    html = { 'prettierd' },
    javascript = { 'prettierd' },
    json = { 'prettierd' },
    lua = { 'stylua' },
    markdown = { 'prettierd' },
    nix = { 'nixfmt' },
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
        "--call-parentheses", "NoSingleTable",
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

local format_for_extensions = { "css", "html", "js", "json", "nix", "py", "ts", "yml", "yaml"}
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*." .. table.concat(format_for_extensions, ",*."),
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
})

vim.keymap.set('n', '<leader>F', conform.format, { desc = 'Format'})
