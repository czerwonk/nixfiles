require("harpoon").setup {
  global_settings = {
    save_on_toggle = true,
  },
}
require("telescope").load_extension('harpoon')

local harpoonMark = require('harpoon.mark')
local harpoonUI = require('harpoon.ui')
vim.keymap.set("n", "<leader>ma", harpoonMark.add_file, { desc = 'Add File' })
vim.keymap.set("n", "<leader>mm", harpoonUI.toggle_quick_menu, { desc = 'Toggle' })
vim.keymap.set("n", "<leader>mn", harpoonUI.nav_next, { desc = 'Next File' })
vim.keymap.set("n", "<leader>mp", harpoonUI.nav_prev, { desc = 'Previous File' })
vim.keymap.set("n", "<leader>m1", function() harpoonUI.nav_file(1) end, { desc = 'File 1' })
vim.keymap.set("n", "<leader>m2", function() harpoonUI.nav_file(2) end, { desc = 'File 2' })
vim.keymap.set("n", "<leader>m3", function() harpoonUI.nav_file(3) end, { desc = 'File 3' })
vim.keymap.set("n", "<leader>m4", function() harpoonUI.nav_file(4) end, { desc = 'File 4' })
