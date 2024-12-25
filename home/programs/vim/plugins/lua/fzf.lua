local fzf = require('fzf-lua')

local config = require("fzf-lua.config")
config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

local actions = require("fzf-lua.actions")
fzf.setup {
  'fzf-native',
  fzf_opts = { ["--layout"] = "default" },
  files = {
    cwd_prompt = false,
    actions = {
      ["alt-h"] = { actions.toggle_hidden },
    }
  },
  grep = {
    actions = {
      ["alt-h"] = { actions.toggle_hidden },
    }
  },
  lsp = {
    symbols = {
      symbol_hl = function(s)
        return "TroubleIcon" .. s
      end,
      symbol_fmt = function(s)
        return s:lower() .. "\t"
      end,
      child_prefix = false
    }
  }
}
fzf.register_ui_select()

vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fc', fzf.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Files' })
vim.keymap.set('n', '<leader>fF', function () fzf.files({ root = false }) end, { desc = 'Files (cwd)' })
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fh', fzf.search_history, { desc = 'Search History' })
vim.keymap.set('n', '<leader>fj', fzf.jumps, { desc = 'Jumplist' })
vim.keymap.set('n', '<leader>fk', fzf.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fq', fzf.quickfix, { desc = 'Quickfix' })
vim.keymap.set('n', '<leader>fr', fzf.oldfiles, { desc = 'Files (recent)' })
vim.keymap.set('n', '<leader>fs', fzf.git_commits, { desc = 'Git Commits' })
