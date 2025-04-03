vim.keymap.set('n', 'Y', 'yy', { desc = 'Yank line' })
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]], { desc = 'Yank to clipbaord' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to clipbaord' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' }) -- reposition after scrolling down
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' }) -- reposition after scrolling up
vim.keymap.set('n', 'n', 'nzzzv') -- reposition after junp to match
vim.keymap.set('n', 'N', 'Nzzzv') -- reposition after junp to match

vim.keymap.set('n', 'Q', '@qj', { desc = 'Apply Macro' })
vim.keymap.set('x', 'Q', ':norm @q<CR>', { desc = 'Apply Macro' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move up'})
vim.keymap.set('n', '<c-b>', '<cmd>bnext<CR>', { desc = 'Switch to next buffer' })

vim.keymap.set("n", "<leader>co", ":diffget LOCAL<CR>", { desc = "Get OUR changes" })
vim.keymap.set("n", "<leader>ct", ":diffget REMOTE<CR>", { desc = "Get THEIR changes" })
vim.keymap.set("n", "<leader>cb", ":diffget BASE<CR>", { desc = "Get BASE changes" })
