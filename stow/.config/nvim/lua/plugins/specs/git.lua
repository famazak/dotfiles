-- Git related plugins

return {
  -- Git commands
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Git UI
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>')
    end,
  },
  -- Git signs in gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = 'Reset git hunk' })
        vim.keymap.set('n', '<leader>gb', require('gitsigns').toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle CL blame' })
        vim.keymap.set('n', '<leader>gd', require('gitsigns').diffthis, { buffer = bufnr, desc = 'diffthis' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({'n', 'v'}, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
        vim.keymap.set({'n', 'v'}, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
      end,
    },
  },
}
