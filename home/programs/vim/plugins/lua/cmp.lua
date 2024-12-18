local kind_icons = {
  Array = " ",
  Boolean = " ",
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Copilot = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = " ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local borderStyle = 'roundet';
require('blink.cmp').setup {
  keymap = { preset = 'enter' },
  appearance = {
    use_nvim_cmp_as_default = true,
    kind_icons = kind_icons
  },
  completion = {
    menu = {
      border = borderStyle
    },
    documentation = {
      auto_show = true,
      window = {
        border = borderStyle
      },
    },
    ghost_text = {
      enabled = true,
    },
  },
  sources = {
    cmdline = {},
    default = { 'lsp', 'buffer', 'path', 'snippets' },
    providers = {
      buffer = {
        min_keyword_length = 2,
      },
      path = {
        min_keyword_length = 1,
      },
    }
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
