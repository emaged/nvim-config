-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:
---@type LazySpec
return { -- == Examples of Adding Plugins ==
  -- customize dashboard options
  -- You can disable default plugins as follows:
  {
    "danymat/neogen",
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Neogen = "󰷉" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>A"
          maps.n[prefix] = { desc = require("astroui").get_icon("Neogen", 1, true) .. "Annotation" }
          maps.n[prefix .. "<CR>"] = { function() require("neogen").generate { type = "any" } end, desc = "Current" }
          maps.n[prefix .. "c"] = { function() require("neogen").generate { type = "class" } end, desc = "Class" }
          maps.n[prefix .. "f"] = { function() require("neogen").generate { type = "func" } end, desc = "Function" }
          maps.n[prefix .. "t"] = { function() require("neogen").generate { type = "type" } end, desc = "Type" }
          maps.n[prefix .. "F"] = { function() require("neogen").generate { type = "file" } end, desc = "File" }
        end,
      },
    },
    cmd = "Neogen",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        javascript = { template = { annotation_convention = "jsdoc" } },
        javascriptreact = { template = { annotation_convention = "jsdoc" } },
        lua = { template = { annotation_convention = "ldoc" } },
        ruby = { template = { annotation_convention = "yard" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        typescriptreact = { template = { annotation_convention = "tsdoc" } },
      },
    },
  },

  {
    "max397574/better-escape.nvim",
    enabled = false,
  },

  -- { "Vimjas/vim-python-pep8-indent" },

  -- {
  --   "gbprod/yanky.nvim",
  --   opts = {
  --     highlight = {
  --       on_put = false,
  --       timer = 150,
  --     },
  --   },
  -- },

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
          plain_below = "g?p",
          plain_above = "g?P",
          variable_below = "g?v",
          variable_above = "g?V",
          surround_plain = "g?sp",
          surround_variable = "g?sv",
          textobj_below = "g?o",
          textobj_above = "gpO",
          textobj_surround = "g?so",
          -- management (gpx…)
          toggle_comment_debug_prints = "g?xc",
          delete_debug_prints = "g?xd",
          reset_counter = "g?xr", -- not in docs but supported
          search = "g?xs",
          qflist = "g?xq",
        },

        insert = {
          plain = "<C-G>p",
          variable = "<C-G>v",
        },
        visual = {
          variable_below = "g?v",
          variable_above = "g?V",
        },
      },
    },
    keys = {
      { "g?xr", "<cmd>Debugprint resetcounter<CR>", desc = "Reset debug print counter" },
      { "g?xs", "<cmd>Debugprint search<CR>", desc = "Search debug prints (project)" },
      { "g?xq", "<cmd>Debugprint qflist<CR>", desc = "Debug prints → quickfix" },
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
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", optional = true },
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              matchup_matchparen_nomode = "i",
              matchup_matchparen_deferred = 1,
              matchup_matchparen_offscreen = { method = "popup" },
              matchup_treesitter_stopline = 500,
              matchup_treesitter_enabled = true,
            },
          },
        },
      },
    },
    config = function()
      -- Disable matchup highlighting only for Django / Jinja templates
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "htmldjango", "django", "jinja", "jinja2" },
        callback = function()
          vim.b.matchup_matchparen_enabled = 0
          -- vim.b.matchup_matchparen_fallback = 0
        end,
      })
    end,
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
