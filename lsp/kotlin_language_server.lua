---@type vim.lsp.Config
return {
  cmd = { 'kotlin-language-server' },
  filetypes = { 'kotlin' },
  root_markers = { 'build.gradle.kts', 'settings.gradle.kts', 'build.gradle', '.git' },
  settings = {
    kotlin = {
      compiler = {
        jvm = {
          target = '17',
        },
      },
    },
  },
}
