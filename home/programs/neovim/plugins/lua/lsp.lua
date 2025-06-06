local on_attach = function(client, bufnr)
  local map = function (mode, key, binding, desc)
    vim.keymap.set(mode, key, binding, { desc = desc, noremap = true, silent = true, buffer = bufnr })
  end
  map({'n', 'v'}, '<leader>,', vim.lsp.buf.code_action, 'Code Action (LSP)')
  map('n', '<leader>Wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder (LSP)')
  map('n', '<leader>Wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder (LSP)')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename (LSP)')

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
