require('codecompanion').setup {
  adapters = {
    opts = {
      show_defaults = false,
    },
    copilot = function()
      return require('codecompanion.adapters').extend('copilot', {
        schema = {
          model = {
            default = 'gemini-2.5-pro',
          },
        },
      })
    end,
    ollama = function()
      return require('codecompanion.adapters').extend('ollama', {
        name = 'gemma3',
        schema = {
          model = {
            default = 'gemma3',
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = 'copilot',
    },
    inline = {
      adapter = 'copilot',
    },
    agent = {
      adapter = 'copilot',
    },
  },
  display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = 'Prompt ',
      provider = 'snacks',
      opts = {
        show_default_actions = true,
        show_default_prompt_library = true,
      },
    },
    chat = {
      show_header_separator = false,
      show_references = true,
      show_token_count = true,
      window = {
        position = 'right',
      },
    },
    diff = {
      enabled = true,
      provider = 'mini_diff',
    },
  },
  extensions = {
    mcphub = {
      callback = 'mcphub.extensions.codecompanion',
      opts = {
        make_vars = true,
        make_slash_commands = true,
        show_result_in_chat = true,
      },
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>aa', function ()
  load_mcphub()
  vim.cmd('CodeCompanionChat Toggle')
end, { desc = 'Chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionActions<CR>', { desc = 'Actions' })
vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<CR>', { desc = 'Add to CodeCompanion context' })

require('which-key').add {
  { '<leader>a', group = 'AI' },
}

vim.cmd([[
  abbrev cc CodeCompanion
]])
