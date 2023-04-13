vim.o.timeout = true
vim.o.timeoutlen = 500
local wk = require('which-key')
wk.setup {
  window = {
    border = "single",
    position = "bottom",
  },
}
local wkOpts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}
wk.register({
  f = {
    name = "Telescope",
  },
  m = {
    name = "Harpoon",
  },
  q = {
    name = "Session",
  },
  r = {
    name = "Refactoring",
  },
  s = {
    name = "Git"
  },
  x = {
    name = "Trouble",
  }
}, wkOpts)
