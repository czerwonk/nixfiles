require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'codedark',
    global = true,
  },
  tabline = {
    lualine_a = {'buffers'},
  },
  extensions = { 'fugitive', 'nvim-tree', 'toggleterm' },
}
