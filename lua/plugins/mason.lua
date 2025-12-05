--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "basedpyright",
        -- "lua-language-server",
        "clangd",
        "django-template-lsp",
        "emmet-language-server",
        "html-lsp",
        "css-lsp",
        "jinja-lsp",
        "jdtls",
        "json-lsp",
        "some-sass-language-server",
        "stylelint-lsp",
        "sqlls",

        -- install formatters && linters
        "stylua",
        "clang-format",
        "djlint",
        "eslint_d",
        "htmlhint",
        "jsonlint",
        "prettier",
        "prettierd",
        "ruff",
        "selene",
        "stylelint",
        "sql-formatter",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
        --"copilot-language-server",
      },
      -- debounce_hours = 5, -- at least 5 hours between attempts to install/update
    },
  },
}
