-- if true then return {} end -- REMOVE TO ENABLE THIS FILE
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ------------------------------------------------------------
    -- 🏆 REQUIRED & COMMON PARSERS
    ------------------------------------------------------------
    ensure_installed = {
      -- Neovim core
      "lua",
      "vim",
      "vimdoc",

      -- General programming
      "bash",
      "python",
      "javascript",
      "typescript",
      "html",
      "css",
      "json",
      "yaml",

      -- Extra languages you use
      "c",
      "cpp",
      "java",
      "scss",
      "sql",
      "jsonc",
      "regex",

      -- Markup & docs
      "markdown",
      "markdown_inline",

      -- Templates
      "htmldjango", -- Jinja/Django
      -- "jinja", -- buggy, doesn't show html templates

      -- Web frameworks
      "svelte",
      "vue",

      -- Optional languages
      "php",
      "latex",
      "typst",

      -- Utilities
      "csv",

      -- Less useful / niche (keep only if you use these)
      -- "llvm",
      -- "powershell",
      -- "ruby",
      -- "norg",
    },

    ------------------------------------------------------------
    -- 🚀 PERFORMANCE & SAFETY
    ------------------------------------------------------------
    auto_install = false, -- Install missing parsers automatically
    sync_install = false,

    ------------------------------------------------------------
    -- ✨ HIGHLIGHTING
    ------------------------------------------------------------
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    ------------------------------------------------------------
    -- 🪄 INDENTATION
    ------------------------------------------------------------
    indent = {
      enable = true,
      -- disable = { "python" }, -- optional: Treesitter python indent is imperfect
    },

    ------------------------------------------------------------
    -- 🔥 TREE-SITTER MODULES (Recommended)
    ------------------------------------------------------------
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

    ------------------------------------------------------------
    -- 🧠 RAINBOW / MATCHUP (Optional but great)
    ------------------------------------------------------------
    matchup = { enable = true }, -- improves % jump and matching pairs
  },
}
