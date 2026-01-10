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

  { "rafamadriz/friendly-snippets" },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = function(_, opts)
      require("luasnip.loaders.from_vscode").lazy_load()
      return opts
    end,
  },

  {
    "stevearc/overseer.nvim",
    dependencies = { "franco-ruggeri/overseer-extra.nvim" },
    opts = function(_, opts)
      opts.templates = opts.templates or {}
      vim.list_extend(opts.templates, { "extra" })
      return opts
    end,
  },

  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh 1",
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    keys = {
      -- Run current line / motion / selection
      { "<Leader>rr", "<Plug>SnipRun", mode = { "n", "v" }, desc = "Run snippet / selection" },
      { "<Leader>rf", "<Plug>SnipRunOperator", desc = "Run via operator (motion)" },

      -- Info & status
      { "<Leader>ri", "<Plug>SnipInfo", desc = "SnipRun info" },

      -- Session management
      { "<Leader>rz", "<Plug>SnipReset", desc = "Reset SnipRun" },
      { "<Leader>rc", "<Plug>SnipReplMemoryClean", desc = "Clear SnipRun REPL memory" },
      { "<Leader>rx", "<Plug>SnipClose", desc = "Close SnipRun windows" },

      -- Live mode (auto-run on edit)
      -- { "<Leader>rl", "<Plug>SnipLive", desc = "Toggle SnipRun live mode" },
    },

    config = function()
      require("sniprun").setup {
        selected_interpreters = { "Python3_fifo" },
        repl_enable = { "Python3_fifo" },

        display = { "Terminal" },
        display_options = {
          terminal_scrollback = vim.o.scrollback, -- change terminal display scrollback lines
          terminal_line_number = false, -- whether show line number in terminal window
          terminal_signcolumn = false, -- whether show signcolumn in terminal window
          terminal_position = "vertical", --# or "horizontal", to open as horizontal split instead of vertical split
          -- terminal_width = 45, --# change the terminal display option width (if vertical)
          -- terminal_height = 20, --# change the terminal display option height (if horizontal)
        },
      }
    end,
  },

  {
    "andrewferrier/debugprint.nvim",
    dependencies = {
      -- "nvim-mini/mini.hipatterns", -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)
      "folke/snacks.nvim", -- Optional: If you want to use the `:Debugprint search` command with snacks.nvim
    },
    lazy = false,
    version = "*",
    opts = {
      keymaps = {
        normal = {
          -- creation
          plain_below = "gpp",
          plain_above = "gpP",
          variable_below = "gpv",
          variable_above = "gpV",
          surround_plain = "gpsp",
          surround_variable = "gpsv",
          textobj_below = "gpo",
          textobj_above = "gpO",
          textobj_surround = "gpso",

          -- management (gpx…)
          toggle_comment_debug_prints = "gpxc",
          delete_debug_prints = "gpxd",
          reset_counter = "gpxr", -- not in docs but supported
          search = "gpxs",
          qflist = "gpxq",
        },
        insert = {
          plain = "<C-G>p",
          variable = "<C-G>v",
        },
        visual = {
          variable_below = "gpv",
          variable_above = "gpV",
        },
      },
    },
    keys = {
      { "gpxr", "<cmd>Debugprint resetcounter<CR>", desc = "Reset debug print counter" },
      { "gpxs", "<cmd>Debugprint search<CR>", desc = "Search debug prints (project)" },
      { "gpxq", "<cmd>Debugprint qflist<CR>", desc = "Debug prints → quickfix" },
    },
  },

  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
    keys = {
      {
        "<Leader>db",
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        desc = "Toggle Breakpoint",
        silent = true,
      },
      {
        "<Leader>dB",
        function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
        desc = "Clear Breakpoints",
        silent = true,
      },
      {
        "<Leader>dC",
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        desc = "Conditional Breakpoint",
        silent = true,
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts)

      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"

      npairs.add_rules {
        Rule("%", "%", { "htmldjango", "django" })
          :with_pair(function(opts)
            -- Only double % when it follows {
            return opts.line:sub(opts.col - 1, opts.col - 1) == "{"
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(cond.none()),

        Rule("#", "#", { "htmldjango", "django" })
          :with_pair(function(opts) return opts.line:sub(opts.col - 1, opts.col - 1) == "{" end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(cond.none()),
      }
    end,
  },

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
