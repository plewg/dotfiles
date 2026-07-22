-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.colorscheme.dracula-nvim" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.bash" },
    { import = "astrocommunity.pack.prettier" },
    { import = "astrocommunity.pack.eslint" },
    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.motion.harpoon" },
    -- import/override with your plugins folder
}
