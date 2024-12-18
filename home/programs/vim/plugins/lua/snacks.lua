local notify = vim.notify

local highlight = {
    'CursorColumn',
    'Whitespace',
}
require('snacks').setup {
  indent = {
    enabled = true,
    hl = highlight,
    scope = {
      enabled = false
    }
  },
}
vim.notify = notify

vim.keymap.set('n', '<c-t>', function() require('snacks').terminal() end, { desc = "Terminal (cwd)" })
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
