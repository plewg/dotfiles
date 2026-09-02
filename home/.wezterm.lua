local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- font
config.font_size = 14
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")

-- theme
config.bold_brightens_ansi_colors = false
config.colors = {
    foreground = "#F5F5F4",
    background = "#292524",
    cursor_bg = "#F5F5F4",
    -- ansi = {
    --     "#282921",
    --     "#ff2070",
    --     "#b0ff11",
    --     "#ffc16a",
    --     "#56e4ff",
    --     "#ae81ff",
    --     "#91ffef",
    --     "#fafaf0",
    -- },
    ansi = {
        "#292524",
        "#ff2070",
        "#A3E635",
        "#FDDD6C",
        "#36c4ff",
        "#A78BFA",
        "#91efff",
        "#F5F5F4",
    },
    brights = {
        "#7b7558",
        "#ff2070",
        "#A3E635",
        "#FDDD6C",
        "#36c4ff",
        "#A78BFA",
        "#91efff",
        "#F5F5F4",
    },
}

-- window
-- config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_frame = { font = config.font, font_size = config.font_size }
config.keys = {
    {
        key = "t",
        mods = "CTRL|SHIFT",
        action = wezterm.action.DisableDefaultAssignment,
    },
}

return config
