vim.o.timeout = true
vim.o.timeoutlen = 500
local wk = require('which-key')
wk.setup {
  window = {
    border = "single",
    position = "bottom",
  },
}
wk.register({
  c = {
    name = "Coverage"
  },
  d = {
    name = "Debug"
  },
  f = {
    name = "Telescope",
  },
  m = {
    name = "Harpoon",
  },
  r = {
    name = "Refactoring",
  },
  h = {
    name = "HTTP",
  },
  s = {
    name = "Git"
  },
  t = {
    name = "Test"
  },
  tc = {
    name = "Coverage"
  },
  q = {
    name = "Quickfix",
  },
  x = {
    name = "Trouble",
  }
}, { prefix = "<leader>" })
