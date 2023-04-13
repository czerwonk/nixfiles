vim.opt.updatetime = 200
require("barbecue").setup {
  attach_navic = false,
  create_autocmd = false,
}
vim.api.nvim_create_autocmd({
  "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",
  "BufWritePost",
  "TextChanged",
  "TextChangedI",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})
