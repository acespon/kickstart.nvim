-- nvim-treesitter `main` branch (requires Neovim 0.12+ and tree-sitter-cli).
-- The plugin only installs parsers; highlighting and indentation are
-- enabled per buffer in the FileType autocmd below.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- No-op for parsers that are already installed
    ts.install {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'go',
      'css',
      'javascript',
      'json',
      'yaml',
      'typescript',
      'tsx',
      'java',
      'python',
    }

    local function start(buf, lang)
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      vim.treesitter.start(buf, lang)
      if lang == 'ruby' then
        vim.bo[buf].syntax = 'ON' -- keep regex highlighting alongside treesitter
      else
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Start treesitter, installing the parser if missing',
      group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end
        if vim.treesitter.language.add(lang) then
          start(args.buf, lang)
        elseif vim.tbl_contains(ts.get_available(), lang) then
          -- Replaces the old `auto_install = true`
          ts.install(lang):await(function(err)
            if not err then
              vim.schedule(function()
                start(args.buf, lang)
              end)
            end
          end)
        end
      end,
    })
  end,
}
