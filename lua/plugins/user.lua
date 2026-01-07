-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
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

  -- {
  --   "serhez/bento.nvim",
  --   opts = {
  --     main_keymap = "<Leader>;",
  --   },
  -- },

  {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    opts = {
      auto_integrations = true,
      integrations = { which_key = true },
    },
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
    "JoosepAlviste/nvim-ts-context-commentstring",
    enabled = true,
    lazy = true,
    opts = {
      enable_autocmd = false,
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
  -- {
  --   "echasnovski/mini.comment",
  --   event = "VeryLazy",
  --   opts = {
  --     options = {
  --       custom_commentstring = function()
  --         return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
  --       end,
  --     },
  --   },
  -- },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "folke/snacks.nvim",
    },
    ft = "python", -- Load when opening Python files
    -- keys = { -- this is in the default opts
    --   { "<Leader>v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
    -- },
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
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        options = {
          g = {
            matchup_matchparen_offscreen = { method = "popup" },
            matchup_treesitter_stopline = 500,
            matchup_treesitter_enabled = true,
          },
        },
      },
    },
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
