require('noice').setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = false,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      view = "mini",
    },
    {
      filter = {
        event = "msg_showmode",
        find = "record",
      },
      view = "mini",
    },
  },
})
require('telescope').load_extension('noice')
