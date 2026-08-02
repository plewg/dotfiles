return {
    {
        "AstoNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
            mappings = {
                n = {
                    ["<Leader><Leader>u"] = {
                        function()
                            -- vim.cmd.Neotree "close"
                            vim.cmd "UndotreeToggle"
                        end,
                        desc = "Toggle undotree",
                    },
                },
            },
        },
    },
    {
        "AstoNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
            mappings = {
                -- n = {
                --     -- ["<Leader>f"] = {
                --     --     vim.lsp.buf.format,
                --     --     desc = "Format buffer",
                --     -- },
                --     ["<Leader>ll"] = false,
                --     ["<Leader>lL"] = false,
                --     ["<Leader>lI"] = false,
                --     ["<Leader>lA"] = false,
                --     ["<Leader>lG"] = false,
                --     ["<Leader>ls"] = {
                --         function() vim.lsp.buf.code_action { context = { only = { "source" }, diagnostics = {} } } end,
                --         desc = "LSP source action",
                --         cond = "textDocument/codeAction",
                --     },
                --     ["<Leader>lw"] = {
                --         function() vim.lsp.buf.workspace_symbol() end,
                --         desc = "Search workspace symbols",
                --         cond = "workspace/symbol",
                --     },
                --     ["<Leader>lh"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
                --     ["<Leader>lr"] = {
                --         function() vim.lsp.buf.references() end,
                --         desc = "Search references",
                --         cond = "textDocument/references",
                --     },
                --     ["<Leader>ln"] = {
                --         function() vim.lsp.buf.rename() end,
                --         desc = "Rename current symbol",
                --         cond = "textDocument/rename",
                --     },
                --     ["<Leader>lR"] = false,
                -- },
            },
        },
    },
}
