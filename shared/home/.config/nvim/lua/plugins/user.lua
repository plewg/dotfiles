if true then return {} end

---@type LazySpec
return {
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    header = table.concat({ "" }, "\n"),
                },
            },
        },
    },
}
