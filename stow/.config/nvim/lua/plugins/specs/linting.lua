-- Linting configuration

return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local mypy = require('lint').linters.mypy
      mypy.args = {
        '--show-column-numbers',
        '--show-error-end',
        '--hide-error-codes',
        '--hide-error-context',
        '--no-color-output',
        '--no-error-summary',
        '--no-pretty',
        '--python-executable=.venv/bin/python'
      }
      require('lint').linters_by_ft = {
        python = {'mypy',},
        yaml = {'yamllint',},
        sql = {'sqlfluff',},
        go = {'golangcilint',},
      }
    end
  },
}
