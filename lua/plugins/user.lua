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

  {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { which_key = true } },
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
    -- keys = {
    --   { "<leader>v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
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
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "markdown.mdx" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
      local plugin = require("lazy.core.config").spec.plugins["markdown-preview.nvim"]
      vim.g.mkdp_filetypes = require("lazy.core.plugin").values(plugin, "ft", true)
    end,
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Markdown = "" } } },
      {
        "AstroNvim/astrocore",
        optional = true,
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>P"

          maps.n[prefix] = { desc = require("astroui").get_icon("Markdown", 1, true) .. "Markdown" }
          maps.n[prefix .. "p"] = { "<cmd>MarkdownPreview<cr>", desc = "Preview" }
          maps.n[prefix .. "s"] = { "<cmd>MarkdownPreviewStop<cr>", desc = "Stop preview" }
          maps.n[prefix .. "t"] = { "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle preview" }
        end,
      },
    },
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
    "Jezda1337/nvim-html-css",
    ft = {
      "html",
      "htmldjango",
      "tsx",
      "jsx",
      "erb",
      "svelte",
      "vue",
      "blade",
      "php",
      "templ",
      "astro",
    },
    dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using blink.cmp
    opts = {
      enable_on = { -- Example file types
        "html",
        "htmldjango",
        "tsx",
        "jsx",
        "erb",
        "svelte",
        "vue",
        "blade",
        "php",
        "templ",
        "astro",
      },
      handlers = {
        definition = {
          bind = "gD",
        },
        hover = {
          bind = "K",
          wrap = true,
          border = "none",
          position = "cursor",
        },
      },
      documentation = {
        auto_show = true,
      },
      style_sheets = {
        -- "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
        -- "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
        -- "./index.css", -- `./` refers to the current working directory.
      },
    },
  },

  {
    "dstein64/nvim-scrollview",
    opts = {
      diagnostics_severities = {}, -- disable ALL diagnostic markers
    },
  },

  { "nvim-tree/nvim-web-devicons", opts = {} },

  -- {
  --   "saghen/filler-begone.nvim",
  --   dependencies = {
  --     {
  --       "AstroNvim/astrocore",
  --       opts = {
  --         options = {
  --           g = {
  --             filler_begone = false, -- global default
  --           },
  --         },
  --         autocmds = {
  --           filler_begone = {
  --             {
  --               event = "BufEnter",
  --               pattern = "*",
  --               callback = function(args)
  --                 -- set buffer-local behavior for buftype=nofile buffers
  --                 if vim.bo[args.buf].buftype == "nofile" then vim.b[args.buf].filler_begone = true end
  --               end,
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "jedrzejboczar/exrc.nvim",
  --   dependencies = { "neovim/nvim-lspconfig" }, -- (optional)
  --   config = true,
  --   opts = {
  --     exrc_name = ".nvim.lua", -- Name of exrc files to use
  --     on_vim_enter = true, -- Load exrc from current directory on start
  --     on_dir_changed = { -- Automatically load exrc files on DirChanged autocmd
  --       enabled = true,
  --       -- Wait until CursorHold and use vim.ui.select to confirm files to load, instead of loading unconditionally
  --       use_ui_select = true,
  --     },
  --     trust_on_write = true, -- Automatically trust when saving exrc file
  --     use_telescope = true, -- Use telescope instead of vim.ui.select for picking files (if available)
  --     min_log_level = vim.log.levels.DEBUG, -- Disable notifications below this level (TRACE=most logs)
  --     lsp = {
  --       auto_setup = false, -- Automatically configure lspconfig to register on_new_config
  --     },
  --     commands = {
  --       instant_edit_single = true, -- Do not use vim.ui.select if there is only 1 candidate for ExrcEdit* commands
  --     },
  --   },
  -- },
}
