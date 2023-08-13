local projectTelescope = require('telescope._extensions.project.actions')
local troubleTelescope = require('trouble.providers.telescope')

local on_project_selected = function(buf)
  projectTelescope.change_working_directory(buf, false)
  vim.cmd([[Neotree show dir=./]])
  require('harpoon.ui').nav_file(1)
  require('harpoon.tmux').sendCommand("2", " cd " .. vim.fn.getcwd())
end

local telescope = require('telescope')
telescope.setup {
  defaults = {
    mappings = {
      i = { ["<C-t>"] = troubleTelescope.open_with_trouble },
      n = { ["<C-t>"] = troubleTelescope.open_with_trouble },
    },
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
  },
  extensions = {
    project = {
      hidden_files = true,
      sorting_strategy = 'ascending',
      on_project_selected = on_project_selected,
      theme = "dropdown",
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
