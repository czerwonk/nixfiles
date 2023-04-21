require('nvim-tree').setup {
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  sort_by = "case_sensitive",
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  renderer = {
    root_folder_label = false,
    group_empty = true,
    symlink_destination = true,
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  ",
      },
    }
  },
  filesystem_watchers = {
    enable = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  actions = {
    open_file = {
      resize_window = true,
    },
    change_dir = {
      restrict_above_cwd = true,
    }
  },
}
vim.keymap.set('n', '<C-n>', [[:NvimTreeToggle<CR>]], { desc = 'Toggle Tree' })
vim.keymap.set('n', '<leader>n', [[:NvimTreeFocus<CR>]], { desc = 'Focus Tree' })

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd('VimEnter', {
  callback = open_nvim_tree
})
