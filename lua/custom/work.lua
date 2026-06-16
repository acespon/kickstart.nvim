-- Work-specific configuration (DailyPay/gigapi)
-- This file is required at the end of init.lua and can be removed
-- or commented out for personal-only setups.

-- Templ filetype detection
vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}

-- LSP servers (configs in lsp/*.lua)
vim.lsp.enable { 'templ', 'sourcekit', 'kotlin_language_server', 'buf_ls' }

-- Formatters (augments conform.nvim)
local conform_ok, conform = pcall(require, 'conform')
if conform_ok then
  conform.formatters_by_ft.templ = { 'templ' }
  conform.formatters_by_ft.kotlin = { 'ktlint' }
  conform.formatters_by_ft.proto = { 'buf' }
end

-- Treesitter parsers for work languages
local ts_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
if ts_ok then
  ts_configs.setup {
    ensure_installed = { 'templ', 'swift', 'kotlin', 'proto' },
  }
end
