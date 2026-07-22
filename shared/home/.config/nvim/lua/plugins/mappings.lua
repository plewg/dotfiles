return {
    {
        "AstoNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
            mappings = {
                n = {
                    ["<Leader>p"] = { desc = "Project" },
                    ["<Leader>pf"] = {
                        function() require("snacks").picker.files { hidden = true, ignored = false } end,
                        desc = "Find all files",
                    },
                    ["<Leader>ps"] = {
                        function() require("snacks").picker.grep { hidden = true, ignored = false } end,
                        desc = "Search in all files",
                    },
                    ["<Leader>sv"] = {
                        ":vnew<CR>",
                        desc = "New vertical split",
                    },
                    ["<Leader>sh"] = {
                        ":new<CR>",
                        desc = "New horizontal split",
                    },
                    ["<Leader>ds"] = {
                        ":put =strftime('%Y-%m-%d')<CR>",
                        desc = "Insert current date",
                    },
                    ["<Leader>u"] = {
                        function()
                            vim.cmd.Neotree "close"
                            require("undotree").toggle()
                        end,
                        desc = "Toggle undotree",
                    },
                    ["<Leader>pv"] = {
                        function()
                            vim.cmd ":UndotreeHide"
                            vim.cmd ":Neotree toggle reveal"
                        end,
                        desc = "Toggle explorer",
                    },
                    ["<Leader>ss"] = {
                        [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
                        desc = "Replace all",
                    },
                    ["<Leader>c"] = { desc = "Copy" },
                    ["<Leader>cp"] = { desc = "Copy path" },
                    ["<leader>cpr"] = { [[:let @+ = expand("%")<CR>]], desc = "Copy relative path" },
                    ["<leader>cpa"] = { [[:let @+ = expand("%:p")<CR>]], desc = "Copy absolute path" },
                    ["<leader>x"] = { "<cmd>!chmod +x %<CR>", desc = "", silent = true },
                    ["o"] = { "<Nop>" },
                    ["<S-Up>"] = { "<Nop>" },
                    ["<S-Down>"] = { "<Nop>" },
                    ["<F1>"] = { "<Nop>" },
                    ["<C-/>"] = { "gcc", remap = true, desc = "Toggle comment line" },
                    ["<Leader>vd"] = {
                        function() vim.diagnostic.open_float() end,
                        desc = "View diagnostics",
                    },
                    ["<Leader>va"] = {
                        function() vim.diagnostic.setloclist() end,
                        desc = "Add buffer diagnostics to the location list",
                    },
                    ["<Leader>vca"] = {
                        function() vim.lsp.buf.code_action() end,
                        desc = "View code actions",
                    },
                    ["<Leader>vrr"] = {
                        function() require("snacks.picker").lsp_references() end,
                        desc = "View references",
                    },
                    ["<Leader>vrn"] = {
                        function() vim.lsp.buf.rename() end,
                        desc = "Rename",
                    },
                    ["<Leader>vws"] = {
                        function() require("snacks.picker").lsp_workspace_symbols() end,
                    },
                    ["<Leader>a"] = {
                        function() require("harpoon"):list():add() end,
                        desc = "Add mark",
                    },
                    ["<C-e>"] = {
                        function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
                    },
                    ["<Leader>1"] = {
                        function() require("harpoon"):list():select(1) end,
                        desc = "Go to mark 1",
                    },
                    ["<Leader>2"] = {
                        function() require("harpoon"):list():select(2) end,
                        desc = "Go to mark 2",
                    },
                    ["<Leader>3"] = {
                        function() require("harpoon"):list():select(3) end,
                        desc = "Go to mark 3",
                    },
                    ["<Leader>4"] = {
                        function() require("harpoon"):list():select(4) end,
                        desc = "Go to mark 4",
                    },
                    ["<Leader>fa"] = false,
                    ["<Leader>fb"] = false,
                    ["<Leader>fc"] = false,
                    ["<Leader>fC"] = false,
                    ["<Leader>ff"] = false,
                    ["<Leader>fF"] = false,
                    ["<Leader>fg"] = false,
                    ["<Leader>fh"] = false,
                    ["<Leader>fk"] = false,
                    ["<Leader>fl"] = false,
                    ["<Leader>fm"] = false,
                    ["<Leader>fn"] = false,
                    ["<Leader>fo"] = false,
                    ["<Leader>fO"] = false,
                    ["<Leader>fp"] = false,
                    ["<Leader>fr"] = false,
                    ["<Leader>fs"] = false,
                    ["<Leader>ft"] = false,
                    ["<Leader>fT"] = false,
                    ["<Leader>fu"] = false,
                    ["<Leader>fw"] = false,
                    ["<Leader>fW"] = false,
                    ["<Leader>f'"] = false,
                    ["<Leader>f<CR>"] = false,
                    ["<Leader>f"] = false,
                    ["<Leader>C"] = false,
                    ["<Leader>e"] = false,
                    ["<C-x>"] = false,
                    ["<Leader>/"] = false,
                    ["<Leader>pa"] = false,
                    ["<Leader>pi"] = false,
                    ["<Leader>pm"] = false,
                    ["<Leader>pM"] = false,
                    ["<Leader>pS"] = false,
                    ["<Leader>pu"] = false,
                    ["<Leader>pU"] = false,
                },
                v = {
                    ["<S-Up>"] = { "<Nop>" },
                    ["<S-Down>"] = { "<Nop>" },
                    ["<F1>"] = { "<Nop>" },
                    ["J"] = { ":m '>+1<CR>gv=gv", desc = "Move selection down" },
                    ["K"] = { ":m '<-2<CR>gv=gv", desc = "Move selection up" },
                    ["<leader>sn"] = { ":!sort -n<CR>", desc = "Natural sort selection" },
                    ["<Leader>vca"] = {
                        function() vim.lsp.buf.code_action() end,
                        desc = "View code actions",
                    },
                },
                i = {
                    ["<Tab>"] = {
                        function() return vim.fn.pumvisible() == 1 and "<CR>" or "<Tab>" end,
                        silent = true,
                        expr = true,
                    },
                    ["<CR>"] = {
                        function() return vim.fn.pumvisible() == 1 and "<C-e><CR>" or "<CR>" end,
                        silent = true,
                        expr = true,
                    },
                    ["<C-h>"] = {
                        function() vim.lsp.buf.signature_help() end,
                    },
                },
                x = {
                    ["<C-/>"] = { "gc", remap = true, desc = "Toggle comment" },
                },
            },
        },
    },
    {
        "AstoNvim/astrolsp",
        ---@type AstroLspOpts
        opts = {
            mappings = {
                n = {
                    ["<Leader>f"] = {
                        vim.lsp.buf.format,
                        desc = "Format buffer",
                    },
                },
            },
        },
    },
}
