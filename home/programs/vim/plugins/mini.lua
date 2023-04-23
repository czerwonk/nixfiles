require('mini.surround').setup {
  mappings = {
    add = "sw",
    delete = "rs",
    replace = "cs",
  },
}

require("mini.pairs").setup()

local mini_indentscope = require("mini.indentscope")
mini_indentscope.setup {
  draw = {
    animation = mini_indentscope.gen_animation.none()
  },
  mappings = {
    goto_top = 'gk',
    goto_bottom = 'gj',
  },
  symbol = "│",
  options = {
    try_as_border = true,
  },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    'NvimTree',
    'Trouble',
    'lspinfo',
    'checkhealth',
    'help',
    'man',
    'git',
    'markdown',
    'text',
    'terminal',
    'TelescopePrompt',
    'TelescopeResults',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
