---@type LazySpec
return {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
        mappings = {
            n = {
                ["<Leader>lf"] = { require("conform").format, desc = "Format buffer with Conform" },
            },
        },
        -- Configuration table of features provided by AstroLSP
        features = {
            codelens = false, -- enable/disable codelens refresh on start
            -- inlay_hints = false, -- enable/disable inlay hints on start
            -- semantic_tokens = true, -- enable/disable semantic token highlighting
        },
        -- customize lsp formatting options
        formatting = {
            disabled = { "vtsls", "jsonls", "bashls" },
            timeout_ms = 10000, -- default format timeout
        },
        -- TODO: bashls/shellcheck code actions?
        config = {
            ["*"] = {
                capabilities = {
                    textDocument = {
                        completion = {
                            completionItemKind = {
                                valueSet = {
                                    -- 1, -- Text
                                    2, -- Method
                                    3, -- Function
                                    4, -- Constructor
                                    5, -- Field
                                    6, -- Variable
                                    7, -- Class
                                    8, -- Interface
                                    9, -- Module
                                    10, -- Property
                                    11, -- Unit
                                    12, -- Value
                                    13, -- Enum
                                    14, -- Keyword
                                    15, -- Snippet
                                    16, -- Color
                                    17, -- File
                                    18, -- Reference
                                    19, -- Folder
                                    20, -- EnumMember
                                    21, -- Constant
                                    22, -- Struct
                                    23, -- Event
                                    24, -- Operator
                                    25, -- TypeParameter
                                },
                            },
                        },
                    },
                },
            },
            eslint = {
                settings = {
                    rulesCustomizations = {
                        { rule = "*", severity = "warn" },
                        { rule = "import/no-unused-modules", severity = "off" },
                        { rule = "import-x/no-unused-modules", severity = "off" },
                    },
                },
            },
            vtsls = {
                capabilities = {
                    textDocument = {
                        completion = {
                            completionItem = {
                                preselectSupport = true,
                            },
                        },
                    },
                },
                ["js/ts.format.enabled"] = false,
                settings = {
                    typescript = {
                        preferences = {
                            includePackageJsonAutoImports = "on",
                            importModuleSpecifier = "non-relative",
                        },
                    },
                    vtsls = {
                        autoUseWorkspaceTsdk = true,
                    },
                },
            },
            jsonls = {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                    },
                    validate = { enable = true },
                },
            },
            yamlls = {
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = true,
                        },
                    },
                },
            },
        },
    },
    specs = {
        { "nvimtools/none-ls.nvim", enabled = false },
    },
}
