return {
  'robitx/gp.nvim',
  enabled = false,
  keys = {
    -- Chat commands
    { mode = { 'n', 'i', '' }, '<Leader>cc', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat' },
    { mode = 'v', '<Leader>cc', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = 'Visual Chat New vsplit' },
    { mode = { 'n', 'i' }, '<Leader>ct', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
    { mode = { 'n', 'i' }, '<Leader>cf', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },

    { mode = 'v', '<Leader>cp', ":<C-u>'<,'>GpChatPaste<cr>", desc = 'Visual Chat Paste' },
    { mode = 'v', '<Leader>ct', ":<C-u>'<,'>GpChatToggle<cr>", desc = 'Visual Toggle Chat' },

    -- Prompt commands
    { mode = { 'n', 'i' }, '<Leader>cr', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
    { mode = { 'n', 'i' }, '<Leader>ca', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
    { mode = { 'n', 'i' }, '<Leader>cb', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },

    { mode = 'v', '<Leader>cr', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Visual Rewrite' },
    { mode = 'v', '<Leader>ca', ":<C-u>'<,'>GpAppend<cr>", desc = 'Visual Append (after)' },
    { mode = 'v', '<Leader>cb', ":<C-u>'<,'>GpPrepend<cr>", desc = 'Visual Prepend (before)' },
    { mode = 'v', '<Leader>ci', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },

    { mode = { 'n', 'i' }, '<Leader>cgp', '<cmd>GpPopup<cr>', desc = 'Popup' },
    { mode = { 'n', 'i' }, '<Leader>cge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
    { mode = { 'n', 'i' }, '<Leader>cgn', '<cmd>GpNew<cr>', desc = 'GpNew' },
    { mode = { 'n', 'i' }, '<Leader>cgv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
    { mode = { 'n', 'i' }, '<Leader>cgt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },

    { mode = 'v', '<Leader>cgp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Visual Popup' },
    { mode = 'v', '<Leader>cge', ":<C-u>'<,'>GpEnew<cr>", desc = 'Visual GpEnew' },
    { mode = 'v', '<Leader>cgn', ":<C-u>'<,'>GpNew<cr>", desc = 'Visual GpNew' },
    { mode = 'v', '<Leader>cgv', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },

    { mode = { 'n', 'i' }, '<Leader>cx', '<cmd>GpContext<cr>', desc = 'Toggle Context' },
    { mode = 'v', '<Leader>cx', ":<C-u>'<,'>GpContext<cr>", desc = 'Visual Toggle Context' },

    { mode = { 'n', 'i', 'v', 'x' }, '<Leader>cs', '<cmd>GpStop<cr>', desc = 'Stop' },
    { mode = { 'n', 'i', 'v', 'x' }, '<Leader>cn', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
  },
  config = function()
    require('gp').setup {
      openai_api_endpoint = 'https://api.groq.com/openai/v1/chat/completions',
      openai_api_key = 'op read op://private/GroqAI/credential --no-newline',

      agents = {
        {
          name = 'Llama370',
          chat = true,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = 'llama3-70b-8192', temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = 'You are an AI working as a code editor.\n\n'
            .. 'Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n'
            .. 'START AND END YOUR ANSWER WITH:\n\n```',
        },
        {
          name = 'Llama3',
          chat = true,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = 'llama3-8b-8192', temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = 'You are an AI working as a code editor.\n\n'
            .. 'Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n'
            .. 'START AND END YOUR ANSWER WITH:\n\n```',
        },
      },

      chat_topic_gen_model = 'llama3-8b-8192',
      chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<CR>' },
      chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-c>' },
      chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Leader>s' },
      chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Leader>n' },
    }

    -- or setup with your own config (see Install > Configuration in Readme)
    -- require("gp").setup(config)
    --
    local function keymapOptions(desc)
      return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = 'GPT prompt ' .. desc,
      }
    end
  end,
}
