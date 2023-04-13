local refactoring = require('refactoring')
refactoring.setup()
local telescope = require('telescope')
telescope.load_extension('refactoring')
vim.keymap.set('v', '<leader>rr', telescope.extensions.refactoring.refactors,
  { noremap = true, desc = 'Refactoring' }
)
vim.keymap.set('n', '<leader>rp', function() refactoring.debug.printf({below = false}) end,
	{ noremap = true, desc = 'Printf Debug' }
)
vim.keymap.set('n', '<leader>rv', function() refactoring.debug.print_var({ normal = true }) end,
  { noremap = true, desc = 'Print Variable' }
)
vim.keymap.set('v', '<leader>rv', refactoring.debug.print_var,
  { noremap = true, desc = 'Print Variable' }
)
vim.keymap.set('n', '<leader>rc', refactoring.debug.cleanup,
 { noremap = true, desc = 'Cleanup' }
)
