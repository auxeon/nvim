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
    -- 1. Setup Neodev & Mason (Mason must load before mason-lspconfig)
    require('neodev').setup({})
    require('mason').setup({})
    -- 2. Define custom configurations using the new native API
    -- This replaces require('lspconfig').lua_ls.setup({...})
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
        },
      },
    })
    vim.lsp.config('clangd', {
      cmd = { "clangd", "--enable-config", "--clang-tidy", "--log=verbose" },
      filetypes = { 'c', 'cpp', 'h', 'hpp', 'objc', 'objcpp', 'cuda' },
      init_options = { clangdFileStatus = true },
      -- root_markers replaces root_dir in the new API for common patterns
      root_markers = { ".clangd", ".git", "compile_commands.json", "compile_flags.txt" },
      settings = { clangd = { fallbackFlags = { "-std=c++20" } } },
    })
    vim.lsp.config('pyright', {
      cmd = { "pyright-langserver", "--stdio" },
    })
    -- 3. Initialize mason-lspconfig with automatic enabling
    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls', 'cssls', 'html', 'lua_ls', 'jsonls', 'lemminx',
        'marksman', 'quick_lint_js', 'ts_ls', 'yamlls', 'clangd',
        'pyright', 'rust_analyzer', 'gopls',
      },
      -- This automatically calls vim.lsp.enable() for all installed servers,
      -- merging your custom vim.lsp.config defined above.
      automatic_enable = true, 
    })
    -- 4. Unified LSP Keybindings (Modern LspAttach approach)
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- Add your keybindings here, e.g.:
        -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      end,
    })
    -- 5. Diagnostic & UI Configuration
    vim.diagnostic.config({
      virtual_text = { spacing = 2, prefix = "" },
      signs = false,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
    -- Rounded borders for hover/signature help
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
  end
}
