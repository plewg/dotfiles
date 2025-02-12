local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf',
    function()
        builtin.find_files({
            -- path_display = { 'smart' },
            find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }
        })
    end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({
        search = vim.fn.input("Grep > "),
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        }
    })
end)
