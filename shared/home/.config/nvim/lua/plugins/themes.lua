-- if true then return {} end

return {
    { "ryovoid/dracula-night" },
    { dir = "/home/egg/Projects/eida" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = { after = "", keyword = "fg", multiline = false },
            -- colors = { info = "#ffbd2a" },
            keywords = {
                TODO = { color = "whee" },
                NOTE = { color = "whee" },
                SEE = { color = "whee" },
                SOURCES = { color = "whee" },
                SOURCE = { color = "whee" },
                README = { color = "whee" },
                XXX = { color = "whee" },
                WIP = { color = "whee" },
                FIXME = { color = "waa" },
                -- Sigh, https://github.com/folke/todo-comments.nvim/issues/213
                -- ["@todo"] = { color = "whee" },
                -- ["<<<<<<<"] = { color = "waa" },
                -- [">>>>>>>"] = { color = "waa" },
                -- ["======="] = { color = "waa" },
            },
            colors = {
                whee = { "#FDDD6C" },
                waa = { "#DB2777" },
            },
        },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require("rainbow-delimiters.setup").setup {
                highlight = {
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterPurple",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterRed",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                },
            }
        end,
    },
}
