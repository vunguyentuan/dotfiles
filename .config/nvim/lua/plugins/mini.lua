local utils = require 'utils'
return {
  'echasnovski/mini.nvim',
  version = false,
  event = 'VeryLazy',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('mini.basics').setup {
      options = {
        extra_ui = false,
      },
      mappings = {
        windows = false,
      },
    }

    require('mini.statusline').setup {
      user_icons = true,
    }

    require('mini.move').setup()
    require('mini.indentscope').setup {
      draw = {
        animation = function(s, n)
          return 5
        end,
      },
      symbol = '│',
    }

    require('mini.sessions').setup {
      autowrite = true,
    }

    local minifiles = require 'mini.files'
    minifiles.setup {
      mappings = {
        go_in = 'L',
        go_in_plus = 'l',
        go_out = 'H',
        go_out_plus = 'h',
        show_help = '?',
        synchronize = '<cr>',
      },
      windows = {
        preview = false,
        width_preview = 80,
      },
    }
    vim.keymap.set('n', '<C-n>', function()
      if not minifiles.close() then
        minifiles.open(vim.api.nvim_buf_get_name(0))
      end
      -- minifiles.open(vim.api.nvim_buf_get_name(-1))
    end, { desc = 'Open files' })

    local function getWorkspaceEdit(client, old_name, new_name)
      local will_rename_params = {
        files = {
          {
            oldUri = vim.uri_from_fname(old_name),
            newUri = vim.uri_from_fname(new_name),
          },
        },
      }
      local timeout_ms = 2000
      local success, resp = pcall(client.request_sync, 'workspace/willRenameFiles', will_rename_params, timeout_ms)
      if not success then
        return nil
      end
      if resp == nil or resp.result == nil then
        return nil
      end
      return resp.result
    end

    -- auto update import statements using lsp
    vim.api.nvim_create_autocmd('User', {
      -- pattern = { 'MiniFilesActionMove', 'MiniFilesActionRename' },
      pattern = 'MiniFilesActionMove',
      callback = function(args)
        for _, client in pairs(vim.lsp.get_active_clients()) do
          local will_rename = utils.get_nested_path(client, { 'server_capabilities', 'workspace', 'fileOperations', 'willRename' })
          -- print(vim.inspect(will_rename))
          if will_rename ~= nil then
            local filters = will_rename.filters or {}
            if utils.matches_filters(filters, args.data.from) then
              local edit = getWorkspaceEdit(client, args.data.from, args.data.to)
              if edit ~= nil then
                vim.lsp.util.apply_workspace_edit(edit, client.offset_encoding)
              end
            end
          end
        end
      end,
    })

    require('mini.surround').setup {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = '<leader>sa', -- Add surrounding in Normal and Visual modes
        delete = '<leader>sd', -- Delete surrounding
        find = '<leader>sf', -- Find surrounding (to the right)
        find_left = '<leader>sF', -- Find surrounding (to the left)
        highlight = '<leader>sh', -- Highlight surrounding
        replace = '<leader>sr', -- Replace surrounding
        update_n_lines = '<leader>sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }

    local miniclue = require 'mini.clue'
    miniclue.setup {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },

        { mode = 'n', keys = ']' },
        { mode = 'x', keys = ']' },
        { mode = 'n', keys = '[' },
        { mode = 'x', keys = '[' },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
      window = {
        -- Floating window config
        config = {
          width = 'auto',
          -- Use double-line border
          -- border = 'double',
        },

        -- Delay before showing clue window
        delay = 200,

        -- Keys to scroll inside the clue window
        scroll_down = '<C-d>',
        scroll_up = '<C-u>',
      },
    }

    -- require('mini.completion').setup()

    -- text object
    require('mini.ai').setup()

    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }

    require('mini.comment').setup {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end,
        ignore_blank_line = true,
      },
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = 'gc',

        -- Toggle comment on current line
        comment_line = '<C-c>',
        comment_visual = '<C-c>',

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        textobject = 'gc',
      },
    }
  end,
}
