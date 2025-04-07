-- based on https://github.com/neovim/neovim/discussions/33335

local get_mark_char = function(i)
  return string.char(64 + i) -- A=65, B=66, etc.
end

for i = 1, 9 do
  local mark_char = get_mark_char(i)
  vim.keymap.set("n", "<leader>" .. i, function()
    local mark_pos = vim.api.nvim_get_mark(mark_char, {})
    if mark_pos[1] == 0 then
      vim.cmd("normal! gg")
      vim.cmd("mark " .. mark_char)
      vim.cmd("normal! ``") -- Jump back to where we were
    else
      vim.cmd("normal! `" .. mark_char) -- Jump to the bookmark
      vim.cmd('normal! `"') -- Jump to the last cursor position before leaving
    end
  end, { desc = "Toggle mark " .. mark_char })
end

vim.keymap.set("n", "<leader>md", function()
  for i = 1, 9 do
    local mark_char = get_mark_char(i)
    local mark_pos = vim.api.nvim_get_mark(mark_char, {})
    -- Check if mark is in current buffer
    if mark_pos[1] ~= 0 and vim.api.nvim_get_current_buf() == mark_pos[3] then
      vim.cmd("delmarks " .. mark_char)
    end
  end
end, { desc = "Delete mark" })
