require('telescope').load_extension('project')
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
  }
end, { desc = 'Projects' })
