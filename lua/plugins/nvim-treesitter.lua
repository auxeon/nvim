-- Code Tree Support / Syntax Highlighting
return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        event = 'BufReadPost',
        lazy = false,
        build = ':TSUpdate',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                branch = 'main',
            },
        },
        opts = {
            highlight = {
                enable = true,                     -- enable Tree-sitter highlighting
                additional_vim_regex_highlighting = false,  -- disable old Vim regex highlights
            },
            indent = { enable = true },            -- Tree-sitter based indentation
            auto_install = true,                   -- auto-install missing parsers
            ensure_installed = "all",              -- install all supported languages
        },
        config = function(_, opts)
            -- on the main branc the config is singular with 's'
            local configs = require("nvim-treesitter.config")
            -- Force Tree-sitter to attach to all existing buffers
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                vim.treesitter.start(buf)
            end
            configs.setup(opts)
            -- Turn off legacy Vim syntax to remove red { } in C99
            vim.cmd([[syntax off]])
        end,
    },
}

