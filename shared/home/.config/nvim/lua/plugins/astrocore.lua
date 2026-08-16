---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        diagnostics = {
            severity_sort = true,
        },
        options = {
            opt = {
                clipboard = "",
                undofile = true,
                pumheight = 7,
                completeopt = "menuone,noinsert,popup",
                colorcolumn = "80,120",
                swapfile = false,
                -- smartcase = false,
                -- ignorecase = false,
            },
            g = { undotree_WindowLayout = 3 },
        },
    },
}
