require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        default_workspace = "work",
        workspaces = {
          private = "~/notes/private",
          work = "~/notes/work"
        }
      }
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp"
      }
    }
  }
}

vim.keymap.set('n', '<Leader>ni', [[:Neorg index<CR>]], { desc = 'Open notes index' })
vim.keymap.set('n', '<Leader>nt', [[:Neorg toc<CR>]], { desc = 'Open table of contents' })
vim.keymap.set('n', '<Leader>n[', [[:Neorg journal yesterday<CR>]], { desc = 'Open journal for yesterday' })
vim.keymap.set('n', '<Leader>nn', [[:Neorg journal today<CR>]], { desc = 'Open journal for today' })
vim.keymap.set('n', '<Leader>n]', [[:Neorg journal tomorrow<CR>]], { desc = 'Open journal for tomorrow' })
