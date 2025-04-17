_G.foldexpr = function()
  local buf = vim.api.nvim_get_current_buf()

  if vim.b[buf].ts_folds == nil then
    -- as long as we don't have a filetype, don't bother
    -- checking if treesitter is available (it won't)
    if vim.bo[buf].filetype == "" then
      return "0"
    end

    vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
  end

  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.foldexpr()"
vim.opt.foldnestmax = 3
vim.opt.foldlevel = 99
vim.opt.foldminlines = 3
