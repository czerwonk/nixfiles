require('telescope').load_extension('project')

local project_actions = require("telescope._extensions.project.actions")
vim.keymap.set('n', '<leader>fp', function ()
  require('telescope').extensions.project.project {
    base_dirs = {
      "~/go",
      "~/.nixfiles"
    },
    display_type = 'full',
    hidden_files = true,
    sorting_strategy = 'ascending',
    sync_with_nvim_tree = true,
    on_project_selected = function(prompt_bufnr)
      project_actions.change_working_directory(prompt_bufnr, false)
      require("harpoon.ui").nav_file(1)
    end
  }
end, { desc = 'Projects' })
