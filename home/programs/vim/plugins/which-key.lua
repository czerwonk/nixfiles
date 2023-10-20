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
  s = {
    name = "Git"
  },
  t = {
    name = "Test"
  },
  x = {
    name = "Trouble",
  }
}, { prefix = "<leader>" })
