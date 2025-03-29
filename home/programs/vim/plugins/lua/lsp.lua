local on_attach = function(client, bufnr)
  local map = function (mode, key, binding, desc)
    vim.keymap.set(mode, key, binding, { desc = desc, noremap = true, silent = true, buffer = bufnr })
  end
  map({'n', 'v'}, '<leader>,', vim.lsp.buf.code_action, 'Code Action (LSP)')
  map('n', '<leader>Wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder (LSP)')
  map('n', '<leader>Wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder (LSP)')
  map('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, 'Format (LSP)')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename (LSP)')

  map('n', 'gn', function () vim.diagnostic.goto_next() end, 'Next diagnostic')
  map('n', 'gp', function () vim.diagnostic.goto_prev() end, 'Previous diagnostic')

  map('n', '<leader>o', function() Snacks.picker.lsp_symbols() end, 'Symbols (LSP)')
  map('n', 'gd', function() Snacks.picker.lsp_definitions() end, 'Definitions (LSP)')
  map('n', 'gr', function() Snacks.picker.lsp_references() end, 'References (LSP)')
  map('n', 'gI', function() Snacks.picker.lsp_implementations() end, 'Implementations (LSP)')
  map('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, 'T[y]pe Definitions (LSP)')
  map('n', 'gx', function() Snacks.picker.diagnostics() end, 'Diagnostics (LSP)')

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true);
    map('n', '<leader>h', function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, 'Toggle inlay hints')
  end

  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
    map('n', '<leader>;', function() vim.lsp.codelens.run() end, 'Code Lens Action (LSP)')
  end

  require('which-key').add({
    { "<leader>W", buffer = bufnr, group = "Workspace" },
  });
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspAttach', {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, args.buf)
  end,
})

local lspconfig = require('lspconfig')
local lsputil = require('lspconfig/util')

lspconfig.pyright.setup {}

lspconfig.ts_ls.setup {
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
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}

lspconfig.nil_ls.setup {}

lspconfig.bashls.setup {}

lspconfig.marksman.setup {}

lspconfig.lua_ls.setup {
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
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = lsputil.root_pattern("go.mod"),
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  }
}

lspconfig.rust_analyzer.setup {}

lspconfig.terraformls.setup {}

lspconfig.ansiblels.setup {}

lspconfig.dockerls.setup {}

lspconfig.docker_compose_language_service.setup {}

lspconfig.omnisharp.setup {
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
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true }
    }
  }
}

lspconfig.helm_ls.setup {}

lspconfig.yamlls.setup {
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

lspconfig.jdtls.setup {}

lspconfig.phpactor.setup {}

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
