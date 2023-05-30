require('kanagawa').setup {
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
}
vim.cmd("colorscheme kanagawa")
