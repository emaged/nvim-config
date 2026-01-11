-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- Base community repository
  "AstroNvim/astrocommunity",

  -- catppuccin color theme
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Specific community recipes (import these first)
  -- { import = "astrocommunity.recipes.auto-session-restore" },
  { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.recipes.picker-lsp-mappings" },

  -- Full community plugin pack (import after specific recipes)
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.java" },
  -- { import = "astrocommunity.pack.python" }, -- included in python-ruff
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.toml" },

  -- completion (buggy?)
  -- { import = "astrocommunity.completion.blink-cmp-tmux" },
  -- { import = "astrocommunity.completion.cmp-spell" }, --

  -- Movement
  { import = "astrocommunity.motion.mini-surround" },
  -- { import = "astrocommunity.motion.vim-matchup" }, -- in user plugin file

  -- -- splits & windows
  -- { import = "astrocommunity.split-and-window.edgy-nvim" },

  -- Tools
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.docker" },

  -- Linting && Formatting
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.lsp.nvim-lint" },
  { import = "astrocommunity.editing-support.undotree" },

  -- Utility
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  { import = "astrocommunity.editing-support.yanky-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.search.grug-far-nvim" },

  -- Testing
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.utility.lua-json5" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- Debug
  -- Enable when debugging
  -- { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  -- { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  -- { import = "astrocommunity.debugging.persistent-breakpoint-nvim" },

  -- -- You can also import/override your own plugins after community plugins
  -- -- { import = "your.plugins.override" },
}
