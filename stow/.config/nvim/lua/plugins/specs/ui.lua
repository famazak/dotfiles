-- UI related plugins

return {
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup{
        options = {
          theme = 'gruvbox_dark',
          icons_enabled = true,
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_c = {{'filename', path = 1}},
        },
      }
    end,
  },
  
  -- Colorscheme
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          operators = true,
          comments = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = false,
        contrast = "hard",
        palette_overrides = {},
        overrides = {},
        dim_inactive = true,
        transparent_mode = false,
      })
      vim.cmd.colorscheme 'gruvbox'
      vim.api.nvim_set_hl(0, "Normal", {guibg = NONE, ctermbg = NONE})
      vim.o.background = "dark"
    end
  },
}
