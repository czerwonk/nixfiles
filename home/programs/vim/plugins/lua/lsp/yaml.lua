vim.lsp.config['yamlls'] = {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      hover = true,
      completion = true,
      validate = true,
      schemas = require('schemastore').yaml.schemas()
    }
  }
}
vim.lsp.enable('yamlls')
