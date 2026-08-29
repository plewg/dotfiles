return {
    "saghen/blink.cmp",
    opts = {
        keymap = {
            ["<Tab>"] = {
                "snippet_forward",
                "select_and_accept",
                "fallback",
            },
            ["<CR>"] = false,
        },
        completion = {
            list = { selection = { preselect = true, auto_insert = false } },
            menu = {
                auto_show = true,
            },
        },
        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                -- "buffer",
            },
        },
    },
}
