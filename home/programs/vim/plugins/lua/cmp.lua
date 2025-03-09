local borderStyle = 'rounded';
require('blink.cmp').setup {
  keymap = { preset = 'enter' },
  completion = {
    list = {
      selection = {
        preselect = function(ctx)
          return ctx.mode ~= 'cmdline'
        end,
        auto_insert = function(ctx)
          return ctx.mode == 'cmdline'
        end
      }
    },
    menu = {
      border = borderStyle,
      draw = {
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          }
        }
      }
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
