local lsp = require('lsp-zero').preset({})

lsp.preset("recommended")

lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {}
lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})
lspconfig.standardrb.setup {
    -- cmd = { "true" }
    -- cmd = { "standardrb", "--lsp", "--fail-level", "error", "--display-only-fail-level-offenses" }
}
lspconfig.ts_ls.setup {
    on_attach = function(client, bufnr)
        require("twoslash-queries").attach(client, bufnr)
    end,
}
lspconfig.solargraph.setup {
    init_options = { formatting = false },
    settings = {
        solargraph = {
            diagnostics = false,
            completion = true
        }
    },
}
lspconfig.rust_analyzer.setup {
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
        ['rust-analyzer'] = {},
    },
}

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
        }),
    },
})

local status, prettier = pcall(require, "prettier")
if (status) then
    prettier.setup({
        filetypes = {
            "css",
            "javascript",
            "javacriptreact",
            "typescript",
            "typescriptreact",
            "json",
            "scss",
            "less"
        }
    })
end

require('Comment').setup({
    toggler = {
        ---Line-comment toggle keymap
        line = '<C-/>',
        ---Block-comment toggle keymap
        block = '<C-?>',
    },
    opleader = {
        ---Line-comment keymap
        line = '<C-/>',
        ---Block-comment keymap
        block = '<C-?>',
    },
})
