---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'uv.lock', 'setup.py', 'requirements.txt', 'pyrightconfig.json', '.git' },
  settings = {
    basedpyright = {
      -- ruff handles import sorting
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = 'standard',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
