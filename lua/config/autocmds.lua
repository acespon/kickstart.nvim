-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Auto-reload files changed externally (pairs with vim.opt.autoread)
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  desc = 'Reload buffers when file changes on disk',
  group = vim.api.nvim_create_augroup('autoread-reload', { clear = true }),
  command = 'checktime',
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
