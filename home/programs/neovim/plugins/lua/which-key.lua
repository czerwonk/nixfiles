vim.o.timeout = true
vim.o.timeoutlen = 500
local wk = require('which-key')
wk.setup {
  preset = "modern",
  spec = {
    { "<leader>c", group = "Diff" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>m", group = "Marks" },
    { "<leader>q", group = "Quickfix" },
    { "<leader>r", group = "Refactoring" },
    { "<leader>t", group = "Test" },
    { "<leader>x", group = "Diagnostics" },
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
