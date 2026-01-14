return {
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
}
