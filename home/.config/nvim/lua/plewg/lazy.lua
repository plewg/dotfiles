local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons'
        }
    },
    {
        'tanvirtin/monokai.nvim',
        name = 'monokai',
        config = function()
            vim.cmd('colorscheme monokai')
        end
    },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/playground' },
    { 'theprimeagen/harpoon' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require('mason').setup {
                log_level = vim.log.levels.INFO,
                registries = {
                    'lua:mason-registry.index',
                    'github:mason-org/mason-registry',
                },
            }
        end,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'MasonToolsStartingInstall',
                callback = function()
                    vim.schedule(function()
                        print 'mason-tool-installer is starting'
                    end)
                end,
            })
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    'neovim/nvim-lspconfig',
    {
        "nvimtools/none-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    'MunifTanjim/prettier.nvim',
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                toggler = {
                    ---Line-comment toggle keymap
                    line = 'C-/',
                },
            })
        end
    },
    {
        'brenoprata10/nvim-highlight-colors'
    },
    "marilari88/twoslash-queries.nvim",
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    }
})
