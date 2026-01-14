-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:
---@type LazySpec
return { -- == Examples of Adding Plugins ==
  -- customize dashboard options
  -- You can disable default plugins as follows:
  {
    "max397574/better-escape.nvim",
    enabled = false,
  },
  {
    "nvimtools/none-ls.nvim",
    enabled = false,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    enabled = false,
  },

  -- { "Vimjas/vim-python-pep8-indent" },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = function(_, opts)
      require("luasnip.loaders.from_vscode").lazy_load()
      return opts
    end,
  },

  -- Lorem ipsum generator
  {
    "derektata/lorem.nvim",
    config = function()
      require("lorem").opts {
        sentence_length = "mixed", -- using a default configuration
        comma_chance = 0.3, -- 30% chance to insert a comma
        max_commas = 2, -- maximum 2 commas per sentence
        debounce_ms = 200, -- default debounce time in milliseconds
        -- required by type
        format_defaults = {}, -- empty table is fine
        paragraph_length = "mixed", -- optional, you can customize
        words = {}, -- optional, defaults
      }
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    "olrtg/nvim-emmet",
    ft = { "html", "css", "scss", "sass", "javascript", "htmldjango" },
    config = function() vim.keymap.set({ "n", "v" }, "<A-S-w>", require("nvim-emmet").wrap_with_abbreviation) end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "gS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "dstein64/nvim-scrollview",
    opts = {
      -- signs_on_startup = { "diagnostics" },
      mode = "simple", -- lighter refresh, less flicker
      -- current_only = true, -- fewer windows to redraw
    },
  },

  { "nvim-tree/nvim-web-devicons", opts = {} },
}
