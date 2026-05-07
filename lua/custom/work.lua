-- Work-specific configuration (DailyPay/employee-api)
-- This file is required at the end of init.lua and can be removed
-- or commented out for personal-only setups.

-- Templ filetype detection
vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}

-- Templ LSP is configured in lsp/templ.lua (vim.lsp.config)
vim.lsp.enable('templ')

-- Templ formatter (augments conform.nvim)
local conform_ok, conform = pcall(require, 'conform')
if conform_ok then
  conform.formatters_by_ft.templ = { 'templ' }
end

-- Templ treesitter parser
vim.defer_fn(function()
  local ts_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
  if ts_ok then
    ts_configs.setup {
      ensure_installed = { 'templ' },
    }
  end
end, 0)
