local utils = require 'utils'
return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  config = function()
    require('mini.basics').setup()
    require('mini.statusline').setup()
    require('mini.move').setup()
    require('mini.indentscope').setup()

    require('mini.ai').setup({
      custom_textobjects = {
        t = false
      }
    })

    local win_config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end

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
          local will_rename = utils.get_nested_path(client,
            { 'server_capabilities', 'workspace', 'fileOperations', 'willRename' })
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
  end,
}
