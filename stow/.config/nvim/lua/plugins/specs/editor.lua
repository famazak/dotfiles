-- Editor enhancement plugins

return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Autoclose brackets and quotes
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require("autoclose").setup()
    end,
  },

  -- Surround selections with brackets, quotes, etc.
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 50,
        },
        git = {
          ignore = true,
        },
        filters = {
          git_ignored = false,
        },
      })
      vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>", {silent = true})
    end,
  },

  -- Quick file navigation
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    keys = {
      {
        "<leader>hc",
        function()
          require("harpoon.mark").clear_all()
        end,
        desc = "Clear all marks",
        id = "clear_marks"
      },
      {
        "<leader>1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        id = "nav_1"
      },
      {
        "<leader>2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        id = "nav_2"
      },
      {
        "<leader>3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        id = "nav_3"
      },
      {
        "<leader>4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        id = "nav_4"
      },
      {
        "<leader>5",
        function()
          require("harpoon.ui").nav_file(5)
        end,
        id = "nav_5"
      },
    },
  },

  -- Code commenting
  { 'numToStr/Comment.nvim', opts = {} },

  -- Show indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      indent = {
        char = "┊"
      },
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },

  -- Display keybindings
  { 'folke/which-key.nvim', opts = {} },
}
