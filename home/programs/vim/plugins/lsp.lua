local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local inlayhints = require('lsp-inlayhints')
inlayhints.setup()

local on_attach = function(client, bufnr)
  inlayhints.on_attach(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local map = function (mode, key, binding, desc)
    vim.keymap.set(mode, key, binding, { desc = desc, noremap = true, silent = true, buffer = bufnr })
  end
  map({'n', 'v'}, '<leader>,', vim.lsp.buf.code_action, 'Code Action (LSP)')
  map('n', '<leader>K', vim.lsp.buf.hover, 'Hover Documentation (LSP)')
  map('n', 'gd', vim.lsp.buf.definition, 'Find Definition (LSP)')
  map('n', 'gD', vim.lsp.buf.declaration, 'Find Declaration (LSP)')
  map('n', '<leader>Wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder (LSP)')
  map('n', '<leader>Wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder (LSP)')
  map('n', '<leader>Wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List Workspace Folders (LSP)')
  map('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, 'Format (LSP)')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename (LSP)')

  map('n', 'gn', function ()
    vim.diagnostic.goto_next()
  end, 'Next diagnostic')
  map('n', 'gp', function ()
    vim.diagnostic.goto_prev()
  end, 'Previous diagnostic')
  map('n', '<leader>xR', '<cmd>TroubleToggle lsp_references<CR>', 'Toggle (LSP References)')

  local telescopeBuiltin = require('telescope.builtin')
  map('n', '<leader>gi', telescopeBuiltin.lsp_implementations, 'Implementations (LSP)')
  map('n', '<leader>gd', telescopeBuiltin.lsp_definitions, 'Definitions (LSP)')
  map('n', '<leader>gt', telescopeBuiltin.lsp_type_definitions, 'Type Definitions (LSP)')
  map('n', '<leader>gr', telescopeBuiltin.lsp_references, 'References (LSP)')
  map('n', '<leader>gh', function ()
    require('lsp-inlayhints').toggle()
  end, 'Toggle inlay hints')

  if client.server_capabilities["documentSymbolProvider"] then
    require("nvim-navic").attach(client, bufnr)
    require("nvim-navbuddy").attach(client, bufnr)

    map('n', '<leader>p', '<cmd>Navbuddy<CR>', 'Navbuddy (LSP)')
  end

  if client.server_capabilities["codeLensProvider"] then
    vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
    map('n', '<leader>;', function() vim.lsp.codelens.run() end, 'Code Lens Action (LSP)')
  end

  require('which-key').register({
    g = {
      name = "LSP",
    },
    W = {
      name = "Workspace",
    }
  }, { prefix = "<leader>", buffer = bufnr });
end

local lspconfig = require('lspconfig')
local lsputil = require('lspconfig/util')
lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true
      }
    }
  }
}
lspconfig.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}
lspconfig.nil_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.bashls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.marksman.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
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
        enable = true
      },
      hint = {
        enable = true
      }
    }
  }
}
lspconfig.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = lsputil.root_pattern("go.mod"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true
      },
      staticcheck = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true
      },
      usePlaceholders = true
    }
  }
}
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.terraformls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.ansiblels.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.dockerls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.docker_compose_language_service.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.omnisharp.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true }
    }
  }
}
lspconfig.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemas = require('schemastore').yaml.schemas()
    }
  }
}

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
    vim.lsp.buf.format({ async = false })
  end
})
