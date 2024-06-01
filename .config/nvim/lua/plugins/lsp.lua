return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  -- enabled = false,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    'folke/trouble.nvim',
    -- 'yioneko/nvim-vtsls',
    -- 'nvimdev/lspsaga.nvim',
    -- 'pmizio/typescript-tools.nvim',
  },
  config = function()
    local on_attach = function(client, bufnr)
      -- disable_formatting for typescript
      -- if client.name == 'tsserver' or client.name == 'vtsls' then
      --   client.resolved_capabilities.document_formatting = false
      --   client.resolved_capabilities.document_range_formatting = false
      -- end

      -- run eslint fix on save
      -- if client.name == 'eslint' then
      --   vim.api.nvim_create_autocmd('BufWritePre', {
      --     buffer = bufnr,
      --     command = 'EslintFixAll',
      --   })
      -- end

      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'lsp_document_highlight' }
        vim.api.nvim_create_autocmd('CursorHold', {
          callback = vim.lsp.buf.document_highlight,
          buffer = bufnr,
          group = 'lsp_document_highlight',
          desc = 'Document Highlight',
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
          callback = vim.lsp.buf.clear_references,
          buffer = bufnr,
          group = 'lsp_document_highlight',
          desc = 'Clear All the References',
        })
      end

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      vim.keymap.set({ 'n', 'v' }, '<leader>a', '<cmd>FzfLua lsp_code_actions<CR>')

      nmap('gd', function()
        require('fzf-lua').lsp_definitions {
          sync = true,
          jump_to_single_result = true,
        }
      end, '[G]oto [D]efinition')

      nmap('gr', function()
        require('fzf-lua').lsp_references { ignore_current_line = true, includeDeclaration = false }
      end, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

      vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Diagnostic keymaps
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })

      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>ww', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

      -- Create a command `:Format` local to the LSP buffer
      -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      --   vim.lsp.buf.format()
      -- end, { desc = 'Format current buffer with LSP' })
    end

    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- tsserver = {},

      emmet_language_server = {},
      tailwindcss = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { 'tv\\((([^()]*|\\([^()]*\\))*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
              { 'cva\\(([^)]*)\\)',                 '["\'`]([^"\'`]*).*?["\'`]' },
              { 'cx\\(([^)]*)\\)',                  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
        },
      },
      cssls = {},
      cssmodules_ls = {},
      vtsls = {
        enableMoveToFileCodeAction = true,
        format = { enable = false },
      },

      -- harper_ls = {},
      eslint = {
        enable = true,
        format = { enable = false }, -- this will enable formatting
        packageManager = 'npm',
        autoFixOnSave = true,
        settings = {
          autoFixOnSave = true,
        },
        codeActionsOnSave = {
          mode = 'all',
          rules = { '!debugger', '!no-only-tests/*' },
        },
        lintTask = {
          enable = true,
        },
      },

      biome = {},

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end,
    }
  end,
}
