return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  enabled = false,
  keys = {
    -- { '<leader>cg', '<cmd>ChatGPT<cr>', desc = 'Chat with current buffer', mode = { 'n', 'v' } },
    { '<leader>cc', '<cmd>ChatGPTEditWithInstructions<cr>', desc = 'Chat with current buffer', mode = { 'n', 'v' } },
    { '<leader>ct', '<cmd>ChatGPTRun add_tests<cr>', desc = 'Add tests', mode = { 'n', 'v' } },
    { '<leader>cr', '<cmd>ChatGPTRun<cr>', desc = 'Run actions', mode = { 'n', 'v' } },
  },
  config = function()
    require('chatgpt').setup {
      api_host_cmd = 'echo https://api.groq.com/openai',
      api_key_cmd = 'op read op://private/OpenAI/credential --no-newline',

      openai_params = {
        -- model = 'llama3-8b-8192',
        model = 'llama3-70b-8192',
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 3000,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        -- model = 'llama3-8b-8192',
        model = 'llama3-70b-8192',
        max_tokens = 3000,
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },

      yank_register = '+',

      edit_with_instructions = {
        diff = false,
        keymaps = {
          close = '<C-c>',
          accept = '<C-y>',
          toggle_diff = '<C-d>',
          toggle_settings = '<C-o>',
          cycle_windows = '<Tab>',
          use_output_as_input = '<C-i>',
        },
      },
      chat = {
        loading_text = 'Loading, please wait ...',
        question_sign = '?', -- ??
        answer_sign = '?', -- ??
        max_line_length = 120,
        sessions_window = {
          border = {
            style = 'rounded',
            text = {
              top = ' Sessions ',
            },
          },
          win_options = {
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
          },
        },
      },
      popup_layout = {
        default = 'center',
        center = {
          width = '80%',
          height = '80%',
        },
        right = {
          width = '30%',
          width_settings_open = '50%',
        },
      },
      popup_window = {
        border = {
          highlight = 'FloatBorder',
          style = 'rounded',
          text = {
            top = ' ChatGPT ',
          },
        },
        win_options = {
          wrap = true,
          linebreak = true,
          foldcolumn = '1',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
        },
        buf_options = {
          filetype = 'markdown',
        },
      },
      system_window = {
        border = {
          highlight = 'FloatBorder',
          style = 'rounded',
          text = {
            top = ' SYSTEM ',
          },
        },
        win_options = {
          wrap = true,
          linebreak = true,
          foldcolumn = '2',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
        },
      },
      popup_input = {
        prompt = ' ? ',
        border = {
          highlight = 'FloatBorder',
          style = 'rounded',
          text = {
            top_align = 'center',
            top = ' Prompt ',
          },
        },
        win_options = {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
        },
        submit = '<C-Enter>',
        submit_n = '<Enter>',
        max_visible_lines = 20,
      },
      settings_window = {
        border = {
          style = 'rounded',
          text = {
            top = ' Settings ',
          },
        },
        win_options = {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
        },
      },
      use_openai_functions_for_edits = false,
      actions_paths = {
        '~/.config/nvim/lua/plugins/chatgpt/actions.json',
      },
      show_quickfixes_cmd = 'Trouble quickfix',
      predefined_chat_gpt_prompts = 'https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv',
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
