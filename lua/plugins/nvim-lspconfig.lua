-- LSP Support
return {
  -- LSP Configuration
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Management
    -- https://github.com/williamboman/mason.nvim
    { 'williamboman/mason.nvim' },
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { 'williamboman/mason-lspconfig.nvim' },

    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    -- https://github.com/folke/neodev.nvim
    { 'folke/neodev.nvim' },
  },

  config = function()
    -- require('neodev').setup({})
    require('mason').setup()

    require('mason-lspconfig').setup({
      -- Install these LSPs automatically
      ensure_installed = {
        'bashls', -- requires npm to be installed
        'cssls', -- requires npm to be installed
        'html', -- requires npm to be installed
        'lua_ls',
        'jsonls', -- requires npm to be installed
        'lemminx',
        'marksman',
        'quick_lint_js',
        'ts_ls', -- requires npm to be installed
        'yamlls', -- requires npm to be installed
        'clangd',
        'pyright',
        'rust_analyzer',
        'gopls', -- requires go to be installed
      },
      automatic_installation = true,
    })

    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')
    -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lsp_attach = function(client, bufnr)
      -- Create your keybindings here...
    end

    -- Override bashls
    lspconfig.bashls.setup({
      on_attach = lsp_attach,
      settings = {},
    })

    -- Override bashls
    lspconfig.bashls.setup({
      on_attach = lsp_attach,
      settings = {},
    })

    -- Override csslss
    lspconfig.cssls.setup({
      on_attach = lsp_attach,
      settings = {},
    })

    -- Override html
    lspconfig.html.setup({
      on_attach = lsp_attach,
      settings = {},
    })

    -- Override lua_ls
    lspconfig.lua_ls.setup({
      on_attach = lsp_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })

    -- Override jsonls
    lspconfig.jsonls.setup({
      on_attach = lsp_attach,
      settings = {},
    })

    -- Override lemminx
    lspconfig.lemminx.setup({
      on_attach = lsp_attach,
      settings = {},
    })

    -- Override quick_lint_js
    lspconfig.quick_lint_js.setup({
      on_attach = lsp_attach,
      settings = {},
    })


    -- Override ts_ls
    lspconfig.ts_ls.setup({
      on_attach = lsp_attach,
      settings = {},
    })
    
    -- Override yamlls
    lspconfig.yamlls.setup({
      on_attach = lsp_attach,
      settings = {},
    })



    -- Override clangd
    lspconfig.clangd.setup({
      on_attach = lsp_attach,
      cmd = {
        "clangd",
        "--enable-config",
        "--clang-tidy",
        "--log=verbose",
      },
      filetypes = { 'c', 'cpp', 'h', 'hpp', 'objc', 'objcpp', 'cuda' },
      init_options = {
        clangdFileStatus = true,
      },
      root_dir = util.root_pattern(
        ".clangd",
        ".git",
        "compile_commands.json",
        "compile_flags.txt"
      ),
      settings = {
        clangd = {
          fallbackFlags = {"-std=c++20"}
        }
      },
      on_new_config = function(config, root)
        config.cmd_cwd = root
      end,
    })

    -- Override pyright
    lspconfig.pyright.setup({
      on_attach = lsp_attach,
      cmd = {"pyright-langserver", "--stdio"},
      settings = {},
    })

    -- Override rust_analyzer
    lspconfig.rust_analyzer.setup({
      on_attach = lsp_attach,
      settings = {},
    })

    -- Override gopls
    lspconfig.gopls.setup({
      on_attach = lsp_attach,
      settings = {},
    })

    -- Diagnostic display configuration
    vim.diagnostic.config({
      virtual_text = {
        spacing = 2,
        prefix = "",
      },
      signs = false,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })


    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end,
}
