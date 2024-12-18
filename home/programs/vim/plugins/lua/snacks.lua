local notify = vim.notify

local highlight = {
    "CursorColumn",
    "Whitespace",
}
require("snacks").setup {
  indent = {
    enabled = true,
    hl = highlight,
    scope = {
      enabled = false
    }
  }
}
vim.notify = notify
