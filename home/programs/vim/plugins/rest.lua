require("rest-nvim").setup {
  skip_ssl_verification = true,
}
vim.keymap.set('n', '<leader>hr', "<Plug>RestNvim", { desc = 'Run request' })
vim.keymap.set('n', '<leader>hp', "<Plug>RestNvimPreview", { desc = 'Preview request' })
vim.keymap.set('n', '<leader>hR', "<Plug>RestNvimLast", { desc = 'Re-Run request' })

vim.filetype.add({ extension = { http = "http" } })
