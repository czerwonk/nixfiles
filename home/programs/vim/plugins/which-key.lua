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
    name = "Quickfix",
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
  n = {
    name = "Notes",
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
  x = {
    name = "Trouble",
  }
}, { prefix = "<leader>" })
