local trouble = require("trouble")
trouble.setup()
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>",
  {silent = true, noremap = true, desc = 'Toggle'}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>",
  {silent = true, noremap = true, desc = 'Toggle (Workspace)'}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>",
  {silent = true, noremap = true, desc = 'Toggle (Document)'}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>",
  {silent = true, noremap = true, desc = 'Toggle (Locations)'}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>",
  {silent = true, noremap = true, desc = 'Toggle (Quickfix)'}
)
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<CR>",
  {silent = true, noremap = true, desc = 'TODO'}
)
vim.keymap.set("n", "<leader>xn", function () trouble.next({skip_groups = true, jump = true}) end,
  {silent = true, noremap = true, desc = 'Next'}
)
vim.keymap.set("n", "<leader>xp", function () trouble.previous({skip_groups = true, jump = true}) end,
  {silent = true, noremap = true, desc = 'Previous'}
)
vim.keymap.set("n", "<leader>x0", function () trouble.first({skip_groups = true, jump = true}) end,
  {silent = true, noremap = true, desc = 'First'}
)
vim.keymap.set("n", "<leader>x$", function () trouble.last({skip_groups = true, jump = true}) end,
  {silent = true, noremap = true, desc = 'Last'}
)

local troubleTelescope = require("trouble.providers.telescope")
require('telescope').setup {
  defaults = {
    mappings = {
      i = { ["<C-t>"] = troubleTelescope.open_with_trouble },
      n = { ["<C-t>"] = troubleTelescope.open_with_trouble },
    },
  },
}
