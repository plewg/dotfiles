---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        treesitter = {
            ensure_installed = { "sql" },
        },
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
                pumborder = "rounded",
                -- showtabline = 0,
                -- smartcase = false,
                -- ignorecase = false,
            },
            g = { undotree_WindowLayout = 3 },
        },
        mappings = {
            i = {
                -- false isn't working to unmap here, so doing a noop instead
                ["<C-x><C-o>"] = function() end,
                ["<Tab>"] = {
                    function() return vim.fn.pumvisible() == 1 and "<CR>" or "<Tab>" end,
                    expr = true,
                },
                ["<CR>"] = {
                    function()
                        local npairs = require "nvim-autopairs"
                        if vim.fn.pumvisible() ~= 0 then
                            return npairs.esc "<C-e><CR>"
                        else
                            return vim.api.nvim_feedkeys(npairs.autopairs_cr(), "in", false)
                        end
                    end,
                    expr = true,
                    noremap = true,
                },
            },
            n = {
                ["<Tab>"] = {
                    function() require("astrocore.buffer").nav(1) end,
                },
                ["<S-Tab>"] = {
                    function() require("astrocore.buffer").nav(-1) end,
                },
                ["<Leader>fw"] = {
                    function() require("snacks").picker.grep { hidden = true } end,
                    desc = "Find words",
                },
            },
        },
    },
}
