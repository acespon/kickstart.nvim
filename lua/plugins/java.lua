return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  config = function()
    local jdtls = require 'jdtls'

    local function get_jdtls_paths()
      local mason_registry = require 'mason-registry'
      local jdtls_pkg = mason_registry.get_package 'jdtls'
      local jdtls_path = jdtls_pkg:get_install_path()
      local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

      local os_config
      if vim.fn.has 'mac' == 1 then
        os_config = 'config_mac'
      elseif vim.fn.has 'unix' == 1 then
        os_config = 'config_linux'
      else
        os_config = 'config_win'
      end

      return {
        launcher = launcher,
        config_dir = jdtls_path .. '/' .. os_config,
      }
    end

    local function get_workspace_dir()
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      return vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      group = vim.api.nvim_create_augroup('jdtls-attach', { clear = true }),
      callback = function()
        local paths = get_jdtls_paths()
        local config = {
          cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xmx1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-jar', paths.launcher,
            '-configuration', paths.config_dir,
            '-data', get_workspace_dir(),
          },
          root_dir = vim.fs.root(0, { 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'settings.gradle.kts', 'pom.xml', '.git' }),
          settings = {
            java = {
              eclipse = { downloadSources = true },
              configuration = { updateBuildConfiguration = 'interactive' },
              maven = { downloadSources = true },
              references = { includeDecompiledSources = true },
              inlayHints = { parameterNames = { enabled = 'all' } },
              signatureHelp = { enabled = true },
              completion = {
                favoriteStaticMembers = {
                  'org.junit.jupiter.api.Assertions.*',
                  'org.mockito.Mockito.*',
                  'org.mockito.ArgumentMatchers.*',
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
          },
          capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
          ),
        }

        jdtls.start_or_attach(config)
      end,
    })
  end,
}
