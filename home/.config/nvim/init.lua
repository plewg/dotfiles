require('mason').setup {
    -- log_level = vim.log.levels.DEBUG,
    log_level = vim.log.levels.INFO,
    registries = {
        'lua:mason-registry.index',
        'github:mason-org/mason-registry',
    },
}
--require("mason").setup()
require("plewg")

vim.api.nvim_create_autocmd('User', {
    pattern = 'MasonToolsStartingInstall',
    callback = function()
        vim.schedule(function()
            print 'mason-tool-installer is starting'
        end)
    end,
})

