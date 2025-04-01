vim.lsp.config['phpactor'] = {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git', '.phpactor.json', '.phpactor.yml' }
}
vim.lsp.enable('phpactor')
