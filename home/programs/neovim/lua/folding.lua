vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = 'v:lua.require("nvim-treesitter.fold").foldexpr()'
vim.opt.foldnestmax = 3
vim.opt.foldlevel = 99
