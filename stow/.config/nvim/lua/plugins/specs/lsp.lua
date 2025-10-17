-- LSP configuration

return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true, version='~1'},
      { 'williamboman/mason-lspconfig.nvim', version = '~1' },

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
    config = function()
      -- Setup neovim lua configuration
      require('neodev').setup()

      -- LSP settings
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      -- Enable the following language servers
      local servers = {
        pyright = {
          pyright = {
            disableOrganizeImports = true, -- use ruff
          },
          python = {
            analysis = {
              autoImportCompletions = true,
              typeCheckingMode = "off",
              ignore = { '*' } -- use ruff
            },
          },
        },
        yamlls = {
          yaml = {
            schemaStore = {
              url = "https://www.schemastore.org/api/json/catalog.json",
              enable = true
            },
            hover = true,
            completion = true,
            customTags = {
              "!Sub",
              "!GetAtt",
              "!Ref"
            }
          }
        },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        gopls = {},
        clangd = {},
        ts_ls = {},
        eslint = {},
      }

      -- Setup signature helper
      require("lsp_signature").setup({})

      -- Setup rust-analyzer separately
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
        },
        -- LSP configuration
        server = {
          on_attach = on_attach,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              check = {
                command = "clippy",
              },
            },
          },
        },
        -- DAP configuration
        dap = {
        },
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
      for server_name, server_config in pairs(servers) do
        vim.lsp.config(server_name, {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = server_config,
          filetypes = (server_config or {}).filetypes,
        })
        vim.lsp.enable(server_name)
      end

      -- Setup ruff separately using vim.lsp.config
      vim.lsp.config('ruff', {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          args = {
            "--config=pyproject.toml"
          }
        }
      })
      vim.lsp.enable('ruff')

      -- Diagnostic keymaps
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    lazy = false,
  },
}
