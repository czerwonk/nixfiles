require("avante").setup {
  provider = "copilot",
  auto_suggestions_provider = "copilot",
  copilot = {
    model = "claude-3.7-sonnet",
  },
  ollama = {
    model = "codellama:latest",
  },
  file_selector = {
    provider = 'snacks',
  },
  hints = {
    enabled = false,
  },
}

require('which-key').add({
  { "<leader>a", group = "AI" },
});
