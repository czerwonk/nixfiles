require('git-worktree').setup()
local telescope = require('telescope')
telescope.load_extension("git_worktree")
vim.keymap.set('n', '<leader>sw', telescope.extensions.git_worktree.git_worktrees,
  { noremap = true, desc = 'Worktrees' }
)
vim.keymap.set('n', '<leader>sc', telescope.extensions.git_worktree.create_git_worktree,
  { noremap = true, desc = 'Create Worktree' }
)
