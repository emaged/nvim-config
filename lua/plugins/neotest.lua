return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function(_, opts)
      -- for new adapters not in astrocommunity
      -- opts.adapters = opts.adapters or {}
      -- table.insert(
      --   opts.adapters,
      --   require "neotest-python" {
      --     dap = { justMyCode = false },
      --     args = { "--log-level", "DEBUG" },
      --     runner = "pytest",
      --     python = ".venv/bin/python",
      --     pytest_discover_instances = true,
      --   }
      -- )

      -- 👇 THIS replaces require("neotest").setup(...)
      opts.consumers = opts.consumers or {}
      opts.consumers.overseer = require "neotest.consumers.overseer"
    end,
  },
  -- override astrocommunity settings like this
  {
    "nvim-neotest/neotest-python",
    ft = "python",
    opts = {
      dap = { justMyCode = false },
      args = { "--log-level", "DEBUG" },
      runner = "pytest",
      python = ".venv/bin/python",
      pytest_discover_instances = true,
      -- is_test_file = function(file) return file:match "test_.*%.py$" or file:match ".*_test%.py$" end,
      django = true,
    },
  },
}
