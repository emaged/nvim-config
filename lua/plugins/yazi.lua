---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>-",
      "<cmd>Yazi<cr>",
      mode = { "n", "v" },
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>_",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<A-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    -- if you want t

    -- enable this if you want to open yazi instead of netrw.
    -- Note that if you enable this, you need to call yazi.setup() to
    -- initialize the plugin. lazy.nvim does this for you in certain cases.
    --
    -- If you are also using neotree, you may prefer not to bring it up when
    -- opening a directory:
    -- {
    --   "nvim-neo-tree/neo-tree.nvim",
    --   opts = {
    --     filesystem = {
    --       hijack_netrw_behavior = "disabled",
    --     },
    --   },
    -- },
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- mark netrw as loaded so it's not loaded at all.
    --
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
