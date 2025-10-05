-- Formatting configuration

return {
  -- Formatters
  'averms/black-nvim',
  {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        formatters = {
          prettier = {
            require_cwd = true,
          },
        },
        formatters_by_ft = {
          python = {"ruff_fix", "ruff_format", "ruff_organize_imports"},
          yaml = {"yamlfmt"},
          rust = {"rustfmt"},
          c = {"clang-format"},
          cpp = {"clang-format"},
          go = {"gofumpt"},
          javascript = {"prettier"},
          typescript = {"prettier"},
        }
      })
    end
  },
  -- Ensure formatters are installed
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'yamlfmt',
          'yamllint',
          'black',
          'isort',
          'ruff',
          'mypy',
          'sqlfluff',
          'codelldb',
          'rustfmt',
          'cpptools',
          'clangd',
          'clang-format',
          'gopls',
          'golangci-lint',
          'gofumpt',
          'prettier'
        },
      }
    end
  },
}
