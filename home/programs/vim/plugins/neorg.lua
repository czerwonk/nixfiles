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
    },
    ["core.integrations.telescope"] = {}
  }
}

vim.keymap.set('n', '<Leader>ni', [[:Neorg index<CR>]], { desc = 'Open notes index' })
vim.keymap.set('n', '<Leader>nt', [[:Neorg toc<CR>]], { desc = 'Open table of contents' })
vim.keymap.set('n', '<Leader>n[', [[:Neorg journal yesterday<CR>]], { desc = 'Open journal for yesterday' })
vim.keymap.set('n', '<Leader>nn', [[:Neorg journal today<CR>]], { desc = 'Open journal for today' })
vim.keymap.set('n', '<Leader>n]', [[:Neorg journal tomorrow<CR>]], { desc = 'Open journal for tomorrow' })

local neorg_callbacks = require("neorg.core.callbacks")
neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  -- Map all the below keybinds only when the "norg" mode is active
  keybinds.map_event_to_mode("norg", {
    n = {   -- Bind keys in normal mode
      { "<C-s>", "core.integrations.telescope.find_linkable" },
    },
    i = {   -- Bind in insert mode
      { "<C-l>", "core.integrations.telescope.insert_link" },
    },
  }, {
    silent = true,
    noremap = true,
  })
end)
