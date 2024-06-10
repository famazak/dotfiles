-- Themes
local cmd = vim.cmd
local set_hl = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd
local utils = require('utils')

-- Lualine transparent bg
set_hl(0, 'lualine_transitional_lualine_a_replace_to_StatusLine', { bg = 'None' })
set_hl(0, 'lualine_transitional_lualine_a_insert_to_StatusLine', { bg = 'None' })
set_hl(0, 'lualine_transitional_lualine_a_normal_to_StatusLine', { bg = 'None' })
set_hl(0, 'lualine_transitional_lualine_a_command_to_StatusLine', { bg = 'None' })
set_hl(0, 'lualine_transitional_lualine_a_visual_to_StatusLine', { bg = 'None' })

-- LSP Diagnostics
cmd [[
sign define DiagnosticSignError text= texthl=DiagnosticError linehl= numhl=
sign define DiagnosticSignWarn  text= texthl=DiagnosticWarn  linehl= numhl=
sign define DiagnosticSignInfo  text= texthl=DiagnosticInfo  linehl= numhl=
sign define DiagnosticSignHint  text= texthl=DiagnosticHint  linehl= numhl=
]]
set_hl(0, 'DiagnosticError', { fg = 'red', bg = 'None' })
set_hl(0, 'DiagnosticWarn', { fg = 'orange', bg = 'None' })
set_hl(0, 'DiagnosticInfo', { fg = 'teal', bg = 'None' })
set_hl(0, 'DiagnosticHint', { fg = 'white', bg = 'None' })

-- Additional Transparency
-- set_hl(0, 'Normal', { bg = 'None', ctermbg = 'None' })
-- set_hl(0, 'SignColumn', { bg = 'None' })
-- set_hl(0, 'Pmenu', { bg = 'None', ctermbg = 'None' })
-- set_hl(0, 'NonText', { fg = 'gray', bg = 'None' })
-- set_hl(0, 'NormalFloat', { bg = 'None', ctermbg = 'None' })

local theme = {
  -- grays
	["gray-10"] =  '#aaaaaa',
	["gray-15"] =  '#a3a3a3',
	["gray-25"] =  '#999999',
	["gray-55"] =  '#555555',
	["gray-80"] =  '#3a3a3a',
	["gray-85"] =  '#333333',
	["gray-95"] =  '#222222',
  -- oranges
  ["orange-10"] = '#D65D0E',
}

if os.getenv("THEME_VARIANT") == 'light' then
  for i, color in pairs(theme) do
    theme[i] = utils.invert_hex_color(color)
  end
end

-- Italic comments
set_hl(0, 'Comment', { bg = 'None', fg = theme['gray-55'], italic = true })

-- Spelling
set_hl(0, 'SpellBad', { undercurl = true })
set_hl(0, 'SpellRare', { undercurl = true })
set_hl(0, 'SpellCap', { undercurl = true })
set_hl(0, 'SpellLocal', { undercurl = true })

-- Invisiblish pane separators
set_hl(0, 'VertSplit', { bg = 'None', fg = theme['gray-95'] })

-- -- Floating borders
-- set_hl(0, 'PmenuBorder', { fg = theme['gray-85'], ctermfg = 'gray', bg = 'None', ctermbg = 'None' })
-- set_hl(0, 'FloatBorder', { fg = theme['gray-85'], ctermfg = 'gray', bg = 'None', ctermbg = 'None' })

-- LspInfo
-- set_hl(0, 'LspInfoBorder', { fg = theme['gray-95'], ctermfg = 'gray', bg = 'None', ctermbg = 'None' })

-- Git signs column plugin
set_hl(0, 'GitSignsAdd', { fg = 'SpringGreen2', bg = 'None' })
set_hl(0, 'GitSignsChange', { fg = 'MediumPurple2', bg = 'None' })
set_hl(0, 'GitSignsDelete', { fg = 'Red1', bg = 'None' })

-- Cursorline
set_hl(0, 'CursorLine', { bg = theme['gray-95'] })
set_hl(0, 'CursorLineNr', { bg = theme['gray-95'], fg = theme['orange-10'] }) -- Also highlight number column

-- Folds
set_hl(0, 'Folded', { bg =  'None', fg = theme['gray-85'], bold = false, nocombine = true })

-- Highlight current row in NORMAL mode,
-- hide highlight in INSERT mode
autocmd({ 'InsertEnter', 'InsertLeave' }, { pattern = '*', command = 'set cul!' })

