-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEORE ENABLING THIS FILE
-- Here are some examples:
---@type LazySpec
return { -- == Examples of Adding Plugins ==

  -- customize dashboard options
  -- You can disable default plugins as follows:
  {
    "max397574/better-escape.nvim",
    enabled = false,
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
    "kawre/leetcode.nvim",
    cmd = "Leet", -- only load when you use it
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      -- include a picker of your choice, see picker section for more details
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },

  {
    "numToStr/Comment.nvim",
    enabled = true, -- <- this is required
    event = "VeryLazy",
    opts = {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    },
  },

  -- nvim-ts-context-commentstring setup (optional, but lazy-load with Comment.nvim)
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    enabled = true,
    lazy = true, -- only load when required by Comment.nvim
    opts = {
      enable_autocmd = false, -- important
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "folke/snacks.nvim",
    },
    ft = "python", -- Load when opening Python files
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
    },
    opts = { -- this can be an empty lua table - just showing below for clarity.
      picker = "snacks", -- <— SWITCH TO SNACKS HERE
      search = {}, -- if you add your own searches, they go here.
      options = {}, -- if you add plugin options, they go here.
    },
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
    config = function() vim.keymap.set({ "n", "v" }, "<A-S-w>", require("nvim-emmet").wrap_with_abbreviation) end,
  },
  {
    "andymass/vim-matchup",
    event = "User AstroFile",
    specs = {
      { "nvim-treesitter/nvim-treesitter", optional = true },
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              matchup_matchparen_nomode = "i",
              matchup_matchparen_deferred = 1,
              matchup_matchparen_offscreen = { method = "popup" },
            },
          },
        },
      },
    },

    opts = {
      treesitter = {
        enable = true,
        stopline = 500,
      },
    },
  },
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
  },
}
