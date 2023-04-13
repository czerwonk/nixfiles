vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.keymap.set('n', '<leader>z', vim.cmd.UndotreeToggle, { desc = 'UndoTree' })
