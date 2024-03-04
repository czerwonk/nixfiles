vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

require('copilot').setup {
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false,
  },
}
require("copilot_cmp").setup()
