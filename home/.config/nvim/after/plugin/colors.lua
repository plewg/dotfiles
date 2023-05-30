function ColorMyPencils(color)
    color = color or "monokai"
    vim.cmd.colorscheme(color)
end

ColorMyPencils()
