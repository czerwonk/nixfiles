vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    local winnr = vim.api.nvim_get_current_win()

    if not vim.wo[winnr].number then
      return
    end

    if vim.fn.mode() == "i" then
      vim.wo[winnr].relativenumber = false
    else
      vim.wo[winnr].relativenumber = true
    end
  end,
})
