vim.lsp.config['luals'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luacheckrc', '.stylua.toml', 'stylua.toml' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        globals = {'vim'}
      },
      telemetry = {
        enable = false
      },
      codeLens = {
        enable = false
      },
      hint = {
        enable = true
      }
    }
  }
}
vim.lsp.enable('luals')
