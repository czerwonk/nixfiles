require('mini.bracketed').setup {
  undo = { suffix = '', options = {} },
}

require('mini.surround').setup {
  mappings = {
    add = "gsa",
    delete = "gsd",
    replace = "gsr",
  },
  silent = true
}

require("mini.pairs").setup()

require('mini.bufremove').setup {
  silent = true
}

local mini_indentscope = require("mini.indentscope")
mini_indentscope.setup {
  draw = {
    animation = mini_indentscope.gen_animation.none()
  },
  mappings = {
    goto_top = 'gh',
    goto_bottom = 'gl',
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
