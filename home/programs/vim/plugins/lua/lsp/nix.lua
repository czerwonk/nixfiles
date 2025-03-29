vim.lsp.config['nil_ls'] = {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', '.git' },
}
vim.lsp.enable('nil_ls')
