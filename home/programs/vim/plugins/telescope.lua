local projectTelescope = require('telescope._extensions.project.actions')
local troubleTelescope = require('trouble.providers.telescope')

local telescope = require('telescope')
telescope.setup {
  defaults = {
    mappings = {
      i = { ["<C-t>"] = troubleTelescope.open_with_trouble },
      n = { ["<C-t>"] = troubleTelescope.open_with_trouble },
    },
  },
  extensions = {
    project = {
      hidden_files = true,
      sorting_strategy = 'ascending',
      on_project_selected = function(prompt_bufnr)
        projectTelescope.change_working_directory(prompt_bufnr, false)
        require('nvim-tree.api').tree.open()
        require('harpoon.ui').nav_file(1)
      end
    }
  }
}
telescope.load_extension('project')

local telescopeBuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescopeBuiltin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fF', telescopeBuiltin.git_files, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>fg', telescopeBuiltin.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fb', telescopeBuiltin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fc', telescopeBuiltin.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fh', telescopeBuiltin.search_history, { desc = 'Search History' })
vim.keymap.set('n', '<leader>fq', telescopeBuiltin.quickfix, { desc = 'Quickfix' })
vim.keymap.set('n', '<leader>fj', telescopeBuiltin.jumplist, { desc = 'Jumplist' })
vim.keymap.set('n', '<leader>fk', telescopeBuiltin.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fv', telescopeBuiltin.vim_options, { desc = 'Options' })
vim.keymap.set('n', '<leader>fs', telescopeBuiltin.git_commits, { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<CR>", { desc = 'TODOs' })
vim.keymap.set('n', '<leader>fp', function ()
  telescope.extensions.project.project {
    display_type = 'full',
  }
end, { desc = 'Projects' })
