vim.g.mcphub_initialized = false

local function load_mcphub()
  if vim.g.mcphub_initialized then
    return
  end

  require('mcphub').setup {
    cmd = 'mcp-hub',
    shutdown_delay = 30000,
  }
  vim.g.mcphub_initialized = true
end

vim.keymap.set('n', '<Leader>M', function()
  load_mcphub()
  vim.cmd('MCPHub')
end, { desc = 'MCPHub' })
