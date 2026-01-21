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

  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["yp"] = { "<Plug>(YankyPreviousEntry)" },
          ["yn"] = { "<Plug>(YankyNextEntry)" },
        },
      },
    },
  },
}
