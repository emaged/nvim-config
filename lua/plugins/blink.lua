-- lua/plugins/blink.lua
return {
  { -- override blink.cmp plugin
    "Saghen/blink.cmp",
    opts = {
      -- your normal blink settings (optional)
      -- completion = { ... },
      -- sources = { ... },
      keymap = {
        preset = "default",
        ["<CR>"] = false,
        ["<C-space>"] = false,
        ["<A-space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      completion = {
        list = {
          selection = {
            preselect = true, -- auto-select the first candidate
            auto_insert = true, -- keep this OFF unless you want auto-insertion on highlight
          },
        },
      },
      -- for nvim-html-css plugin
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "html-css" },
        providers = {
          ["html-css"] = {
            name = "html-css",
            module = "blink.compat.source",
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      -- enable ghost text
      cmdline = { completion = { ghost_text = { enabled = true } } },
    },
  },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true, -- Automatically loads when required by blink.cmp
    opts = {},
  },
  {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { blink_cmp = true } },
  },
}
