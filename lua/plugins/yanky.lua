return {
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
          ignore_registers = { "*", "_" }, -- probably not needed
        },
        system_clipboard = {
          clipboard_register = "+", -- default is primary selection
          sync_with_ring = true,
        },
      })
      return opts
    end,
  },
  -- hello
  -- hello
  -- hello
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["yp"] = { "<Plug>(YankyPreviousEntry)", desc = "Yank history: previous entry" },
          ["yn"] = { "<Plug>(YankyNextEntry)", desc = "Yank history: next entry" },

          -- Charwise puts (preserve newlines)
          ["yc"] = { "<Plug>(YankyPutAfterCharwise)", desc = "Put charwise (preserve newlines)" },
          ["yC"] = { "<Plug>(YankyPutBeforeCharwise)", desc = "Put charwise before (preserve newlines)" },

          -- Charwise joined puts (inline)
          ["yq"] = { "<Plug>(YankyPutAfterCharwiseJoined)", desc = "Put charwise joined (inline)" },
          ["yQ"] = { "<Plug>(YankyPutBeforeCharwiseJoined)", desc = "Put charwise joined before (inline)" },
        },
      },
    },
  },
}
