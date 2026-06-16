-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Open parent directory
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Exit terminal mode in the builtin terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Resize windows with ctrl + arrow keys
vim.keymap.set('n', '<Space><Left>', '<cmd>vertical resize -2<CR>', { desc = 'Resize window left' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Resize window right' })
vim.keymap.set('n', '<C-Up>', '<cmd>resize -2<CR>', { desc = 'Resize window up' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize +2<CR>', { desc = 'Resize window down' })

-- Lua execute
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('v', '<space>x', ':.lua<CR>')

-- GO Keybinds
vim.keymap.set('n', '<space>g', '', { desc = '[G]o' })
vim.keymap.set('n', '<space>gt', ':GoTest<CR>', { desc = '[G]o [T]est' })
vim.keymap.set('n', '<space>gb', ':GoBuild<CR>', { desc = '[G]o [B]uild' })
vim.keymap.set('n', '<space>gr', ':GoRun<CR>', { desc = '[G]o [R]un' })
