return {
  "nvim-treesitter/nvim-treesitter",
  -- Using 'master' branch for the most stable API with lazy.nvim
  branch = "master",
  build = ":TSUpdate",
  -- lazy = false ensures it attaches to the VERY FIRST buffer on startup
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    -- Explicitly list core languages to force initial download
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "markdown" },
    -- sync_install = true prevents the 'ld' error on the first run by blocking the UI
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
      -- Stops Treesitter from messing with your NvimTree explorer
      disable = { "NvimTree" },
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = false },
  },
  config = function(_, opts)
    -- THE "FIRST RUN" FIX:
    -- Force create the parser directory so the C compiler doesn't fail 
    -- when trying to write parser.so on a fresh install.
    local parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser"
    if vim.fn.isdirectory(parser_install_dir) == 0 then
      vim.fn.mkdir(parser_install_dir, "p")
    end

    -- Setup Treesitter with the provided opts
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)

    -- Treesitter-based folding (effortless and automatic)
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    -- Keep all folds open by default when entering a file
    vim.opt.foldlevel = 99
  end,
}

