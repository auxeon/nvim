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
    {'folke/neodev.nvim' },
  },
  config = function ()
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- Install these LSPs automatically
      ensure_installed = {
        -- 'bashls', -- requires npm to be installed
        -- 'cssls', -- requires npm to be installed
        -- 'html', -- requires npm to be installed
        'lua_ls',
        -- 'jsonls', -- requires npm to be installed
        'lemminx',
        'marksman',
        'quick_lint_js',
        -- 'tsserver', -- requires npm to be installed
        -- 'yamlls', -- requires npm to be installed
        'clangd',
        'pyright',
        'rust_analyzer',
      },
      automatic_installation = true,
      -- automatic_enable = true,
    })

    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Create your keybindings here...
    end

    -- Call setup on each LSP server
    -- require('mason-lspconfig').setup_handlers({
    --   function(server_name)
    --     lspconfig[server_name].setup({
    --       on_attach = lsp_attach,
    --       capabilities = lsp_capabilities,
    --     })
    --   end
    -- })

    -- Lua LSP settings
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    }

    -- C/C++ clangd settings 
    lspconfig.clangd.setup {
      cmd = {
        "clangd",
        "--enable-config",
        "--clang-tidy",
        "--log=verbose",
      },
      filetypes = { 'c', 'cpp', 'h', 'hpp', 'objc', 'objcpp', 'cuda' },
      init_options = {
        clangdFileStatus = true
      },
      settings = {
        clangd = {
          fallbackFlags = {
            cpp = {"-std=c++20"},
          }
        }
      },
      root_dir = util.root_pattern(".clangd", ".git", "compile_commands.json"),
      on_new_config = function(config, root)
        config.cmd_cwd = root
        vim.notify("[clangd] on_new_config called for root: " .. config.cmd_cwd)
      end,
    }

    -- python settings
    -- lspconfig.pyright.setup {
    -- cmd = { "pyright-langserver", "--stdio" },
    -- }
    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end

  end
}
