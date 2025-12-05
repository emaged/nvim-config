return {
  "folke/noice.nvim",
  keys = {
    -- Clear search + dismiss Noice
    {
      "<Esc>",
      function()
        -- run your actions
        vim.cmd "nohlsearch"
        vim.cmd "NoiceDismiss"

        -- return <Esc> so Flash sees it
        return "<Esc>"
      end,
      mode = "n",
      expr = true, -- THIS is required so the return value is sent as keys
      silent = true,
      desc = "Clear search + dismiss Noice",
    },
    {
      "<leader>N",
      mode = "n",
      silent = true,
      desc = " Noice",
    },
    -- Noice last message
    {
      "<leader>Nl",
      function() require("noice").cmd "last" end,
      mode = "n",
      desc = "Noice Last Message",
    },
    -- Noice message history
    {
      "<leader>Nh",
      function() require("noice").cmd "history" end,
      mode = "n",
      desc = "Noice History",
    },
    -- Redirect commandline with Shift-Enter
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
    -- Noice LSP scrolling (<C-f>)
    {
      "<C-f>",
      function()
        if not require("noice.lsp").scroll(4) then return "<C-f>" end
      end,
      mode = { "n", "i", "s" },
      expr = true,
      silent = true,
      desc = "Noice LSP scroll (down)",
    },
    -- Noice LSP scrolling (<C-b>)
    {
      "<C-b>",
      function()
        if not require("noice.lsp").scroll(-4) then return "<C-b>" end
      end,
      mode = { "n", "i", "s" },
      expr = true,
      silent = true,
      desc = "Noice LSP scroll (up)",
    },
  },
}
