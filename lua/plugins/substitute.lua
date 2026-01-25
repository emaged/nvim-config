return {
  {
    "gbprod/substitute.nvim",
    cond = true,
    keys = {
      { "s", function() require("substitute").operator() end, mode = "n" },
      { "ss", function() require("substitute").line() end, mode = "n" },
      { "S", function() require("substitute").eol() end, mode = "n" },
      { "s", function() require("substitute").visual() end, mode = "x" },

      {
        "<localleader>s",
        function() require("substitute.range").operator() end,
        mode = "n",
        desc = "Substitute range",
      },
      { "<localleader>s", function() require("substitute.range").visual() end, mode = "x", desc = "Substitute range" },
      {
        "<localleader>ss",
        function() require("substitute.range").word() end,
        mode = "n",
        desc = "Substitute word",
      },
      {
        "<localleader>sb",
        function() require("substitute.range").operator { range = "%" } end,
        mode = { "n", "v" },
        desc = "Substitute in whole buffer",
      },

      { "sx", function() require("substitute.exchange").operator() end, mode = "n" },
      { "sxx", function() require("substitute.exchange").line() end, mode = "n" },
      { "X", function() require("substitute.exchange").visual() end, mode = "x" },
      { "sxc", function() require("substitute.exchange").cancel() end, mode = "n" },
    },

    opts = function()
      return {
        on_substitute = require("yanky.integration").substitute(),
        highlight_substituted_text = {
          enabled = true,
          timer = 200,
        },
      }
    end,
  },
}
