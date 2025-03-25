local kanagawa = require('kanagawa')
kanagawa.setup {
  transparent = false,
  theme = 'wave',
  colors = {
    palette = {
      sumiInk1 = "#1E1E1E",
      sumiInk4 = "#222222",
      springViolet1 = "#658594",
      oniViolet = "#FF9E3B",
      crystalBlue = "#7FB4CA",
    },
  },
  overrides = function(colors)
    local theme = colors.theme

    return {
      LspInlayHint = { bg = theme.ui.bg, fg = theme.syn.comment },
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
    }
  end,
}

kanagawa.load('wave')
