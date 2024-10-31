require("gp").setup {
  providers = {
    openai = {
      disable = true
    },
    ollama = {
      disable = false
    }
  },
  default_command_agent = "CodeOllamaLlama3.1-8B",
	default_chat_agent = "ChatOllamaLlama3.1-8B",
  chat_confirm_delete = false
}

vim.keymap.set("n", "<leader>ai", "<cmd>GpAppend popup<cr>",
  {silent = true, noremap = true, desc = 'Insert'}
)
vim.keymap.set("n", "<leader>aa", "<cmd>GpChatToggle popup<cr>",
  {silent = true, noremap = true, desc = 'Toggle'}
)
vim.keymap.set("n", "<leader>af", "<cmd>GpChatFinder<cr>",
  {silent = true, noremap = true, desc = 'Search'}
)
vim.keymap.set("n", "<leader>ay", "<cmd>GpChatPaste popup<cr>",
  {silent = true, noremap = true, desc = 'Paste'}
)
vim.keymap.set("n", "<leader>ad", "<cmd>GpChatDelete<cr>",
  {silent = true, noremap = true, desc = 'Delete'}
)
