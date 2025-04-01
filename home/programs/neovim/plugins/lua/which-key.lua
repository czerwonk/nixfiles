vim.o.timeout = true
vim.o.timeoutlen = 500
local wk = require('which-key')
wk.setup {
  preset = "modern",
  spec = {
  { "<leader>c", group = "Coverage" },
  { "<leader>d", group = "Debug" },
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>h", group = "HTTP" },
  { "<leader>q", group = "Quickfix" },
  { "<leader>r", group = "Refactoring" },
  { "<leader>t", group = "Test" },
  { "<leader>x", group = "Diagnostics" },
  {
    "<leader>b",
      group = "buffer",
      expand = function()
        return require("which-key.extras").expand.buf()
      end,
    },
{
    "<leader>w",
      group = "windows",
      proxy = "<c-w>",
      expand = function()
        return require("which-key.extras").expand.win()
      end,
    },
  }
}
