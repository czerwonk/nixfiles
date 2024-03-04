require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'codedark',
    global = true,
  },
  extensions = { 'fugitive', 'neo-tree', 'toggleterm' },
}
