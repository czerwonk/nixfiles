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
    devstral = function()
      return require('codecompanion.adapters').extend('devstral', {
        name = 'devstral',
        schema = {
          model = {
            default = 'devstral',
          },
        },
      })
    end,
    deepcoder = function()
      return require('codecompanion.adapters').extend('deepcoder', {
        name = 'deepcoder',
        schema = {
          model = {
            default = 'deepcoder',
          },
        },
      })
    end,
    gemma3 = function()
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
      slash_commands = {
        ['buffer'] = {
          opts = {
            provider = 'snacks',
          },
        },
        ['help'] = {
          opts = {
            provider = 'snacks',
          },
        },
        ['file'] = {
          opts = {
            provider = 'snacks',
          },
        },
        ['symbols'] = {
          opts = {
            provider = 'snacks',
          },
        },
      },
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
    },
    chat = {
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

local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
local group = vim.api.nvim_create_augroup('CodeCompanionFidgetHooks', { clear = true })
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = { 'CodeCompanionRequestStarted', 'CodeCompanionRequestStreaming', 'CodeCompanionRequestFinished' },
  group = group,
  callback = function(request)
    local msg = '[CodeCompanion] ' .. request.match:gsub('CodeCompanion', '')

    vim.notify(msg, 'info', {
      timeout = 1000,
      keep = function ()
        return not vim.endswith(request.match, 'Finished')
      end,
      id = 'code_companion_status',
      title = 'Code Companion Status',
      opts = function(notif)
        notif.icon = ''
        if vim.endswith(request.match, 'Started') then
          ---@diagnostic disable-next-line: undefined-field
          notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        elseif vim.endswith(request.match, 'Finished') then
          notif.icon = ' '
        end
      end,
    })
  end,
})

vim.keymap.set({ 'n', 'v' }, '<leader>aa', function()
  ---@diagnostic disable-next-line: undefined-global
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
