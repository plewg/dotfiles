vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.g.mapleader = " "
-- vim.g.editorconfig = false
vim.o.signcolumn = "yes"
vim.o.winborder = "single"
vim.o.laststatus = 3
vim.o.colorcolumn = "80,120"

-- Normal Mode
vim.keymap.set("n", "<leader>so", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>sv", ":vnew<CR>")
vim.keymap.set("n", "<leader>sh", ":new<CR>")
vim.keymap.set({ "n", "v" }, "<leader>ds", ":put =strftime('%Y-%m-%d')<CR>")
vim.keymap.set("n", "<leader>in", ":Inspect<CR>")
vim.keymap.set("n", "-", "<C-x>")
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Copy rel path to current file
vim.keymap.set("n", "<leader>rp", [[:let @+ = expand("%")<CR>]])
vim.keymap.set("n", "<leader>fp", [[:let @+ = expand("%:p")<CR>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Visual Mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<leader>sn", ":!sort -n<CR>")

vim.pack.add({
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/numToStr/Comment.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/nvimtools/none-ls.nvim" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/pmizio/typescript-tools.nvim" },
    { src = "https://github.com/plewg/monokai.nvim" },
    {
        src = "https://github.com/theprimeagen/harpoon",
        version = "harpoon2",
    },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
})

require("ibl").setup()

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method("textDocument/completion") then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}
            for i = 32, 126 do
                table.insert(chars, string.char(i))
            end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.cmd([[set completeopt+=menuone,noinsert]])

require("mini.pick").setup()
-- Only search case sensitive when a capital letter is present in the term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.keymap.set("n", "<leader>pf", ":Pick files<CR>")
vim.keymap.set("n", "<leader>ps", ":Pick grep<CR>")

vim.lsp.enable({ "lua_ls", "eslint", "tailwindcss", "ts_ls", "bashls", "marksman", "prismals" })

-- Theming
vim.cmd(":hi statusline guibg=NONE")
vim.cmd(":hi SignColumn guibg=NONE")
vim.cmd(":hi LineNr guibg=NONE")

vim.cmd("colorscheme monokai")
-- Transparency
-- vim.cmd([[
--   highlight Normal guibg=none
--   highlight NonText guibg=none
--   highlight Normal ctermbg=none
--   highlight NonText ctermbg=none
-- ]])

local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.prisma_format,
        null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
            extra_filetypes = { "sh" },
        }),
    },
    on_attach = function(client, bufnr)
        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end
    end,
})

local status, prettier = pcall(require, "prettier")
if status then
    prettier.setup({
        filetypes = {
            "css",
            "javascript",
            "javacriptreact",
            "typescript",
            "typescriptreact",
            "json",
            "scss",
            "less",
            "markdown",
            "sh",
        },
    })
end

local opts = { buffer = bufnr, remap = false }

-- THESE ARE THE GUYS I ALWAYS FORGET
vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
end, opts)
vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, opts)
vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
end, opts)
-- SHOW DIAGNOSTICS
vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
end, opts)
vim.keymap.set("n", "<leader>va", function()
    vim.diagnostic.setloclist()
end, opts)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
end, opts)
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
end, opts)
vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
end, opts)
vim.keymap.set("n", "<leader>vrr", function()
    vim.lsp.buf.references()
end, opts)
vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
end, opts)
vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
end, opts)

-- Harpoon
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>1", function()
    harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
    harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
    harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>4", function()
    harpoon:list():select(4)
end)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>")

require("Comment").setup({
    toggler = {
        ---Line-comment toggle keymap
        line = "<C-/>",
        ---Block-comment toggle keymap
        block = "<C-?>",
    },
    opleader = {
        ---Line-comment keymap
        line = "<C-/>",
        ---Block-comment keymap
        block = "<C-?>",
    },
})

vim.opt.undofile = true

local treesitter_filetypes = {
    "markdown",
    "prisma",
}

require("nvim-treesitter").install(treesitter_filetypes)

for _, v in pairs(treesitter_filetypes) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { v },
        callback = function()
            vim.treesitter.start()
        end,
    })
end

require("toggleterm").setup({
    open_mapping = [[<C-\>]],
    direction = "vertical",
    size = 80,
    autochdir = true,
})
