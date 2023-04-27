require('kanagawa').setup {
  transparent = true,
  theme = 'wave',
  colors = {
    palette = {
      sumiInk1 = "#1E1E1E",
      sumiInk4 = "#222222",
      springViolet1 = "#658594",
      oniViolet = "#FF9E3B",
      crystalBlue = "#569CD6",
    },
  },
}
vim.cmd("colorscheme kanagawa")
