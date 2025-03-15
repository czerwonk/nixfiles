local borderStyle = 'rounded';
require('blink.cmp').setup {
  keymap = { preset = 'enter' },
  completion = {
    accept = {
      auto_brackets = {
        kind_resolution = {
          blocked_filetypes = { 'codecompanion' },
        },
      },
    },
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
    default = { 'lsp', 'path', 'buffer', 'avante_commands', 'avante_mentions', 'avante_files' },
    providers = {
      avante_commands = {
        name = 'avante_commands',
        module = 'blink.compat.source',
        score_offset = 90, -- show at a higher priority than lsp
        opts = {},
      },
      avante_files = {
        name = 'avante_files',
        module = 'blink.compat.source',
        score_offset = 100, -- show at a higher priority than lsp
        opts = {},
      },
      avante_mentions = {
        name = 'avante_mentions',
        module = 'blink.compat.source',
        score_offset = 1000, -- show at a higher priority than lsp
        opts = {},
      },
    },
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
