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
          require("rustaceanvim.neotest"),
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
