function ColorMyPencils(color)
    color = color or "monokai"
    vim.cmd.colorscheme(color)
end

ColorMyPencils()
-- local solarized = require('solarized')
--
-- vim.o.background = 'light'
--
-- solarized:setup {
--     config = {
--         theme = 'neovim',
--         transparent = false
--     }
-- }
--
-- vim.cmd.colorscheme('solarized')
