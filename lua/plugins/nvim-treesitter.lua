return {
  "nvim-treesitter/nvim-treesitter",
  -- DO NOT USE 'main'. It is currently unstable and breaks auto-attach.
  branch = "master", 
  build = ":TSUpdate",
  -- We set lazy=false so it starts IMMEDIATELY without needing a manual start
  lazy = false, 
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      -- List languages explicitly to force the initial download
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "go", "rust", "javascript", "html", "json"},
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "NvimTree" },
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })

    -- This line makes Treesitter folding work automatically
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    -- Ensure folds are open by default
    vim.opt.foldlevel = 99
  end,
}

