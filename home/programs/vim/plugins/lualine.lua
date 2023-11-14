require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'codedark',
    global = true,
  },
  sections = {
    lualine_w = {
      {
        require('noice').api.statusline.mode.get,
        cond = require('noice').api.statusline.mode.has,
        color = { fg = '#ff9e64' },
      }
    },
  },
  extensions = { 'fugitive', 'neo-tree', 'toggleterm' },
}
