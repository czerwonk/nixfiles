vim.lsp.config['helm_ls'] = {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm' },
  root_markers = { 'Chart.yaml' },
}
vim.lsp.enable('helm_ls')

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'} , {
  pattern = '*/templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml',
  callback = function()
    vim.opt_local.filetype = 'helm'
  end
})
