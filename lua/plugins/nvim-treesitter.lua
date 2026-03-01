-- Code Tree Support / Syntax Highlighting
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    event = 'VeryLazy', -- Moved inside
    build = ':TSUpdate', -- Moved inside
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
      },
    },
    opts = {
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      auto_install = true,
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'query', -- Required for treesitter itself to work
      },
    },
    config = function(_, opts)
      -- On the 'main' branch, the module is singular: .config
      local configs = require("nvim-treesitter.config")
      configs.setup(opts)
    end,
  },
}
