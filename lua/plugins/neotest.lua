return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}
    table.insert(
      opts.adapters,
      require "neotest-python" {
        dap = { justMyCode = false },
        args = { "--log-level", "DEBUG" },
        runner = "pytest",
        python = ".venv/bin/python",
        pytest_discover_instances = true,
      }
    )

    -- 👇 THIS replaces require("neotest").setup(...)
    opts.consumers = opts.consumers or {}
    opts.consumers.overseer = require "neotest.consumers.overseer"
  end,
}
