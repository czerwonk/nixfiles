local fzf = require('fzf-lua')

vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Files' })
vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fF', fzf.git_files, { desc = 'Git Files' })
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fc', fzf.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fh', fzf.search_history, { desc = 'Search History' })
vim.keymap.set('n', '<leader>fq', fzf.quickfix, { desc = 'Quickfix' })
vim.keymap.set('n', '<leader>fj', fzf.jumps, { desc = 'Jumplist' })
vim.keymap.set('n', '<leader>fs', fzf.git_commits, { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>fk', fzf.keymaps, { desc = 'Keymaps' })
