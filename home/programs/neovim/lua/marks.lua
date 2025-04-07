for i = 1, 9 do
  local mark_char = string.char(64 + i) -- A=65, B=66, etc.

  vim.keymap.set("n", "<leader>" .. i, function()
    local mark_pos = vim.api.nvim_get_mark(mark_char, {})
    if mark_pos[1] == 0 then
      vim.cmd("mark " .. mark_char)
    else
      vim.cmd("normal! `" .. mark_char) -- Jump to the bookmark
    end
  end, { desc = "Toggle mark " .. mark_char })

  vim.keymap.set("n", "<leader>m" .. i, function()
    vim.cmd("delmarks " .. mark_char)
    vim.cmd("mark " .. mark_char)
  end, { desc = "Set mark " .. mark_char })

  vim.keymap.set("n", "<leader>md" .. i, function()
    vim.cmd("delmarks " .. mark_char)
  end, { desc = "Remove mark " .. mark_char })
end
