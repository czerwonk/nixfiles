local kind_icons = {
  Array         = " ",
  Boolean       = "󰨙 ",
  Class         = " ",
  Codeium       = "󰘦 ",
  Color         = " ",
  Control       = " ",
  Collapsed     = " ",
  Constant      = "󰏿 ",
  Constructor   = " ",
  Copilot       = " ",
  Enum          = " ",
  EnumMember    = " ",
  Event         = " ",
  Field         = " ",
  File          = " ",
  Folder        = " ",
  Function      = "󰊕 ",
  Interface     = " ",
  Key           = " ",
  Keyword       = " ",
  Method        = "󰊕 ",
  Module        = " ",
  Namespace     = "󰦮 ",
  Null          = " ",
  Number        = "󰎠 ",
  Object        = " ",
  Operator      = " ",
  Package       = " ",
  Property      = " ",
  Reference     = " ",
  Snippet       = "󱄽 ",
  String        = " ",
  Struct        = "󰆼 ",
  Supermaven    = " ",
  TabNine       = "󰏚 ",
  Text          = " ",
  TypeParameter = " ",
  Unit          = " ",
  Value         = " ",
  Variable      = "󰀫 ",
}

local borderStyle = 'rounded';
require('blink.cmp').setup {
  keymap = { preset = 'enter' },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
    kind_icons = kind_icons
  },
  completion = {
    menu = {
      border = borderStyle
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = borderStyle
      },
    },
  },
  sources = {
    cmdline = {}, -- disable cmdline completion
    default = { 'lsp', 'buffer', 'path', 'snippets' },
  },
  fuzzy = {
    prebuilt_binaries = {
      download = false
    },
  },
  signature = {
    enabled = true,
    window = {
      border = borderStyle
    },
  },
}
