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
  -- { import = "astrocommunity.recipes.heirline-vscode-winbar" },

  -- Full community plugin pack (import after specific recipes)
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.sql" },

  -- Movement
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.vim-matchup" },
  -- { import = "astrocommunity.motion.flash-nvim" },

  -- Tools
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.docker" },

  -- Linting && Formatting
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.lsp.nvim-lint" },
  { import = "astrocommunity.editing-support.undotree" },

  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },

  -- Testing
  { import = "astrocommunity.utility.lua-json5" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- You can also import/override your own plugins after community plugins
  -- { import = "your.plugins.override" },
}
