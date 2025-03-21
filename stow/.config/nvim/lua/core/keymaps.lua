-- Keymaps that don't depend on plugins

-- Clear space key mapping
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<S-h>', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-l>', ':bn<CR>', { noremap = true, silent = true })

-- Window navigation
vim.api.nvim_set_keymap('n', '<leader>j', '<c-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<c-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', '<c-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<c-w>l', { noremap = true, silent = true })

-- Buffer management
vim.api.nvim_set_keymap('n', '<leader>x', ':bdelete<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':split<CR>', { noremap = true, silent = true })

-- Word wrap navigation
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- More remaps for a better experience
vim.keymap.set('n', '<leader>pv', ':Ex<CR>', { desc = 'Open netrw' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")
vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")
vim.keymap.set('n', '<leader>d', "\"_d")
vim.keymap.set('v', '<leader>d', "\"_d")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
