-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- Customize Treesitter
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { -- Neovim essentials
      "lua",
      "vim",
      "vimdoc", -- Common languages
      "bash",
      "python",
      "javascript",
      "typescript",
      "html",
      "css",
      "json",
      "yaml", -- Your extras
      "c",
      "cpp",
      "java",
      "jinja",
      "php",
      "powershell",
      "ruby",
      "scss",
      "sql",
      "llvm", -- add more arguments for adding more treesitter parsers
      "htmldjango",
      "csv",
      "regex",
      --nvim optional languages
      "latex",
      "norg",
      "markdown",
      "markdown_inline",
      "svelte",
      "typst",
      "vue",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    auto_install = true, -- auto-install missing parsers
  },
}
