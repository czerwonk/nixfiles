vim.o.timeout = true
vim.o.timeoutlen = 500
local wk = require('which-key')
wk.setup {
  window = {
    border = "single",
    position = "bottom",
  },
}
wk.add({
  { "<leader>a", group = "AI" },
  { "<leader>c", group = "Coverage" },
  { "<leader>d", group = "Debug" },
  { "<leader>f", group = "Telescope" },
  { "<leader>h", group = "HTTP" },
  { "<leader>m", group = "Harpoon" },
  { "<leader>q", group = "Quickfix" },
  { "<leader>r", group = "Refactoring" },
  { "<leader>s", group = "Git" },
  { "<leader>t", group = "Test" },
  { "<leader>tc", group = "Coverage" },
  { "<leader>x", group = "Trouble" },
})
