vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.colorcolumn = '120'

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.mouse = ''

vim.opt.encoding = 'UTF-8'
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert', 'preview'}
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.termguicolors = true

vim.g.mapleader = ' '

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- convenience key mappings
vim.keymap.set('n', 'Y', 'Y', { desc = 'Yank line' }) -- restore yank behavior of VIM
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' }) -- reposition after scrolling down
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' }) -- reposition after scrolling up
vim.keymap.set("n", "n", "nzzzv") -- reposition after junp to match
vim.keymap.set("n", "N", "Nzzzv") -- reposition after junp to match
vim.keymap.set("n", "Q", "<nop>") -- disable Q
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = 'Yank to Clipbaord' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Yank to Clipbaord' })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move up'})
vim.keymap.set("n", "<leader>cc", "<cmd>copen<CR>", { desc = 'Open quickfix list' })
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>", { desc = 'Next quickfix list item' })
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>", { desc = 'Previous quickfix list item' })
vim.keymap.set("n", "<leader>b", "<cmd>bnext<CR>", { desc = 'Switch to next buffer' })
vim.keymap.set("n", "<leader>w", function() require("mini.bufremove").delete(0, false) end, { desc = 'Close current buffer' })

-- icons & signs
local signs = {
  Error = " ", Warn = " ", Hint = " ", Info = " "
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon, texthl = hl, numhl = hl
  })
end

-- editorfile
require('editorconfig').properties.file_type = function(bufnr, val, _)
  vim.bo[bufnr].ft = val
end
