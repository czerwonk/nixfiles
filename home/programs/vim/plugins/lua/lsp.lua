local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
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

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true);
    map('n', '<leader>gh', function ()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, 'Toggle inlay hints')
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
    require("nvim-navbuddy").attach(client, bufnr)

    map('n', '<leader>p', '<cmd>Navbuddy<CR>', 'Navbuddy (LSP)')
  end

  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
    map('n', '<leader>;', function()
      vim.lsp.codelens.run()
    end, 'Code Lens Action (LSP)')
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
        enable = false
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
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "OmniSharp" },
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
    ["textDocument/references"] = require('omnisharp_extended').references_handler,
    ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
  },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = false,
  organize_imports_on_format = true,
  enable_import_completion = true,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
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

lspconfig.helm_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
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

lspconfig.jdtls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'} , {
  pattern = '*/templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml',
  callback = function()
    vim.opt_local.filetype = 'helm'
  end
})
