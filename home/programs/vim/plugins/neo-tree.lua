require("neo-tree").setup({
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = false,
  open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = true,
    use_libuv_file_watcher = true,
  },
  indent = {
    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
    expander_collapsed = "",
    expander_expanded = "",
    expander_highlight = "NeoTreeExpander",
  },
  default_component_configs = {
    icon = {
      folder_empty = "󰜌",
      folder_empty_open = "󰜌",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        renamed  = "󰁕",
        unstaged = "󰄱",
      },
    },
  },
  document_symbols = {
    kinds = {
      File = { icon = "󰈙", hl = "Tag" },
      Namespace = { icon = "󰌗", hl = "Include" },
      Package = { icon = "󰏖", hl = "Label" },
      Class = { icon = "󰌗", hl = "Include" },
      Property = { icon = "󰆧", hl = "@property" },
      Enum = { icon = "󰒻", hl = "@number" },
      Function = { icon = "󰊕", hl = "Function" },
      String = { icon = "󰀬", hl = "String" },
      Number = { icon = "󰎠", hl = "Number" },
      Array = { icon = "󰅪", hl = "Type" },
      Object = { icon = "󰅩", hl = "Type" },
      Key = { icon = "󰌋", hl = "" },
      Struct = { icon = "󰌗", hl = "Type" },
      Operator = { icon = "󰆕", hl = "Operator" },
      TypeParameter = { icon = "󰊄", hl = "Type" },
      StaticMethod = { icon = '󰠄 ', hl = 'Function' },
    }
  },
  source_selector = {
    sources = {
      { source = "filesystem", display_name = " 󰉓 Files " },
      { source = "git_status", display_name = " 󰊢 Git " },
      { source = "buffers", display_name = "  Buffers " },
      { source = "document_symbols", display_name = " 󰅩 Document Symbols " },
    },
  },
})

vim.g.neo_tree_remove_legacy_commands = 1
vim.keymap.set('n', '<C-n>', [[:Neotree toggle<CR>]], { desc = 'Toggle Tree' })
vim.keymap.set('n', '<leader>n', [[:Neotree focus<CR>]], { desc = 'Focus Tree' })
