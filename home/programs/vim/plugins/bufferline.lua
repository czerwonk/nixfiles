require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
    separator_style = "padded_slant",
    indicator = {
      style = "icon",
      icon = " ",
    },
    modified_icon = "●",
    left_trunc_marker = "",
    right_trunc_marker = "",
    show_close_icon = false,
    show_tab_indicators = true,
    tab_size = 20,
    truncate_names = true,
    max_name_length = 18,
    max_prefix_length = 15,
    offsets = {
      { filetype = "NvimTree", text = "EXPLORER", text_align = "center" }
    },
  },
  highlights = {
    fill = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLineNC" },
    },
    background = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLine" },
    },
    buffer_visible = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
    },
    buffer_selected = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
    },
    separator = {
        fg = { attribute = "bg", highlight = "StatusLineNC" },
        bg = { attribute = "bg", highlight = "StatusLine" },
    },
    separator_selected = {
        fg = { attribute = "bg", highlight = "StatusLineNC" },
        bg = { attribute = "bg", highlight = "Normal" },
    },
    separator_visible = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLineNC" },
    },
    close_button = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLine" },
    },
    close_button_selected = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
    },
    close_button_visible = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
    },
  },
}
