vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    if vim.opt.number == false then
      return
    end

    if vim.fn.mode() == "i" then
      vim.opt.relativenumber = false
    else
      vim.opt.relativenumber = true
    end
  end,
})
