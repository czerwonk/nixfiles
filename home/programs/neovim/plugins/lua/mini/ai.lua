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
