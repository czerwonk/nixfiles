local signs = {
  Error = " ", Warn = " ", Hint = " ", Info = " "
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon, texthl = hl, numhl = hl
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local wkOpts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}
local wk = require('which-key')
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.server_capabilities["documentSymbolProvider"] then
    require("nvim-navic").attach(client, bufnr)
  end

  local map = function (mode, key, binding, desc)
    vim.keymap.set(mode, key, binding, { desc = desc, noremap = true, silent = true, buffer = bufnr })
  end
  map('n', 'gi', vim.lsp.buf.implementation, 'Find Implementation (LSP)')
  map('n', 'gh', vim.lsp.buf.signature_help, 'Show Signature Help (LSP)')
  map('n', 'gr', vim.lsp.buf.references, 'Find References (LSP)')
  map('n', '<leader>gD', vim.lsp.buf.declaration, 'Find Declatation (LSP)')
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder (LSP)')
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder (LSP)')
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List Workspace Folders (LSP)')
  map('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, 'Format (LSP)')

  require("lspsaga").setup {
    ui = {
      code_action = ''
    },
    code_action = {
      sign = false
    }
  }
  map('n', 'gf', '<cmd>Lspsaga lsp_finder<CR>', 'Find (LSP)')
  map('n', '<leader>re', '<cmd>Lspsaga rename ++project<CR>', 'Rename (LSP)')
  map({'n','v'}, '<leader>,', '<cmd>Lspsaga code_action<CR>', 'Code Action (LSP)')
  map('n', '<leader>gd', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition (LSP)')
  map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', 'Find Definition (LSP)')
  map('n', '<leader>gt', '<cmd>Lspsaga peek_type_definition<CR>', 'Peek Type Definition (LSP)')
  map('n', 'gt', '<cmd>Lspsaga goto_type_definition<CR>', 'Find Type Definition (LSP)')
  map('n', '<leader>o', '<cmd>Lspsaga outline<CR>', 'Outline (LSP)')
  map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', 'Hover Doc (LSP)')

  map('n', "<leader>xR", "<cmd>TroubleToggle lsp_references<CR>", 'Toggle (LSP References)')

  local telescopeBuiltin = require('telescope.builtin')
  map('n', '<leader>fi', telescopeBuiltin.lsp_implementations, 'Implementations (LSP)')
  map('n', '<leader>fd', telescopeBuiltin.lsp_definitions, 'Definitions (LSP)')
  map('n', '<leader>fr', telescopeBuiltin.lsp_references, 'References (LSP)')
  map('n', '<leader>p', telescopeBuiltin.lsp_document_symbols, 'Symbols in document (LSP)')
  map('n', '<leader>P', telescopeBuiltin.lsp_workspace_symbols, 'Symbols in workspace (LSP)')

  wk.register({
    g = {
      name = "LSP (goto)",
    }
  }, wkOpts);

  require ('lsp_signature').on_attach({
    bind = true,
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)
end

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.rnix.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.bashls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig.tflint.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require'lspconfig'.ansiblels.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- dap
local dap = require('dap')

local function on_attach_with_debug(client, bufnr)
  on_attach(client, bufnr)

  vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Continue (Debug)' })
  vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Step over (Debug)' })
  vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Step into (Debug)' })
  vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Step out (Debug)' })
  vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint (Debug)' })
  vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Breakpoint with message (Debug)' })
  vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { desc = 'Open REPL (Debug)' })
  vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Run Last (Debug)' })
  vim.keymap.set({'n', 'v'}, '<leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = 'Widgets (hover)' })
  vim.keymap.set({'n', 'v'}, '<leader>dp', function()
    require('dap.ui.widgets').preview()
  end, { desc = 'Widgets (preview)' })
  vim.keymap.set('n', '<leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end, { desc = 'Frames' })
  vim.keymap.set('n', '<leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, { desc = 'Scopes' })
  vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
  vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

  wk.register({
    d = {
      name = "Debug",
    }
  }, wkOpts);
end

local dapui = require('dapui')
dapui.setup() dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

-- go
require('go').setup({
  max_line_len = 180,
  lsp_cfg = {
    capabilities = capabilities,
    on_attach = function (client, bufnr)
      on_attach_with_debug(client, bufnr)
      vim.keymap.set('n', '<leader>;', "<cmd>GoCodeLenAct<CR>",
        { desc = 'Code Lens Action (Go)', noremap = true, silent = true, buffer = bufnr }
      )
    end,
  },
  lsp_gofumpt = true,
  dap_debug = true,
  dap_debug_gui = true,
})
local go_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = go_sync_grp,
})

-- rust
local rt = require("rust-tools")
rt.setup {
  server = {
    capabilities = capabilities,
    on_attach = on_attach_with_debug,
  }
}
