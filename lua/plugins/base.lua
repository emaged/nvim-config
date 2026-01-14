return {
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "gbprod/substitute.nvim",
    cond = true,
    opts = function()
      return {
        on_substitute = require("yanky.integration").substitute(),
        highlight_substituted_text = {
          enabled = true,
          timer = 200,
        },
      }
    end,
    config = function(_, opts)
      require("substitute").setup(opts)
      -- cancel pending range highlights on <Esc>
      vim.keymap.set("n", "<Esc>", function()
        pcall(require("substitute.range").clear_match)
        return "<Esc>"
      end, { expr = true, silent = true })

      -- substitute keymaps
      vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
      vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
      vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
      vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })

      vim.keymap.set("n", "<localleader>s", require("substitute.range").operator, { noremap = true })
      vim.keymap.set("x", "<localleader>s", require("substitute.range").visual, { noremap = true })
      vim.keymap.set(
        "n",
        "<localleader>ss",
        require("substitute.range").word,
        { noremap = true, desc = "Substitute word" }
      )
      vim.keymap.set(
        { "v", "n" },
        "<localleader>sb",
        function() require("substitute.range").operator { range = "%" } end,
        { desc = "Substitute in whole buffer" }
      )

      vim.keymap.set("n", "sx", require("substitute.exchange").operator, { noremap = true })
      vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true })
      vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
      vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true })
    end,
  },

  {
    "gbprod/yanky.nvim",
    opts = function(_, opts)
      local astrocore = require "astrocore"

      local is_windows = vim.fn.has "win32" == 1
      local is_vscode = vim.g.vscode ~= nil

      opts = astrocore.extend_tbl(opts, {

        highlight = { timer = 200 },
        ring = {
          storage = (is_windows or is_vscode) and "shada" or "sqlite",
          -- ignore_registers = { "*", "_" }, -- probably not needed
        },
        system_clipboard = {
          clipboard_register = "+", -- default is primary selection
          sync_with_ring = true,
        },
      })
      return opts
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts)
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"

      -- add django rules
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
}
