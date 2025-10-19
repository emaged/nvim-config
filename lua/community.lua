--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- Base community repository
  "AstroNvim/astrocommunity",

  -- catppucin color theme
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Specific community recipes (import these first)
  { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },

  -- Full community plugin pack (import after specific recipes)
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.sql" },

  -- Testing
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.utility.lua-json5" },
  -- You can also import/override your own plugins after community plugins
  -- { import = "your.plugins.override" },
}
