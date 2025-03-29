vim.lsp.config['jdtls'] = {
  cmd = { 'jdtls' },
  filetypes = { 'java' },
  root_markers = { '.git', 'build.gradle', 'build.gradle.kts' }
}
vim.lsp.enable('jdtls')
