return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      -- neotest dependencies
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- language adapters
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
    },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {
        -- Example for loading neotest-golang with a custom config
        -- adapters = {
        --   ["neotest-golang"] = {
        --     go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
        --     dap_go_enabled = true,
        --   },
        -- },

        ["neotest-python"] = {
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = { justMyCode = false },
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          args = { "--log-level", "DEBUG" },
          -- Runner to use. Will use pytest if available by default.
          -- Can be a function to return dynamic value.
          runner = "pytest",
        },
        ["neotest-plenary"] = {},
        ["neotest-vim-test"] = { ignore_file_types = { "python", "vim", "lua" } },
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function() return vim.fn.getcwd() end,
        },
        ["neotest-vitest"] = {},
      },

      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          local LazyVim = require "lazyvim"
          if LazyVim.has "trouble.nvim" then
            require("plugins.trouble").open { mode = "quickfix", focus = false }
          else
            vim.cmd "copen"
          end
        end,
      },
    },
  },
}
