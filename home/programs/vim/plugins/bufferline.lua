require("bufferline").setup{
  options = {
    modified_icon = "●",
    left_trunc_marker = "",
    right_trunc_marker = "",
    show_close_icon = false,
    show_tab_indicators = true,
    tab_size = 20,
    truncate_names = true,
    max_name_length = 18,
    max_prefix_length = 15,
    indicator = {
      style = "icon",
      icon = " ",
    },
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, _, _)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {
      { filetype = "NvimTree", text = "EXPLORER", text_align = "center" }
    },
  },
}
