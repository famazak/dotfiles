-- Debugging and testing configuration

return {
  -- Debugging
  {
    'mfussenegger/nvim-dap',
    config = function()
      -- DAP keymaps
      vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd> DapToggleBreakpoint <CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>db', require('dap').continue, { desc = 'launch debugger' })

      -- Setup adapters
      local dap = require('dap')
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = {"--port", "${port}"},
        },
      }
    end
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-go').setup()
    end
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    dependencies = {
      'mfussenegger/nvim-dap',
      'microsoft/vscode-js-debug'
    },
    config = function()
      require("dap-vscode-js").setup({
        node_path = "node",
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })

      local dap = require('dap')
      for _, language in ipairs({ 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Vitest Tests",
            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
            args = { "--reporter=verbose", "--no-coverage" },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Current Vitest File",
            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
            args = { "run", "${relativeFile}", "--reporter=verbose", "--no-coverage" },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end
    end
  },
  {
    'microsoft/vscode-js-debug',
    lazy = true,
    build = function()
      os.execute("npm install --legacy-peer-deps")
      os.execute("npm run compile")
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      
      dapui.setup()
      
      -- Automatically open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  
  -- Testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      'fredrikaverpil/neotest-golang',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
      
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
          require("neotest-golang"),
        },
      })
      
      -- Testing keymaps
      vim.keymap.set('n', '<leader>rt', require('neotest').run.run, { desc = 'run nearest test' })
      vim.keymap.set('n', '<leader>rT', function() require('neotest').run.run(vim.fn.expand("%")) end, { desc = 'run entire test file' })
      vim.keymap.set('n', '<leader>dt', function() require('neotest').run.run({strategy = "dap"}) end, { desc = 'debug nearest test' })
    end
  },
}
