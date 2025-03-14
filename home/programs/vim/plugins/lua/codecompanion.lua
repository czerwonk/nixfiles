require('codecompanion').setup {
  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "claude-3.7-sonnet",
          },
        },
      })
    end,
    ollama = "ollama",
    codellama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "codellama",
        schema = {
          model = {
            default = "codellama:latest",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    opts = {
      show_defaults = false,
    },
  },
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
  },
}

vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true,desc = 'CodeCompanion Actions' })
vim.keymap.set({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = 'CodeCompanion Chat (Toggle)' })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true, desc = 'Add visually selection to chat buffer' })

vim.cmd([[cab cc CodeCompanion]])
vim.cmd([[cab ccc CodeCompanionChat]])
vim.cmd([[cab cca CodeCompanionActions]])
