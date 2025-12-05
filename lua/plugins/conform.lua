return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_format" }, -- only ruff
      htmldjango = { "djlint" },
      jinja = { "djlint" },
      ["jinja-html"] = { "djlint" },
      -- c = { "clang-format" },
      -- cpp = { "clang-format" },
    },
  },
}
