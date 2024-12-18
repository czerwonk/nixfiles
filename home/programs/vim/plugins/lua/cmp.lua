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

require('blink.cmp').setup {
  keymap = { preset = 'enter' },
  appearance = {
    kind_icons = kind_icons,
  },
  completion = {
    documentation = {
      auto_show = true,
    },
    ghost_text = {
      enabled = true,
    },
  },
  sources = {
    cmdline = {},
    default = { 'lsp', 'buffer', 'path', 'snippets' },
  },
  fuzzy = {
    prebuilt_binaries = {
      download = false
    },
  },
}
