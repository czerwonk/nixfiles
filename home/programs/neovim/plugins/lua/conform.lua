local conform = require('conform')
conform.setup {
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    css = { 'prettierd' },
    html = { 'prettierd' },
    javascript = { 'prettierd' },
    json = { 'prettierd' },
    lua = { 'stylua' },
    markdown = { 'prettierd' },
    nix = { 'nixfmt' },
    php = { 'php_cs_fixer' },
    python = { 'black' },
    rust = { "rustfmt" },
    sh = { 'shfmt', 'trim_whitespace' },
    typescript = { 'prettierd' },
    yaml = { 'prettierd' },
    zsh = { 'shfmt', 'trim_whitespace' },
    ['_'] = { 'trim_whitespace' },
  },
  formatters = {
    stylua = {
      prepend_args = {
        '--indent-type',
        'Spaces',
        '--indent-width',
        '2',
        '--quote-style',
        'AutoPreferSingle',
        '--call-parentheses',
        'NoSingleTable',
      },
    },
    shfmt = {
      prepend_args = {
        '--indent',
        '2',
        '--binary-next-line',
        '--keep-padding',
        '--space-redirects',
      },
    },
    php_cs_fixer = {
      command = 'php-cs-fixer',
      args = {
        'fix',
        '--rules=@PSR12,@Symfony',
        '--using-cache=no',
        '--no-interaction',
        '--quiet',
        '$FILENAME',
      },
      stdin = false,
    },
  },
}

local format_for_extensions = {
  'bash',
  'css',
  'html',
  'js',
  'json',
  'nix',
  'py',
  'rb',
  'rs',
  'sh',
  'ts',
  'yaml',
  'yml'
}
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.' .. table.concat(format_for_extensions, ',*.'),
  callback = function(args)
    conform.format { bufnr = args.buf }
  end,
})

vim.keymap.set('n', '<leader>F', conform.format, { desc = 'Format' })
