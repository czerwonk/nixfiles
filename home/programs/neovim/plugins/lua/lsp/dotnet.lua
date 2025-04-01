vim.lsp.config['omnisharp'] = {
  cmd = { 'OmniSharp' },
  filetypes = { 'cs' },
  root_markers = { '.sln', '.csproj', 'omnisharp.json', 'function.json' },
  settings = {
    RoslynExtensionsOptions = {
      InlayHintsOptions = {
        EnableForParameters = true,
        ForLiteralParameters = true,
        ForIndexerParameters = true,
        ForObjectCreationParameters = true,
        ForOtherParameters = true,
        SuppressForParametersThatDifferOnlyBySuffix = false,
        SuppressForParametersThatMatchMethodIntent = false,
        SuppressForParametersThatMatchArgumentName = false,
        EnableForTypes = true,
        ForImplicitVariableTypes = true,
        ForLambdaParameterTypes = true,
        ForImplicitObjectCreatio = true,
      }
    }
  }
}
vim.lsp.enable('omnisharp')
