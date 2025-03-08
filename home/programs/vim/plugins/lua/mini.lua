require('mini.bracketed').setup {
  comment = { suffix = '', options = {} },
  file = { suffix = '', options = {} },
  undo = { suffix = '', options = {} },
  treesitter = { suffix = '', options = {} },
}

require('mini.surround').setup {
  mappings = {
    add = "sa",
    delete = "sd",
    replace = "sr",
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
    'lspinfo',
    'checkhealth',
    'help',
    'man',
    'git',
    'markdown',
    'text',
    'terminal',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

local mini_ai = require("mini.ai");
mini_ai.setup {
  n_lines = 500,
  custom_textobjects = {
    o = mini_ai.gen_spec.treesitter({ -- code block
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    f = mini_ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
    c = mini_ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
    d = { "%f[%d]%d+" }, -- digits
    e = { -- Word with case
      { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
      "^().*()$",
    },
    u = mini_ai.gen_spec.function_call(), -- u for "Usage"
    U = mini_ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
  },
}

require('mini.diff').setup {
  view = {
    style = 'sign',
    signs = { add = '▎', change = '▎', delete = '' },
  }
}

vim.keymap.set('n', '<leader>w', function() require('mini.bufremove').delete(0, false) end, { desc = 'Close current buffer' })
