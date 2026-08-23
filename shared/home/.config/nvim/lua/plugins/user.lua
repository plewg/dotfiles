---@type LazySpec
return {
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                enabled = false,
            },
        },
    },
    { -- override nvim-autopairs plugin
        "windwp/nvim-autopairs",
        config = function(plugin, opts)
            -- run default AstroNvim config
            opts.map_cr = false
            require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts)
        end,
    },
}
