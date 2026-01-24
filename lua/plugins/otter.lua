return {
  {
    "jmbuhr/otter.nvim",

    -- Lazy load when needed
    ft = { "html" },

    keys = {
      {
        "<leader>Oa",
        function() require("otter").activate() end,
        desc = "Otter: Activate Javascript",
      },
      {
        "<leader>Ol",
        "<cmd>ls!<cr>",
        desc = "Otter: List buffers",
      },
      {
        "<leader>Oi",
        "<cmd>LspInfo<cr>",
        desc = "Otter: LSP info",
      },
    },

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
