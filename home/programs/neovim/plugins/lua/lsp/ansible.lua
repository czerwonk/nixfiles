vim.lsp.config['ansiblels'] = {
  cmd = { 'ansible-language-server', '--stdio' },
  filetypes = { 'yaml.ansible' },
  root_markers = { 'ansible.cfg', '.ansible-lint' },
  settings = {
    ansible = {
      python = {
        interpreterPath = 'python',
      },
      ansible = {
        path = 'ansible',
      },
      executionEnvironment = {
        enabled = false,
      },
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          path = 'ansible-lint',
        },
      },
    },
  },
}
vim.lsp.enable('ansiblels')
