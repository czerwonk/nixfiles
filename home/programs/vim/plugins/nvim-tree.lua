vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup {
  sync_root_with_cwd = true,
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  diagnostics = {
    enable = true,
  },
  actions = {
    change_dir = {
      restrict_above_cwd = true,
    }
  }
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
