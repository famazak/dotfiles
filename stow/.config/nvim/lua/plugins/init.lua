-- Plugin manager setup and loading of sub-modules

-- Install lazy.nvim if not installed
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require('lazy').setup({
  -- Load plugin specs from separate modules
  { import = 'plugins.specs.editor' },
  { import = 'plugins.specs.ui' },
  { import = 'plugins.specs.git' },
  { import = 'plugins.specs.lsp' },
  { import = 'plugins.specs.completion' },
  { import = 'plugins.specs.treesitter' },
  { import = 'plugins.specs.telescope' },
  { import = 'plugins.specs.debugging' },
  { import = 'plugins.specs.formatting' },
  { import = 'plugins.specs.linting' },
})
