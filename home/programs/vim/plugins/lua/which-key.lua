vim.o.timeout = true
vim.o.timeoutlen = 500
local wk = require('which-key')
wk.setup {
  preset = "modern",
  spec = {
  { "<leader>a", group = "AI" },
  { "<leader>c", group = "Coverage" },
  { "<leader>d", group = "Debug" },
  { "<leader>f", group = "Telescope" },
  { "<leader>h", group = "HTTP" },
  { "<leader>q", group = "Quickfix" },
  { "<leader>r", group = "Refactoring" },
  { "<leader>s", group = "Git" },
  { "<leader>t", group = "Test" },
  { "<leader>tc", group = "Coverage" },
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
