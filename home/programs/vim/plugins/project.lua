local telescope = require('telescope')
telescope.load_extension('project')

local project_actions = require('telescope._extensions.project.actions')
telescope.setup {
  extensions = {
    project = {
      hidden_files = true,
      sorting_strategy = 'ascending',
      sync_with_nvim_tree = true,
      on_project_selected = function(prompt_bufnr)
        project_actions.change_working_directory(prompt_bufnr, false)
        require("harpoon.ui").nav_file(1)
      end
    }
  }
}

vim.keymap.set('n', '<leader>fp', function ()
  telescope.extensions.project.project {
    display_type = 'full',
  }
end, { desc = 'Projects' })
