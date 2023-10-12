vim.opt.list = true
vim.opt.listchars:append({
  trail = '⋅',
  tab = '⇢ ',
})
local highlight = {
    "CursorColumn",
    "Whitespace",
}
require('ibl').setup {
  indent = { highlight = highlight, char = "" },
  whitespace = {
      remove_blankline_trail = false,
  },
  scope = { enabled = false },
}

